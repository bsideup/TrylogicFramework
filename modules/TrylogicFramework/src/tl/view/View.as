package tl.view
{
	import flash.display.*;

	import tl.ioc.IoCHelper;
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

		/**
		 * Don't call it by yourself. Called by IViewController
		 *
		 * @param value
		 */
		[Bindable]
		public final function set controller( value : IVIewController ) : void
		{
			if ( _controller != null )
			{
				throw new Error( "You can't set controller twice!" );
			}

			_controller = value;
		}

		public final function get controller() : IVIewController
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

		/**
		 * Inner childs.
		 *
		 * @param value
		 */
		public function set data( value : Array ) : void
		{
			value = [].concat( value );
			var element : *;
			var viewElement : DisplayObject;
			var viewController : IVIewController;

			for each ( element in _data )
			{
				if ( element is IVIewController && IVIewController( element ).viewIsLoaded )
				{
					viewElement = IVIewController( element ).view as DisplayObject;
					if ( value.indexOf( viewElement ) == -1 )
					{
						IVIewController( element ).viewBeforeRemovedFromStage();
					}
				}
				else if ( element is IView )
				{
					viewElement = element as DisplayObject;

					viewController = IView( element ).controller;
					if ( viewController && value.indexOf( viewElement ) == -1 )
					{
						viewController.viewBeforeRemovedFromStage();
					}
				}
				else if ( element is DisplayObject )
				{
					viewElement = element as DisplayObject;
				}
				else if ( element is Embed && (element.instance is DisplayObject) )
				{
					viewElement = element.instance as DisplayObject;
				}
				else
				{
					continue;
				}

				if ( value.indexOf( viewElement ) == -1 )
				{
					removeChild( viewElement );
				}
			}

			for each ( element in value )
			{
				if ( element is IVIewController )
				{
					viewElement = IVIewController( element ).view as DisplayObject;
					if ( _data.indexOf( viewElement ) == -1 )
					{
						IVIewController( element ).viewBeforeAddedToStage();
					}
				}
				else if ( element is IView )
				{
					viewElement = element as DisplayObject;

					viewController = IView( element ).controller;
					if ( viewController && _data.indexOf( viewElement ) == -1 )
					{
						viewController.viewBeforeAddedToStage();
					}
				}
				else if ( element is DisplayObject )
				{
					viewElement = element as DisplayObject;
				}
				else if ( element is Embed )
				{
					viewElement = element.instance as DisplayObject;
				}
				else
				{
					continue;
				}

				if ( _data.indexOf( viewElement ) == -1 )
				{
					addChild( viewElement );
				}

				setChildIndex( viewElement, numChildren - 1 );
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
			internalDestoy();

			data = null;

			if ( _controller )
			{
				_controller = null;
			}
		}

		/**
		 * Do a custom dispose logic here
		 *
		 */
		protected function internalDestoy() : void
		{

		}
	}
}