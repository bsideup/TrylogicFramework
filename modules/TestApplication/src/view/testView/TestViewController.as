package view.testView
{
	import actions.FREEZE;

	import flash.text.TextField;

	import tl.viewController.ViewController;

	public class TestViewController extends ViewController implements ITestViewController
	{
		[Outlet]
		public var myLabel : TextField;

		[Outlet]
		public var myAnotherLabel : TextField;

		override public function getViewInterface() : Class
		{
			return ITestView;
		}

		[Event(name="enterFrame")]
		public function onEnterFrame() : void
		{
			var date : Date = new Date();
			myLabel.text = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "." + date.getMilliseconds();
		}

		public function myButtonClicked() : void
		{
			trace("Yo!");
			actionDispatcher.dispatch( FREEZE );
		}
	}
}