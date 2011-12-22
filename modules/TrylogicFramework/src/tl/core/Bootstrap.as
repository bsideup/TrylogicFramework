package tl.core
{
	import flash.display.*;
	import flash.system.ApplicationDomain;

	import tl.factory.ServiceFactory;
	import tl.ioc.*;
	import tl.service.IService;
	import tl.utils.describeTypeCached;
	import tl.view.IView;

	[Frame(factoryClass="tl.core.TrylogicApplicationLoader")]
	public class Bootstrap
	{
		{
			IoCHelper.registerType( Stage, TrylogicStage );
		}

		public var backgroundColor : Number;
		public var frameRate : Number;
		public var preloader : Class;

		public var applicationView : IView;

		public function set iocMap( value : Vector.<Associate> ) : void
		{
			for each( var assoc : Associate in value )
			{
				IoCHelper.registerAssociate( assoc );
			}
		}

		public function set services( value : Vector.<IService> ) : void
		{
			for each( var service : IService in value )
			{
				ServiceFactory.registerService( ApplicationDomain.currentDomain.getDefinition( describeTypeCached( service ).@name.toString() ) as Class, service );
				service.init();
			}
		}

		internal final function init( applicationLoader : TrylogicApplicationLoader ) : void
		{
			if ( applicationView == null )
			{
				throw new ArgumentError( "applicationView of Bootstrap cant be non-null" );
			}

			IoCHelper.resolve( Stage, applicationLoader );

			applicationView.controller.addViewToContainer( applicationLoader );
		}
	}
}
