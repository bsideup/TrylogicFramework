package tl.view
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	import tl.core.tl_internal;

	import tl.ioc.IoCHelper;
	import tl.utils.getChildByNameRecursiveOnTarget;
	import tl.viewController.IVIewController;

	[DefaultProperty("data")]
	public class View extends MovieClip implements IView
	{
		private var _data : Array = [];

		{
			IoCHelper.registerType( IView, View );
		}

		private var _controller : IVIewController;

		public function getChildByNameRecursive( name : String ) : DisplayObject
		{
			return getChildByNameRecursiveOnTarget( name, this );
		}

		public function set controller( value : IVIewController ) : void
		{
			_controller = value;
		}

		public final function get controller() : IVIewController
		{
			return _controller;
		}

		public final function set data( value : Array ) : void
		{
			value = [].concat( value );
			var element : *;
			var viewElement : DisplayObject;

			for each ( element in _data )
			{
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
					continue;
				}

				if ( value.indexOf( viewElement ) == -1 )
				{
					removeChild( viewElement );
				}
			}

			for each ( element in value )
			{
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
		
		public function dispose() : void
		{
			_controller = null;
		}

	}
}