package tl.viewController
{
	import flash.events.Event;

	import tl.actions.IActionDispatcher;
	import tl.ioc.IoCHelper;
	import tl.utils.describeTypeCached;
	import tl.view.IView;

	[Outlet]
	public class ViewController implements IVIewController
	{
		{
			if ( describeTypeCached( ViewController )..metadata.( @name == "Outlet" ).length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Outlet to flex compiler arguments!" )
			}

			if ( describeTypeCached( ViewController )..metadata.( @name == "Event" ).length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Event to flex compiler arguments!" )
			}
		}

		[Injection]
		public var actionDispatcher : IActionDispatcher;

		private var _viewControllerContainer : IViewControllerContainer;
		private var _viewInstance : IView;
		private var _viewEventHandlers : Array;
		private var _viewOutlets : Array;

		public function ViewController()
		{
			IoCHelper.injectTo( this );
		}

		public final function get view() : IView
		{
			if ( !viewIsLoaded )
			{
				if ( _viewEventHandlers == null )
				{
					_viewEventHandlers = [];

					describeTypeCached( this ).method.( valueOf().metadata.( @name == "Event" ).length() > 0 ).(
							registerListener( metadata.arg.( @key == "name" ).@value.toString(), String( @name ) )
							);
				}

				if ( _viewOutlets == null )
				{
					_viewOutlets = [];

					describeTypeCached( this ).variable.( valueOf().metadata.( @name == "Outlet" ).length() > 0 ).(
							_viewOutlets.push( @name )
							);
				}

				_viewInstance = IoCHelper.resolve( getViewInterface(), this );
				_viewInstance.controller = this;

				viewLoaded();
			}

			return _viewInstance;
		}

		public function get parentViewController() : IViewControllerContainer
		{
			return _viewControllerContainer;
		}

		public function set parentViewController( value : IViewControllerContainer ) : void
		{
			_viewControllerContainer = value;
		}

		public final function get viewIsLoaded() : Boolean
		{
			return _viewInstance != null;
		}

		public function getViewInterface() : Class
		{
			return IView;
		}

		public function viewBeforeAddedToStage() : void
		{
		}

		public function viewBeforeRemovedFromStage() : void
		{
		}

		[Event(name="removedFromStage")]
		public final function viewRemovedFromStage() : void
		{
			for each( var outletName : String in _viewOutlets )
			{
				unsetOutlet( outletName );
			}

			for ( var eventName : String in _viewEventHandlers )
			{
				unsetHandler( eventName );
			}

			_viewInstance.destroy();
			_viewInstance = null;

			_viewControllerContainer = null;
		}

		public final function destroy() : void
		{
			internalDestroy();

			actionDispatcher.removeHandler( this );
			actionDispatcher = null;
		}

		protected function viewLoaded() : void
		{
			for each( var outletName : String in _viewOutlets )
			{
				setOutlet( outletName );
			}

			for ( var eventName : String in _viewEventHandlers )
			{
				setHandler( eventName );
			}
		}

		protected function internalDestroy() : void
		{
		}

		protected function setOutlet( name : String ) : void
		{
			this[name] = _viewInstance[name];
		}

		protected function unsetOutlet( name : String ) : void
		{
			this[name] = null;
		}

		protected function setHandler( eventName : String ) : void
		{
			_viewInstance.addEventListener( eventName, viewEventHandler );
		}

		protected function unsetHandler( eventName : String ) : void
		{
			_viewInstance.removeEventListener( eventName, viewEventHandler );
		}

		private function registerListener( eventName : String, listener : String ) : void
		{
			if ( _viewEventHandlers[ eventName ] == null )
			{
				_viewEventHandlers[ eventName ] = [];
			}

			_viewEventHandlers[ eventName ].push( listener );
		}

		private function viewEventHandler( e : Event ) : void
		{
			var methods : Array = _viewEventHandlers[e.type];
			if ( methods != null )
			{
				for each( var methodName : String in methods )
				{
					this[methodName]();
				}
			}
		}
	}

}
