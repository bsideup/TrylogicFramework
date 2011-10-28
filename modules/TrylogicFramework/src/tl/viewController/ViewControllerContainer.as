package tl.viewController
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	import tl.view.IViewContainer;

	[DefaultProperty("controllers")]
	public class ViewControllerContainer extends ViewController implements IViewControllerContainer
	{
		[Outlet]
		public var container : DisplayObjectContainer;

		private var _controllers : Array = [];

		public final function get controllers() : Array
		{
			return _controllers;
		}

		public function addController( value : IVIewController ) : void
		{
			if ( controllers.indexOf( value ) != -1 ) return;
			controllers = controllers.concat( value );
		}

		public function removeController( value : IVIewController ) : void
		{
			controllers = controllers.splice( controllers.indexOf( value ), 1 );
		}

		override public function getViewInterface() : Class
		{
			return IViewContainer;
		}

		public function set controllers( value : Array ) : void
		{
			value = [].concat( value );

			var viewController : IVIewController;
			var viewElement : DisplayObject;

			for each ( viewController in controllers )
			{
				viewElement = viewController.view as DisplayObject;
				if ( value.indexOf( viewElement ) == -1 && viewElement.parent )
				{
					viewController.viewBeforeRemovedFromStage();

					viewElement.parent.removeChild( viewElement );

					viewController.viewControllerContainer = null;
				}
			}

			for each ( viewController in value )
			{
				viewController.viewControllerContainer = this;
			}

			_controllers = value;

			fillContainer();
		}

		override protected function viewLoaded() : void
		{
			super.viewLoaded();
			fillContainer();
		}

		protected function fillContainer() : void
		{
			if ( !viewIsLoaded )
			{
				return;
			}

			var viewController : IVIewController;
			var viewElement : DisplayObject;

			for each ( viewController in controllers )
			{
				viewElement = viewController.view as DisplayObject;

				container.addChild( viewElement );
				container.setChildIndex( viewElement, container.numChildren - 1 );
			}
		}

	}
}
