package view.applicationView
{
	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;
	import tl.viewController.ApplicationViewController;
	import tl.viewController.IApplicationController;

	import view.testView.ITestViewController;

	public class TestApplicationViewController extends ApplicationViewController implements IApplicationController
	{
		private static var instance : TestApplicationViewController;

		ioc_internal static function getInstance() : TestApplicationViewController
		{
			if ( instance == null )
			{
				instance = new TestApplicationViewController();
			}
			return instance;
		}

		override public function viewBeforeAddedToStage() : void
		{
			trace( stage.frameRate );
			addController( IoCHelper.resolve( ITestViewController ) );
		}
	}
}
