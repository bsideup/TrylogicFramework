package models
{
	import tl.ioc.ioc_internal;

	[Bindable]
	public class MyModel implements IMyModel
	{
		private static const instance : MyModel = new MyModel();

		private var _myNumber : Number;
		private var _myLabel : String = "Yo!";

		ioc_internal static function getInstance() : MyModel
		{
			return instance;
		}

		public function get myNumber() : Number
		{
			return _myNumber;
		}

		public function set myNumber( value : Number ) : void
		{
			_myNumber = value;
		}

		public function get myText() : String
		{
			return _myLabel;
		}

		public function set myText( value : String ) : void
		{
			_myLabel = value;
		}
	}
}
