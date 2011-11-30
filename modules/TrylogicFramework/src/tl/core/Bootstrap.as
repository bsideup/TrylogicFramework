package tl.core
{
	import flash.display.*;
	import flash.system.ApplicationDomain;

	import tl.factory.ServiceFactory;
	import tl.factory.SingletonFactory;
	import tl.ioc.*;
	import tl.service.IService;
	import tl.service.Service;
	import tl.utils.describeTypeCached;
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
			IoCHelper.registerType( ISingleViewController, SingleViewController );

			IoCHelper.registerType( IService, Service );
		}

		public var backgroundColor : Number;
		public var frameRate : Number;
		public var preloader : Class;

		public var applicationControllerClass : Class;

		public var iocMap : Vector.<Associate> = new <Associate>[];
		public var services : Vector.<IService> = new <IService>[];

		internal final function init( applicationLoader : TrylogicApplicationLoader ) : void
		{
			if ( applicationControllerClass == null )
			{
				throw new ArgumentError( "applicationControllerClass of Bootstrap must be non-null and implements IApplicationController" );
			}

			IoCHelper.resolve( Stage, applicationLoader );

			IoCHelper.registerType( IApplicationController, applicationControllerClass, SingletonFactory );

			for each( var assoc : Associate in iocMap )
			{
				IoCHelper.registerAssociate( assoc );
			}

			for each( var service : IService in services )
			{
				ServiceFactory.registerService( ApplicationDomain.currentDomain.getDefinition( describeTypeCached( service ).@name.toString() ) as Class, service );
				service.init();
			}

			IoCHelper.resolve( IApplicationController, this ).addViewToContainer( applicationLoader );
		}
	}
}
