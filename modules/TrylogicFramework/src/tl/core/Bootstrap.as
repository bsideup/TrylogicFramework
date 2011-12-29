package tl.core
{
	import flash.display.*;

	import mx.core.IStateClient2;

	import tl.factory.ConstructorFactory;
	import tl.factory.ServiceFactory;
	import tl.ioc.*;
	import tl.service.IService;
	import tl.utils.StatesImpl;
	import tl.view.IView;

	[Frame(factoryClass="tl.core.TrylogicApplicationLoader")]
	public class Bootstrap
	{
		{
			IoCHelper.registerType( Stage, TrylogicStage );
			IoCHelper.registerType( IStateClient2, StatesImpl, ConstructorFactory );
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
				ServiceFactory.registerService( service['constructor'], service );
				service.init();
			}
		}

		internal final function init( applicationLoader : TrylogicApplicationLoader ) : void
		{
			if ( applicationView == null )
			{
				throw new ArgumentError( "applicationView of Bootstrap cant be non-null" );
			}

			applicationView.controller.addViewToContainer( applicationLoader );
		}
	}
}
