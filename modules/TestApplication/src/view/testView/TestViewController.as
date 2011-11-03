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

		private var _canClick : Boolean = true;

		public function get canClick() : Boolean
		{
			return _canClick;
		}

		[Bindable]
		public function set canClick(value : Boolean) : void
		{
			_canClick = value;
		}
		
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

			canClick = false;
		}
	}
}