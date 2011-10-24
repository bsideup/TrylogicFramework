package tl.bootloader.mixins
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.*;

	import mx.core.IFlexModuleFactory;

	[Mixin]
	/**
	 * Basic Configuration loader Mixin
	 *
	 * In PreloaderBase extender, setup <code>ConfigurationLoader.CONFIGURATIONS = [...]</code>
	 *
	 * @example
	 * <listing version="3.0">
	 *	 ConfigurationLoader.CONFIGURATIONS =
	 *	 [
	 *			 "http://www.mySite.com/configs/myConfig.xml",
	 *			 "http://www.mySite.com/configs/myAnotherConfig.xml"
	 *	 ];
	 * </listing>
	 *
	 */ public class ConfigurationLoader
	{
		private static var configs : Array = [];
		private static var rawConfigs : Array;
		private static var configsCount : uint;

		private static var onProgressHandler : Function;
		private static var onCompleteHandler : Function;

		private static var currentConfig : Array;

		/**
		 * List of configuration sources
		 *
		 */
		public static var CONFIGURATIONS : Array = [];

		/**
		 * Application loader function
		 * @param loader
		 * @param onProgress
		 * @param onComplete
		 */
		public static function process( loader : IFlexModuleFactory, onProgress : Function, onComplete : Function ) : void
		{
			rawConfigs = CONFIGURATIONS;
			if ( rawConfigs == null || rawConfigs.length == 0 )
			{
				onComplete();
				return;
			}
			configsCount = rawConfigs.length;
			onProgressHandler = onProgress;
			onCompleteHandler = onComplete;
			loadConfigs();
		}

		/**
		 * Get constant from loaded configs
		 *
		 * @param name	Constant identifier
		 * @return
		 */
		public static function getConst( name : String ) : XML
		{
			var config : XML = configs[name];
			if ( config == null ) config = new XML();
			return config;
		}

		private static function loadConfigs( e : Event = null ) : void
		{
			if ( rawConfigs == null || rawConfigs.length == 0 )
			{
				onCompleteHandler();
				return;
			}

			onProgressHandler( (1 - rawConfigs.length / configsCount) / 2 + 0.1, "Fetching config" );

			currentConfig = rawConfigs.shift();

			var loader : URLLoader = new URLLoader();
			loader.addEventListener( Event.COMPLETE, xmlLoaded );
			loader.addEventListener( ProgressEvent.PROGRESS, libraryLoadingProgress );

			var request : URLRequest = new URLRequest( currentConfig[1] );
			request.requestHeaders.push( new URLRequestHeader( "pragma", "no-cache" ) );
			loader.load( request );
		}

		private static function libraryLoadingProgress( e : ProgressEvent ) : void
		{
			onProgressHandler( (((1 - rawConfigs.length / configsCount) / 2)) + ((e.bytesTotal != 0) ? ((e.bytesLoaded / e.bytesTotal) * 0.1) : 0), "Loading config: " + currentConfig[1] + "(" + e.bytesLoaded + "/" + e.bytesTotal + ")" );
		}

		private static function xmlLoaded( e : Event ) : void
		{
			configs[currentConfig[0]] = XML( URLLoader( e.target ).data.replace( /\s+/g, " " ) );
			loadConfigs();
		}

	}

}
