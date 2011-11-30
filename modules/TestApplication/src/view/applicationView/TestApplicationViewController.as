package view.applicationView
{
	import tl.viewController.ApplicationViewController;
	import tl.viewController.IApplicationController;

	public class TestApplicationViewController extends ApplicationViewController implements IApplicationController
	{
		override public function getViewInterface() : Class
		{
			return IApplicationView;
		}
	}
}
