package tl.core
{
	import flash.display.*;
    import flash.display.DisplayObject;
    import flash.events.*;
	import flash.system.*;
	import flash.utils.Dictionary;

	import mx.core.IFlexModuleFactory;


	/**
	 * ...
	 * @author
	 */
	public class ApplicationLoader extends MovieClip implements IFlexModuleFactory
	{
		protected var preloader : IPreloader;

		public function ApplicationLoader()
		{
			Security.allowDomain("*");

			stop();

			if (stage) StageScaleMode.NO_SCALE;

			preloader = addChild(new (info()["preloader"] == null ? PreloaderBase : info()["preloader"])(this)) as IPreloader;

			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}

		protected function enterFrameHandler(e : Event) : void
		{
			if (framesLoaded >= totalFrames)
			{
				removeEventListener(e.type, arguments.callee);

				preloader.process(loadApplication);
			}
			else
			{
				preloader['progress'] = (root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal) / 2;
			}
		}


		protected function loadApplication(e : Event = null) : void
		{
			nextFrame();
			removeChild(DisplayObject(preloader));
			addChild(create() as DisplayObject);
		}

		/* INTERFACE mx.core.IFlexModuleFactory */

		public function get preloadedRSLs() : Dictionary
		{
			return null;
		}

		public function allowDomain(...domains) : void
		{

		}

		public function allowInsecureDomain(...domains) : void
		{

		}

		public function callInContext(fn : Function, thisArg : Object, argArray : Array, returns : Boolean = true) : *
		{

		}

		public function create(...parameters) : Object
		{
			return null;
		}

		public function getImplementation(interfaceName : String) : Object
		{
			return null;
		}

		public function info() : Object
		{
			return null;
		}

		public function registerImplementation(interfaceName : String, impl : Object) : void
		{

		}

	}

}
