package tl.core
{
	import flash.display.*;
	import flash.events.IEventDispatcher;
	import flash.net.*;

	import mx.core.IFlexModuleFactory;

	import flash.events.*;
	import flash.system.*;

	import nochump.util.zip.*;

	/**
	 * ...
	 * @author
	 */
	[Mixin]
	public class LibraryLoader
	{
		static var rsls:Array;
		static var rslCount:uint;

		static var onProgressHandler:Function;
		static var onCompleteHandler:Function;

		static var currentLib:String;
		public static var RSLS:Array;

		public static function process (loader:IFlexModuleFactory, onProgress:Function, onComplete:Function):void
		{
			rsls = RSLS;
			if (rsls == null || rsls.length == 0)
			{
				onComplete();
				return;
			}
			rslCount = rsls.length;
			onProgressHandler = onProgress;
			onCompleteHandler = onComplete;
			loadRsls();

		}

		protected static function loadRsls (e:Event = null):void
		{

			if (e)
			{
				IEventDispatcher(e.target).removeEventListener(e.type, arguments.callee);
				//IEventDispatcher(e.target).removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				IEventDispatcher(e.target).removeEventListener(ProgressEvent.PROGRESS, libraryLoadingProgress);
			}


			if (rsls.length == 0)
			{
				onCompleteHandler();
				return;
			}

			var url:String = rsls.shift();
			var filename:String = url.substring(url.lastIndexOf("/") + 1);
			filename = filename.substr(0, filename.indexOf("?") == -1 ? int.MAX_VALUE : filename.indexOf("?"));
			var fileExt:String = filename.substr(filename.lastIndexOf(".") + 1);
			if (fileExt == "swc")
			{
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(ProgressEvent.PROGRESS, libraryLoadingProgress);
				//loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				loader.addEventListener(Event.COMPLETE, libraryLoaded);
				loader.dataFormat = URLLoaderDataFormat.BINARY;

				currentLib = filename;
				loader.load(new URLRequest(url));
			}
			else if (fileExt == "swf")
			{
				/*
				 var ldr : flash.display.Loader = new flash.display.Loader();
				 ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadRsls);
				 //ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				 ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, libraryLoadingProgress);
				 currentLib = filename;
				 ldr.load(new URLRequest(url), new LoaderContext(false, ApplicationDomain.currentDomain));
				 */

				var loader:URLLoader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.addEventListener(Event.COMPLETE, swfLoaded);
				currentLib = filename;

				loader.load(new URLRequest(url));
			}
			else
			{
				loadRsls();
			}
		}

		private static function ioErrorHandler (e:Event):void
		{

		}

		protected static function swfLoaded (e:Event):void
		{
			var libraryParser:flash.display.Loader = new flash.display.Loader();
			libraryParser.contentLoaderInfo.addEventListener(Event.COMPLETE, loadRsls);
			libraryParser.loadBytes(URLLoader(e.target).data, new LoaderContext(false, ApplicationDomain.currentDomain));
		}

		protected static function libraryLoadingProgress (e:ProgressEvent):void
		{
			onProgressHandler((((1 - rsls.length / rslCount) / 2)) + ((e.bytesTotal != 0) ? ((e.bytesLoaded / e.bytesTotal) * 0.1) : 0), "Loading library: " + currentLib + "(" + e.bytesLoaded + "/" + e.bytesTotal + ")");
		}


		protected static function libraryLoaded (e:Event):void
		{
			var target:IEventDispatcher = IEventDispatcher(e.target);
			target.removeEventListener(Event.COMPLETE, libraryLoaded);
			//target.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			target.removeEventListener(ProgressEvent.PROGRESS, libraryLoadingProgress);

			var zipFile:ZipFile = new ZipFile(URLLoader(e.target).data);

			for each(var entity:ZipEntry in zipFile.entries)
			{
				onProgressHandler((1 - rsls.length / rslCount) / 2, "Parsing library: " + currentLib);
				if (entity.name == "library.swf")
				{
					var libraryParser:flash.display.Loader = new flash.display.Loader();
					libraryParser.contentLoaderInfo.addEventListener(Event.COMPLETE, loadRsls);
					libraryParser.loadBytes(zipFile.getInput(entity), new LoaderContext(false, ApplicationDomain.currentDomain));
					return;
				}
			}
			loadRsls();
		}
	}

}
