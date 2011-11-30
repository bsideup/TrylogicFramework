package tl.view
{
	import flash.display.*;

	import mx.events.PropertyChangeEvent;

	import tl.ioc.Resolve;
	import tl.utils.getChildByNameRecursiveOnTarget;
	import tl.viewController.IVIewController;

	[DefaultProperty("data")]
	/**
	 * Basic IView implementation
	 *
	 * @see IViewController
	 *
	 */
	public class View extends Sprite implements IView
	{
		private var _data : Array = [];
		private var _controller : IVIewController;
		public var eventMaps : Vector.<EventMap>;

		protected namespace lifecycle = "http://www.trylogic.ru/view/lifecycle";

		[Bindable(event="propertyChange")]
		public function get controller() : IVIewController
		{
			return _controller;
		}

		/**
		 * Wrapper for <code>getChildByNameRecursiveOnTarget</code>
		 *
		 * @see getChildByNameRecursiveOnTarget
		 *
		 * @param name	Child name
		 * @return		null, if there is no childs with this name, or first occurience of child with this name, if it's exist
		 */
		public function getChildByNameRecursive( name : String ) : DisplayObject
		{
			return getChildByNameRecursiveOnTarget( name, this );
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

			if ( element is IVIewController )
			{
				IVIewController( element ).addViewToContainer( this );
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

			if ( element is IVIewController )
			{
				IVIewController( element ).setViewIndexInContainer( this, -1 );
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

			//_data.splice( _data.indexOf( element ), 1 );

			if ( element is IVIewController )
			{
				IVIewController( element ).removeViewFromContainer( this );
				return;
			}

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

			for each ( element in _data )
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

		public function initWithController( controller : IVIewController ) : void
		{
			this._controller = controller;
			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "controller", null, _controller ) );

			if ( eventMaps )
			{
				for each( var eventMap : EventMap in eventMaps )
				{
					eventMap.bind();
				}
			}

			lifecycle::init();
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

			data = null;

			if ( _controller )
			{
				_controller = null;
			}

			if ( eventMaps )
			{
				var eventMap : EventMap;
				while ( eventMap = eventMaps.pop() )
				{
					eventMap.unbind();
				}

				eventMaps = null;
			}
		}

		internal function internalDestroy() : void
		{

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