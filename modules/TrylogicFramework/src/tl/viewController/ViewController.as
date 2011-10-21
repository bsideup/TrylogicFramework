package tl.viewController
{
	import flash.events.Event;
	import flash.utils.describeType;

	import mx.binding.utils.BindingUtils;

	import tl.actions.IActionDispatcher;
	import tl.ioc.IoCHelper;
	import tl.view.IView;

	public class ViewController implements IVIewController
	{
		[Injection]
		public var actionDispatcher : IActionDispatcher;

		private var viewInstance : IView;
		private var viewEventHandlers : Array;
		private var viewOutlets : Array;

		public final function get view() : IView
		{
			return viewInstance;
		}

		public final function get viewIsLoaded() : Boolean
		{
			return view != null;
		}

		public function getViewInterface() : Class
		{
			return IView;
		}

		public final function loadView() : void
		{
			var desc : XML;
			if ( viewEventHandlers == null )
			{
				viewEventHandlers = [];

				desc = describeType( this );

				desc.method.(metadata.(@name == "Event").length() > 0).(
						viewEventHandlers[metadata.arg.(@key == "name").@value.toString()] = String( @name )
						);
			}

			if ( viewOutlets == null )
			{
				viewOutlets = [];
				if ( desc == null )
				{
					desc = describeType( this );
				}

				desc.variable.(metadata.(@name == "Outlet").length() > 0).(
						viewOutlets.push( @name )
						);
			}

			if ( !viewIsLoaded )
			{
				var viewInterface : Class = getViewInterface();
				viewInstance = IoCHelper.resolve( viewInterface, this );
				viewInstance.controller = this;

				viewLoaded();
			}
		}

		public function viewLoaded() : void
		{
			for each( var outletName : String in viewOutlets )
			{
				setOutlet( outletName );
			}

			for ( var eventName : String in viewEventHandlers )
			{
				setHandler( eventName );
			}
		}

		public function viewUnloaded() : void
		{
			for each( var outletName : String in viewOutlets )
			{
				unsetOutlet( outletName );
			}

			for ( var eventName : String in viewEventHandlers )
			{
				unsetHandler( eventName );
			}
		}

		public function viewBeforeAddedToStage() : void
		{
		}

		public function viewBeforeRemovedFromStage() : void
		{
		}

		public final function destroy() : void
		{
			viewUnloaded();

			viewInstance.dispose();
			viewInstance = null;

			actionDispatcher.removeHandler( this );
			actionDispatcher = null;
		}

		protected function setOutlet( name : String ) : void
		{
			this[name] = viewInstance[name];
		}

		protected function setHandler( eventName : String ) : void
		{
			viewInstance.addEventListener( eventName, viewEventHandler );
		}

		protected function unsetOutlet( name : String ) : void
		{
			this[name] = null;
		}

		protected function unsetHandler( eventName : String ) : void
		{
			viewInstance.removeEventListener( eventName, viewEventHandler );
		}

		private function viewEventHandler( e : Event ) : void
		{
			var methodName : String = viewEventHandlers[e.type];
			if ( methodName != null )
			{
				this[methodName]();
			}
		}
	}

}
