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
			_controllers.splice( _controllers.indexOf( value ), 1 );

			var viewElement : DisplayObject;

			if(value.viewIsLoaded)
			{
				viewElement = value.view as DisplayObject;

				value.viewBeforeRemovedFromStage();

				if(viewElement.parent)
				{
					viewElement.parent.removeChild(viewElement);
				}
			}

			value.parentViewController = null;
		}

		override public function getViewInterface() : Class
		{
			return IViewContainer;
		}

		public function set controllers( value : Array ) : void
		{
			value = [].concat( value );

			var viewController : IVIewController;

			for each ( viewController in controllers )
			{
				if(value.indexOf(viewController) == -1)
				{
					removeController(viewController);
				}
			}

			for each ( viewController in value )
			{
				viewController.parentViewController = this;
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

				viewController.viewBeforeAddedToStage();
				
				container.addChild( viewElement );
				container.setChildIndex( viewElement, container.numChildren - 1 );
			}
		}

	}
}
