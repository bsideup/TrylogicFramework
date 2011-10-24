package tl.viewController
{
	import tl.ioc.IoCHelper;
	import tl.view.IView;

	public class ViewControllerContainer extends ViewController implements IViewControllerContainer
	{
		{
			IoCHelper.registerType( IViewControllerContainer, ViewControllerContainer );
		}
		public final function get controllers() : Array
		{
			return view.data.concat();
		}

		public function set controllers( value : Array ) : void
		{
			value = [].concat( value );

			view.data = value;
		}

		public function addController( value : IVIewController ) : void
		{
			if ( view.data.indexOf( value ) != -1 ) return;
			controllers = view.data.concat( value );
		}

		public function removeController( value : IVIewController ) : void
		{
			controllers = view.data.splice( view.data.indexOf( value ), 1 );
		}


		override public final function getViewInterface() : Class
		{
			return IView;
		}
	}
}
