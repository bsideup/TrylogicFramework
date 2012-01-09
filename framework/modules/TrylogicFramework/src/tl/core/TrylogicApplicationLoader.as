package tl.core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;

	import tl.bootloader.ApplicationLoader;
	import tl.ioc.IoCHelper;

	public class TrylogicApplicationLoader extends ApplicationLoader
	{
		override protected function loadApplication() : void
		{
			nextFrame();
			removeChild( DisplayObject( preloader ) );

			IoCHelper.registerType( Stage, TrylogicStage );
			IoCHelper.resolve( Stage, this );

			Bootstrap( create() ).init( this );
		}
	}
}