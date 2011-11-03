package tl.core
{
	import flash.display.*;

	import tl.ioc.*;
	import tl.service.IService;
	import tl.service.Service;
	import tl.view.*;
	import tl.viewController.*;

	[Frame(factoryClass="tl.core.TrylogicApplicationLoader")]
	public class Bootstrap
	{
		{
			IoCHelper.registerType( Stage, TrylogicStage );

			IoCHelper.registerType( IViewContainer, ViewContainer );
			IoCHelper.registerType( IView, View );
			IoCHelper.registerType( IVIewController, ViewController );
			IoCHelper.registerType( IViewControllerContainer, ViewControllerContainer );
			IoCHelper.registerType( IService, Service );
		}

		public var backgroundColor : Number;
		public var frameRate : Number;
		public var preloader : Class;

		public var applicationControllerClass : Class;

		public var iocMap : Array = [];
		public var services : Array = [];

		internal final function init( applicationLoader : TrylogicApplicationLoader ) : void
		{
			if ( applicationControllerClass == null )
			{
				throw new ArgumentError( "applicationControllerClass of Bootstrap must be non-null and implements IApplicationController" );
			}

			IoCHelper.resolve( Stage, applicationLoader );

			IoCHelper.registerType( IApplicationController, applicationControllerClass );

			for each( var assoc : Associate in iocMap )
			{
				IoCHelper.registerType( assoc.iface, assoc.withClass );
			}

			for each( var service : IService in services )
			{
				service.init();
			}

			var appController : IApplicationController = IoCHelper.resolve( IApplicationController, this );

			appController.viewBeforeAddedToStage();

			applicationLoader.addChild( appController.view as DisplayObject );
		}
	}
}
