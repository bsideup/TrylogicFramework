package tl.bootloader
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Dictionary;

	import mx.core.IFlexModuleFactory;
	import mx.managers.SystemManager;

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

		public function get preloadedRSLs() : Dictionary
		{
			return null;
		}

		public function allowDomain( ... rest ) : void
		{
		}

		public function allowInsecureDomain( ... rest ) : void
		{
		}

		public function callInContext( fn : Function, thisArg : Object, argArray : Array, returns : Boolean = true ) : *
		{
			return null;
		}

		public function create( ... rest ) : Object
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
