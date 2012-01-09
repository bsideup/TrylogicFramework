package view.testView
{
	import flash.text.TextField;

	import tl.viewController.ViewController;

	public class TestViewController extends ViewController
	{
		[Outlet]
		public var myLabel : TextField;

		[Event(name="enterFrame")]
		public function onEnterFrame() : void
		{
			var date : Date = new Date();
			myLabel.text = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "." + date.getMilliseconds();
		}

		[Event(name="myButtonClicked")]
		public function myButtonClickedHandler() : void
		{
			view.currentState = "state2";

			view.controllerClass = AnotherTestViewController;
			view.initController();
		}
	}
}