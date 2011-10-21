package viewControllers
{
	import actions.MY_ACTION;

	import controllers.ILogger;

	import flash.text.TextField;
	import flash.utils.getTimer;

	import models.IMyModel;

	import tl.viewController.ViewController;

	import views.testView.ITestView;
	import views.testView.ITestViewController;

	public class TestViewController extends ViewController implements ITestViewController
	{
		[Outlet]
		public var myLabel : TextField;

		[Injection]
		public var myModel : IMyModel;

		[Injection]
		public var logger : ILogger;

		override public function getViewInterface() : Class
		{
			return ITestView;
		}

		[Action]
		MY_ACTION function myAction() : void
		{
			logger.log( "myLabel text is " + myLabel.text );
		}

		[Event(name="addedToStage")]
		public function onAddedToStage() : void
		{
			logger.log( "TestViewController.onAddedToStage" );
		}

		[Event(name="enterFrame")]
		public function onEnterFrame() : void
		{
			myLabel.text = getTimer().toString();
		}

		override public function viewUnloaded() : void
		{
			super.viewUnloaded();
		}

		public function myButtonClicked() : void
		{
			actionDispatcher.dispatch( MY_ACTION );
		}
	}
}