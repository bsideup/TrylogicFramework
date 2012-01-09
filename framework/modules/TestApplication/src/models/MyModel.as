package models
{
	import flash.events.EventDispatcher;

	public class MyModel extends EventDispatcher implements IMyModel
	{
		[Bindable]
		public var myNumber : Number;

		[Bindable]
		public var myText : String = "Yo!";
	}
}
