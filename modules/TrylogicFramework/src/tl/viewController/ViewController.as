package tl.viewController
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
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
			if ( describeTypeCached( ViewController )..metadata.( @name == "Outlet" ).length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Outlet to flex compiler arguments!" )
			}

			if ( describeTypeCached( ViewController )..metadata.( @name == "Event" ).length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Event to flex compiler arguments!" )
			}
		}

		protected namespace lifecycle;

		[Injection]
		public var actionDispatcher : IActionDispatcher;

		private var _viewControllerContainer : IVIewController;
		private var _viewInstance : IView;
		private var _viewEventHandlers : Array;
		private var _viewOutlets : Array;

		public function ViewController()
		{
			IoCHelper.injectTo( this );
		}

		public function addViewToContainer( container : DisplayObjectContainer ) : void
		{
			if ( DisplayObject( view ).parent == container )
			{
				return;
			}

			lifecycle::viewBeforeAddedToStage();

			container.addChild( view as DisplayObject );
		}

		public function addViewToContainerAtIndex( container : DisplayObjectContainer, index : int ) : void
		{
			addViewToContainer( container );

			setViewIndexInContainer( container, index );
		}

		public function setViewIndexInContainer( container : DisplayObjectContainer, index : int ) : void
		{
			container.setChildIndex( view as DisplayObject, index < 0 ? (container.numChildren + index) : index );
		}

		public function removeViewFromContainer( container : DisplayObjectContainer ) : void
		{
			lifecycle::viewBeforeRemovedFromStage();

			if ( viewIsLoaded )
			{
				var viewDisplayObject : DisplayObject = view as DisplayObject;
				if ( viewDisplayObject.parent )
				{
					viewDisplayObject.parent.removeChild( viewDisplayObject );
				}
			}
		}

		public function get parentViewController() : IVIewController
		{
			return _viewControllerContainer;
		}

		public function set parentViewController( value : IVIewController ) : void
		{
			_viewControllerContainer = value;
		}

		public function getViewInterface() : Class
		{
			return IView;
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
			lifecycle::destroy();

			actionDispatcher.removeHandler( this );
			actionDispatcher = null;
		}

		lifecycle function viewBeforeAddedToStage() : void
		{
		}

		lifecycle function viewBeforeRemovedFromStage() : void
		{
		}

		lifecycle function viewLoaded() : void
		{
		}

		lifecycle function destroy() : void
		{
		}

		protected final function get viewIsLoaded() : Boolean
		{
			return _viewInstance != null;
		}

		protected final function get view() : IView
		{
			if ( !viewIsLoaded )
			{
				_viewInstance = IoCHelper.resolve( getViewInterface(), this );
				_viewInstance.controller = this;

				this.processView();
			}

			return _viewInstance;
		}

		private function processView() : void
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

			for each( var outletName : String in _viewOutlets )
			{
				setOutlet( outletName );
			}

			for ( var eventName : String in _viewEventHandlers )
			{
				setHandler( eventName );
			}

			lifecycle::viewLoaded();
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
					if ( this[methodName] )
					{
						this[methodName]();
					}
				}
			}
		}
	}

}
