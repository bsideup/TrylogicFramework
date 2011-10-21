package tl.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;

	import tl.bootloader.ApplicationLoader;

	public class TrylogicApplicationLoader extends ApplicationLoader
	{
		override protected function loadApplication( e : Event = null ) : void
		{
			nextFrame();
			removeChild( DisplayObject( preloader ) );

			var bootstrap : Bootstrap = create() as Bootstrap;

			bootstrap.init( this );
		}
	}
}
