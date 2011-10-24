package tl.viewController
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import tl.actions.IActionDispatcher;
	import tl.ioc.IoCHelper;
	import tl.utils.describeTypeCached;
	import tl.view.IView;

	[Outlet]
	public class ViewController extends EventDispatcher implements IVIewController
	{
		{
			IoCHelper.registerType( IVIewController, ViewController );

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

		private var viewInstance : IView;
		private var viewEventHandlers : Array;
		private var viewOutlets : Array;

		public final function get view() : IView
		{
			if ( !viewIsLoaded )
			{
				var desc : XML;
				if ( viewEventHandlers == null )
				{
					viewEventHandlers = [];

					desc = describeTypeCached( this );

					desc.method.( valueOf().metadata.( @name == "Event" ).length() > 0 ).(
							viewEventHandlers[ metadata.arg.( @key == "name" ).@value.toString() ] = String( @name )
							);
				}

				if ( viewOutlets == null )
				{
					viewOutlets = [];
					if ( desc == null )
					{
						desc = describeTypeCached( this );
					}

					desc.variable.( valueOf().metadata.( @name == "Outlet" ).length() > 0 ).(
							viewOutlets.push( @name )
							);
				}

				viewInstance = IoCHelper.resolve( getViewInterface(), this );
				viewInstance.controller = this;

				viewLoaded();
			}

			return viewInstance;
		}

		public final function get viewIsLoaded() : Boolean
		{
			return viewInstance != null;
		}

		public function getViewInterface() : Class
		{
			return IView;
		}

		protected function viewLoaded() : void
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

		public function viewBeforeAddedToStage() : void
		{
		}

		public function viewBeforeRemovedFromStage() : void
		{
		}

		[Event(name="removedFromStage")]
		public final function viewRemovedFromStage() : void
		{
			destroy();
		}

		public final function destroy() : void
		{
			internalDestroy();

			for each( var outletName : String in viewOutlets )
			{
				unsetOutlet( outletName );
			}

			for ( var eventName : String in viewEventHandlers )
			{
				unsetHandler( eventName );
			}

			actionDispatcher.removeHandler( this );
			actionDispatcher = null;

			viewInstance.destroy();
			viewInstance = null;
		}

		protected function internalDestroy() : void
		{
		}

		protected function setOutlet( name : String ) : void
		{
			this[name] = viewInstance[name];
		}

		protected function unsetOutlet( name : String ) : void
		{
			this[name] = null;
		}

		protected function setHandler( eventName : String ) : void
		{
			viewInstance.addEventListener( eventName, viewEventHandler );
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
