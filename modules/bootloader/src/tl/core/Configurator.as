package tl.core
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.*;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;

	import mx.core.IFlexModuleFactory;

	/**
	 * ...
	 * @author
	 */
	[Mixin]
	public class Configurator
	{
		static var configs : Array = [];
		static var rawConfigs : Array;
		static var configsCount : uint;

		static var onProgressHandler : Function;
		static var onCompleteHandler : Function;

		static var currentConfig : Array;
        public static var CONFIGURATIONS:Array = [];

		public static function process(loader : IFlexModuleFactory, onProgress : Function, onComplete : Function) : void
		{
			rawConfigs = CONFIGURATIONS;
			if (rawConfigs == null || rawConfigs.length == 0)
			{
				onComplete();
				return;
			}
			configsCount = rawConfigs.length;
			onProgressHandler = onProgress;
			onCompleteHandler = onComplete;
			loadConfigs();
		}

		public static function getConst(name : String) : XML
		{
			var config : XML = configs[name];
			if (config == null) config = new XML();
			return config;
		}

		static function loadConfigs(e : Event = null) : void
		{
			if (rawConfigs == null || rawConfigs.length == 0)
			{
				onCompleteHandler();
				return;
			}

			onProgressHandler((1 - rawConfigs.length / configsCount) / 2 + 0.1, "Fetching config");

			currentConfig = rawConfigs.shift();

			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, xmlLoaded);
			loader.addEventListener(ProgressEvent.PROGRESS, libraryLoadingProgress);
			var request : URLRequest = new URLRequest(currentConfig[1]);
			request.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
			loader.load(request);
		}

		static function libraryLoadingProgress(e : ProgressEvent) : void
		{
			onProgressHandler((((1 - rawConfigs.length / configsCount) / 2)) + ((e.bytesTotal != 0) ? ((e.bytesLoaded / e.bytesTotal) * 0.1) : 0), "Loading config: " + currentConfig[1] + "(" + e.bytesLoaded + "/" + e.bytesTotal + ")");
		}

		static function xmlLoaded(e : Event) : void
		{
			configs[currentConfig[0]] = XML(URLLoader(e.target).data.replace(/\s+/g, " "));
			loadConfigs();
		}

	}

}
