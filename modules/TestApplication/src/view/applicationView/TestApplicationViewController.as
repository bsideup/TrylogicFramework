package view.applicationView
{
	import tl.ioc.IoCHelper;
	import tl.viewController.ApplicationViewController;
	import tl.viewController.IApplicationController;

	import view.testView.ITestViewController;

	public class TestApplicationViewController extends ApplicationViewController implements IApplicationController
	{
		override protected function viewBeforeAddedToStage() : void
		{
			addController( IoCHelper.resolve( ITestViewController ) );
		}
	}
}
