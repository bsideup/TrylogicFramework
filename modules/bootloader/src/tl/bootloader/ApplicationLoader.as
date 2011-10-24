package tl.bootloader
{
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	import flash.utils.Dictionary;

	import mx.core.IFlexModuleFactory;
	import mx.core.RSLData;

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
			Security.allowDomain( "*" );

			stop();

			preloader = addChild( new (info()["preloader"] == null ? PreloaderBase : info()["preloader"])( this ) ) as PreloaderBase;

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
				preloader['progress'] = (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal) / 2;
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

		/* INTERFACE mx.core.IFlexModuleFactory */

		public function get preloadedRSLs() : Dictionary
		{
			return null;
		}

		public function allowDomain( ...domains ) : void
		{

		}

		public function allowInsecureDomain( ...domains ) : void
		{

		}

		public function callInContext( fn : Function, thisArg : Object, argArray : Array, returns : Boolean = true ) : *
		{

		}

		public function create( ...parameters ) : Object
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

		public function addPreloadedRSL( loaderInfo : LoaderInfo, rsl : Vector.<RSLData> ) : void
		{
		}
	}

}
