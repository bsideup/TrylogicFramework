package tl.core
{
	import flash.display.DisplayObject;

	import tl.bootloader.ApplicationLoader;

	public class TrylogicApplicationLoader extends ApplicationLoader
	{
		override protected function loadApplication() : void
		{
			nextFrame();
			removeChild( DisplayObject( preloader ) );

			var bootstrap : Bootstrap = create() as Bootstrap;

			bootstrap.init( this );
		}
	}
}
