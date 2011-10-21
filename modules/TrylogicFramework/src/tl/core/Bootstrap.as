package tl.core
{
	import flash.display.*;

	import tl.bootloader.ApplicationLoader;
	import tl.ioc.*;
	import tl.viewController.IApplicationController;

	[Frame(factoryClass="tl.core.TrylogicApplicationLoader")]
	public class Bootstrap
	{
		public var backgroundColor : Number;
		public var frameRate : Number;
		public var preloader : Class;

		public var applicationControllerClass : Class;

		public function Bootstrap()
		{
			super();
		}

		public function set iocMap( value : Array ) : void
		{
			for each( var assoc : Associate in value )
			{
				IoCHelper.registerType( assoc.iface, assoc.withClass );
			}
		}

		internal final function init( applicationLoader : ApplicationLoader ) : void
		{
			if ( applicationControllerClass == null )
			{
				throw new ArgumentError( "applicationControllerClass of Application must be non-null and implements IApplicationController" );
			}

			IoCHelper.registerType( IApplicationController, applicationControllerClass );

			var appController : IApplicationController = IoCHelper.resolve( IApplicationController, this );

			appController.loadView();

			appController.viewBeforeAddedToStage();

			applicationLoader.addChild( appController.view as DisplayObject );
		}
	}
}
