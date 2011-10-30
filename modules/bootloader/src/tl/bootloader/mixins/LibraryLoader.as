package tl.bootloader.mixins
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.ByteArray;

	import mx.core.IFlexModuleFactory;

	import nochump.util.zip.*;

	[Mixin]
	/**
	 * Basic RSL Loader Mixin.
	 *
	 * <a href="http://livedocs.adobe.com/flex/3/html/help.html?content=rsl_09.html">http://livedocs.adobe.com/flex/3/html/help.html?content=rsl_09.html</a>
	 *
	 */ public class LibraryLoader
	{
		static private var rsls : Array;
		static private var rslCount : uint;

		static private var onProgressHandler : Function;
		static private var onCompleteHandler : Function;

		static private var currentRSLData : *;

		/**
		 * Application loader function
		 * @param loader
		 * @param onProgress
		 * @param onComplete
		 */
		public static function process( loader : IFlexModuleFactory, onProgress : Function, onComplete : Function ) : void
		{
			rsls = loader.info()["cdRsls"];

			if ( rsls == null || rsls.length == 0 )
			{
				onComplete();
				return;
			}
			rslCount = rsls.length;
			onProgressHandler = onProgress;
			onCompleteHandler = onComplete;
			loadRsls();

		}

		private static function loadRsls( e : Event = null ) : void
		{
			if ( e )
			{
				IEventDispatcher( e.target ).removeEventListener( e.type, arguments.callee );
				//IEventDispatcher(e.target).removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				IEventDispatcher( e.target ).removeEventListener( ProgressEvent.PROGRESS, libraryLoadingProgress );
			}

			if ( rsls.length == 0 )
			{
				onCompleteHandler();
				return;
			}

			currentRSLData = rsls.shift();

			var urlRequest : URLRequest = new URLRequest( currentRSLData.rsls[0] );

			if ( currentRSLData.policyFiles[0] != "" )
			{
				Security.loadPolicyFile( currentRSLData.policyFiles[0] );
			}

			if ( currentRSLData.isSigned[0] )
			{
				urlRequest.digest = currentRSLData.digests[0];
			}

			var url : String = urlRequest.url;
			var filename : String = url.substring( url.lastIndexOf( "/" ) + 1 );
			filename = filename.substr( 0, filename.indexOf( "?" ) == -1 ? int.MAX_VALUE : filename.indexOf( "?" ) );
			var fileExt : String = filename.substr( filename.lastIndexOf( "." ) + 1 );

			var loader : URLLoader = new URLLoader();
			if ( fileExt == "swc" )
			{
				loader.addEventListener( Event.COMPLETE, libraryLoaded );

			} else if ( fileExt == "swf" || fileExt == "swz" )
			{
				loader.addEventListener( Event.COMPLETE, swfLoaded );

			} else
			{
				loadRsls();
				return;
			}

			loader.addEventListener( ProgressEvent.PROGRESS, libraryLoadingProgress );
			loader.dataFormat = URLLoaderDataFormat.BINARY;

			trace( urlRequest.url );

			loader.load( urlRequest );
		}

		private static function ioErrorHandler( e : Event ) : void
		{

		}

		private static function swfLoaded( e : Event ) : void
		{
			var urlLoader : URLLoader = URLLoader( e.target );
			if ( urlLoader == null || urlLoader.data == null || ByteArray( urlLoader.data ).bytesAvailable == 0 )
			{
				return;
			}

			var libraryParser : Loader = new Loader();
			libraryParser.contentLoaderInfo.addEventListener( Event.COMPLETE, loadRsls );

			var context : LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			context.securityDomain = null;
			if ( context.hasOwnProperty( "allowCodeImport" ) )
			{
				context['allowCodeImport'] = true;
			}

			libraryParser.loadBytes( urlLoader.data, context );
		}

		private static function libraryLoadingProgress( e : ProgressEvent ) : void
		{
			onProgressHandler( (((1 - rsls.length / rslCount) / 2)) + ((e.bytesTotal != 0) ? ((e.bytesLoaded / e.bytesTotal) * 0.1) : 0), "Loading library: " + currentRSLData + "(" + e.bytesLoaded + "/" + e.bytesTotal + ")" );
		}

		private static function libraryLoaded( e : Event ) : void
		{
			var target : IEventDispatcher = IEventDispatcher( e.target );
			target.removeEventListener( Event.COMPLETE, libraryLoaded );
			//target.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			target.removeEventListener( ProgressEvent.PROGRESS, libraryLoadingProgress );

			var zipFile : ZipFile = new ZipFile( URLLoader( e.target ).data );

			for each( var entity : ZipEntry in zipFile.entries )
			{
				onProgressHandler( (1 - rsls.length / rslCount) / 2, "Parsing library: " + currentRSLData );
				if ( entity.name == "library.swf" )
				{
					var libraryParser : Loader = new Loader();
					libraryParser.contentLoaderInfo.addEventListener( Event.COMPLETE, loadRsls );
					libraryParser.loadBytes( zipFile.getInput( entity ), new LoaderContext( false, ApplicationDomain.currentDomain ) );
					return;
				}
			}
			loadRsls();
		}
	}

}
