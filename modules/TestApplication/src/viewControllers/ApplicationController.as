package viewControllers
{
	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;
	import tl.viewController.IApplicationController;
	import tl.viewController.ViewControllerContainer;

	import view.testView.ITestViewController;

	public class ApplicationController extends ViewControllerContainer implements IApplicationController
	{
		private static const instance : ApplicationController = new ApplicationController();

		ioc_internal static function getInstance() : ApplicationController
		{
			return instance;
		}

		override protected function viewLoaded() : void
		{
			super.viewLoaded();
			addController( IoCHelper.resolve( ITestViewController ) );
		}
	}
}
