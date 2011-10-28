package view.applicationView
{
	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;
	import tl.viewController.IApplicationController;
	import tl.viewController.ViewControllerContainer;

	import view.testView.ITestViewController;

	public class ApplicationViewController extends ViewControllerContainer implements IApplicationController
	{
		private static var instance : ApplicationViewController;

		ioc_internal static function getInstance() : ApplicationViewController
		{
			if ( instance == null )
			{
				instance = new ApplicationViewController();
				instance.addController( IoCHelper.resolve( ITestViewController ) );
			}
			return instance;
		}

		override public function getViewInterface() : Class
		{
			return IApplicationView;
		}

		override public function viewBeforeAddedToStage() : void
		{
			
		}
	}
}
