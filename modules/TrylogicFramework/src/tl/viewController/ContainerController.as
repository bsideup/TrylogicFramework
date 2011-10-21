package tl.viewController
{
	import flash.display.DisplayObject;

	import tl.view.IView;

	public class ContainerController extends ViewController implements IContainerController
	{
		private var _controllers : Array = [];

		public function get controllers() : Array
		{
			return _controllers.concat();
		}

		public function set controllers( value : Array ) : void
		{
			value = [].concat( value );
			var viewController : IVIewController;

			for each ( viewController in _controllers )
			{
				if ( value.indexOf( viewController ) == -1 )
				{
					viewController.viewBeforeRemovedFromStage();

					if ( viewController.view ) view.removeChild( viewController.view as DisplayObject );
				}
			}

			for each ( viewController in value )
			{
				if ( _controllers.indexOf( viewController ) == -1 )
				{
					viewController.loadView();

					viewController.viewBeforeAddedToStage();

					view.addChild( viewController.view as DisplayObject );
				}

				view.setChildIndex( viewController.view as DisplayObject, view.numChildren - 1 );
			}

			_controllers = value;
		}

		public function addController( value : IVIewController ) : void
		{
			if ( _controllers.indexOf( value ) != -1 ) return;
			controllers = _controllers.concat( value );
		}

		public function removeController( value : IVIewController ) : void
		{
			controllers = _controllers.splice( _controllers.indexOf( value ), 1 );
		}


		override public final function getViewInterface() : Class
		{
			return IView;
		}
	}
}
