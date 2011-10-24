package viewControllers
{
	import actions.MY_ACTION;

	import controllers.ILogger;

	import flash.text.TextField;

	import models.IMyModel;

	import tl.viewController.ViewController;

	import view.testView.ITestView;
	import view.testView.ITestViewController;

	public class TestViewController extends ViewController implements ITestViewController
	{
		[Outlet]
		public var myLabel : TextField;

		[Outlet]
		public var myAnotherLabel : TextField;

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
			myAnotherLabel.text = myLabel.text;
		}

		[Event(name="enterFrame")]
		public function onEnterFrame() : void
		{
			var date : Date = new Date();
			myLabel.text = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "." + date.getMilliseconds();
		}

		public function myButtonClicked() : void
		{
			actionDispatcher.dispatch( MY_ACTION );
		}
	}
}