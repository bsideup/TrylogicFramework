package tl.bootloader
{
	import flash.display.*;
	import flash.events.*;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	import mx.core.*;

	/**
	 * Basic ApplicationLoader. Create Preloader from "preloader" property of the Main class instance
	 *
	 * @See PreloaderBase
	 */

	public class ApplicationLoader extends MovieClip implements IFlexModuleFactory
	{

		/**
		 * PreloaderBase instance. Each your preloader must extends PreloaderBase
		 *
		 * @see PreloaderBase
		 */
		protected var preloader : PreloaderBase;

		public function ApplicationLoader()
		{
			stop();

			var preloaderClass : Class = info()["preloader"];

			if ( preloaderClass == null ||
					(ApplicationDomain.currentDomain.hasDefinition( "mx.preloaders::SparkDownloadProgressBar" ) && preloaderClass == ApplicationDomain.currentDomain.getDefinition( 'mx.preloaders::SparkDownloadProgressBar' ))
					)
			{
				preloaderClass = PreloaderBase;
			}

			preloader = addChild( new preloaderClass( this ) ) as PreloaderBase;

			addEventListener( Event.ENTER_FRAME, enterFrameHandler );
		}

		private function enterFrameHandler( e : Event ) : void
		{
			if ( framesLoaded >= totalFrames )
			{
				removeEventListener( e.type, arguments.callee );

				preloader.process( loadApplication );
			} else
			{
				preloader.setProgress( root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal );
			}
		}

		/**
		 * By default, Application loader add new Main Class to stage.
		 * You can override this method, but DO NOT FORGET to call nextFrame(); and removeChild( preloader ): !!!
		 *
		 */
		protected function loadApplication() : void
		{
			nextFrame();
			removeChild( preloader );
			addChild( create() as DisplayObject );
		}

		public function get allowDomainsInNewRSLs() : Boolean
		{
			return false;
		}

		public function set allowDomainsInNewRSLs( value : Boolean ) : void
		{
		}

		public function get allowInsecureDomainsInNewRSLs() : Boolean
		{
			return false;
		}

		public function set allowInsecureDomainsInNewRSLs( value : Boolean ) : void
		{
		}

		public function get preloadedRSLs() : Dictionary
		{
			return null;
		}

		public function addPreloadedRSL( loaderInfo : LoaderInfo, rsl : Vector.<RSLData> ) : void
		{
		}

		public function allowDomain( ...rest ) : void
		{
		}

		public function allowInsecureDomain( ...rest ) : void
		{
		}

		public function callInContext( fn : Function, thisArg : Object, argArray : Array, returns : Boolean = true ) : *
		{
			return null;
		}

		public function create( ...rest ) : Object
		{
			return null;
		}

		public function getImplementation( interfaceName : String ) : Object
		{
			return null;
		}

		public function info() : Object
		{
			return null;
		}

		public function registerImplementation( interfaceName : String, impl : Object ) : void
		{
		}
	}

}