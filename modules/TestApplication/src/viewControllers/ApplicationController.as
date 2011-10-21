package viewControllers
{
	import actions.MY_ACTION;

	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;
	import tl.viewController.ContainerController;
	import tl.viewController.IApplicationController;

	import views.testView.ITestViewController;

	public class ApplicationController extends ContainerController implements IApplicationController
	{
		private static const instance : ApplicationController = new ApplicationController();

		ioc_internal static function getInstance() : ApplicationController
		{
			return instance;
		}

		override public function viewLoaded() : void
		{
			super.viewLoaded();
			addController( IoCHelper.resolve( ITestViewController ) );
		}

		[Event(name="addedToStage")]
		public function viewAddedToStage() : void
		{
			actionDispatcher.dispatch( MY_ACTION );
		}
	}
}
