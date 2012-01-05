﻿package tl.core
{
	import flash.display.*;

	import mx.core.IStateClient2;

	import tl.actions.*;
	import tl.factory.*;
	import tl.ioc.*;
	import tl.ioc.mxml.IAssociate;
	import tl.service.IService;
	import tl.utils.StatesImpl;
	import tl.view.IView;

	[Frame(factoryClass="tl.core.TrylogicApplicationLoader")]
	public class Bootstrap
	{
		{
			IoCHelper.registerType( Stage, TrylogicStage );
			IoCHelper.registerType( IStateClient2, StatesImpl, ConstructorFactory );
			IoCHelper.registerType( IActionDispatcher, ActionDispatcher, SingletonFactory );
		}

		public var backgroundColor : Number;
		public var frameRate : Number;
		public var preloader : Class;

		public var applicationView : IView;
		public var subModules : Vector.<Bootstrap>;

		private var _services : Vector.<IService>;

		public function set iocMap( value : Vector.<IAssociate> ) : void
		{
			for each( var assoc : IAssociate in value )
			{
				IoCHelper.registerAssociate( assoc );
			}
		}

		public function set services( value : Vector.<IService> ) : void
		{
			for each( var service : IService in value )
			{
				ServiceFactory.registerService( Object( service ).constructor, service );
			}

			_services = value;
		}

		internal function initServices() : void
		{
			for each( var service : IService in _services )
			{
				service.init();
			}

			for each( var bootstrap : Bootstrap in subModules )
			{
				bootstrap.initServices();
			}
		}

		internal final function init( applicationLoader : TrylogicApplicationLoader ) : void
		{
			if ( applicationView == null )
			{
				throw new ArgumentError( "applicationView of Bootstrap cant be non-null" );
			}

			initServices();

			applicationView.controller.addViewToContainer( applicationLoader );
		}
	}
}
