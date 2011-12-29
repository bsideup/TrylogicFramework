package tl.view
{
	import flash.display.*;

	import mx.core.IMXMLObject;
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;

	import tl.ioc.Resolve;
	import tl.viewController.IVIewController;
	import tl.viewController.ViewController;

	[DefaultProperty("data")]
	/**
	 * Basic IView implementation
	 *
	 * @see IViewController
	 *
	 */
	public class View extends UIComponent implements IView, IMXMLObject
	{
		public var eventMaps : Vector.<EventMap>;

		[Bindable]
		public var controllerClass : Class;

		protected namespace lifecycle = "http://www.trylogic.ru/view/lifecycle";

		private var _data : Array = [];
		private var _controller : IVIewController;

		[Bindable(event="propertyChange")]
		public function get controller() : IVIewController
		{
			if ( _controller == null )
			{
				initController();

				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "controller", null, _controller ) );
			}

			return _controller;
		}

		public function initController() : void
		{
			if ( controllerClass == null || !(_controller is controllerClass) )
			{
				destoyController();

				var eventMap : EventMap;

				_controller = controllerClass == null ? (new ViewController()) : (new controllerClass());

				_controller.initWithView( this );

				if ( eventMaps )
				{
					for each( eventMap in eventMaps )
					{
						eventMap.bind();
					}
				}
			}
		}

		public function initialized( document : Object, id : String ) : void
		{
			initController();

			lifecycle::init();
		}

		public function addElement( element : * ) : void
		{
			if ( _data.indexOf( element ) != -1 )
			{
				return;
			}

			if ( element is Resolve )
			{
				addElement( element.instance );
				return;
			}


			_data.push( element );

			var viewElement : DisplayObject;
			if ( element is DisplayObject )
			{
				viewElement = element as DisplayObject;
			}
			else if ( element is Embed )
			{
				viewElement = element.instance as DisplayObject;
			}
			else
			{
				return;
			}

			if ( viewElement != null )
			{
				addChild( viewElement );
			}
		}

		public function addElementAt( element : *, index : int ) : void
		{
			addElement( element );

			setElementIndex( element, index );
		}

		public function setElementIndex( element : *, index : int ) : void
		{
			if ( _data.indexOf( element ) == -1 )
			{
				return;
			}

			if ( element is Resolve )
			{
				setElementIndex( element.instance, index );
				return;
			}

			var viewElement : DisplayObject;

			if ( element is DisplayObject )
			{
				viewElement = element as DisplayObject;
			}
			else if ( element is Embed )
			{
				viewElement = element.instance as DisplayObject;
			}
			else
			{
				return;
			}

			if ( viewElement != null )
			{
				setChildIndex( viewElement, index < 0 ? (numChildren + index) : index );
			}
		}

		public function removeElement( element : * ) : void
		{
			if ( _data.indexOf( element ) == -1 )
			{
				return;
			}

			if ( element is Resolve )
			{
				removeElement( element.instance );
				return;
			}

			_data.splice( _data.indexOf( element ), 1 );

			var viewElement : DisplayObject;
			if ( element is DisplayObject )
			{
				viewElement = element as DisplayObject;
			}
			else if ( element is Embed && (element.instance is DisplayObject) )
			{
				viewElement = element.instance as DisplayObject;
			}
			else
			{
				return;
			}

			if ( viewElement != null && viewElement.parent != null )
			{
				viewElement.parent.removeChild( viewElement );
			}
		}

		/**
		 * Inner childs.
		 *
		 * @param value
		 */
		public function set data( value : Array ) : void
		{
			value = [].concat( value );
			var element : *;

			for each ( element in _data.concat() )
			{
				if ( value.indexOf( element ) == -1 )
				{
					removeElement( element );
				}
			}

			for each ( element in value )
			{
				if ( _data.indexOf( element ) == -1 )
				{
					addElement( element );
				}
				else
				{
					setElementIndex( element, -1 );
				}
			}

			_data = value;
		}

		public final function get data() : Array
		{
			return _data.concat();
		}

		/**
		 * Destroy a IView.
		 *
		 * @see internalDispose
		 *
		 */
		public final function destroy() : void
		{
			internalDestroy();
			lifecycle::destroy();


			destoyController();
			data = null;
		}

		internal function internalDestroy() : void
		{

		}

		private function destoyController() : void
		{
			var eventMap : EventMap;
			if ( _controller )
			{
				if ( eventMaps )
				{
					for each( eventMap in eventMaps )
					{
						eventMap.unbind();
					}
				}

				_controller.initWithView( null );
			}
		}

		/**
		 * custom init logic here
		 *
		 */
		lifecycle function init() : void
		{

		}

		/**
		 * custom dispose logic here
		 *
		 */
		lifecycle function destroy() : void
		{

		}
	}
}