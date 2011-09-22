package tl.gui.components
{
	import tl.gui.Skin;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import mx.core.UIComponent;

	import tl.core.StateClient;
	import tl.gui.defaultSkins.*;

	import flash.net.*;

	import tl.gui.GUIComponent;

	/**
	 * ...
	 * @author aSt
	 */
	[Event(name = "startDrag", type = "flash.events.Event")]
	public class Alert extends GUIComponent
	{

		public function Alert()
		{
		}

		[Bindable]
		public function get headerText() : String
		{
			return _skin['headerText'];
		}

		public function set headerText(value : String) : void
		{
			_skin['headerText'] = value;
		}

		[Bindable]
		public function get bgImageClass() : String
		{
			return _skin['bgImageClass'];
		}

		public function set bgImageClass(value : String) : void
		{
			_skin['bgImageClass'] = value;
		}

		[Bindable]
		public function get innerText() : String
		{
			return _skin['innerText'];
		}

		public function set innerText(value : String) : void
		{
			_skin['innerText'] = value;
		}

		[Bindable]
		public function get okHandler() : Function
		{
			return _skin['okHandler'];
		}

		public function set okHandler(value : Function) : void
		{
			_skin['okHandler'] = value;
		}

		[Bindable]
		public function get cancelHandler() : Function
		{
			return _skin['cancelHandler'];
		}

		public function set cancelHandler(value : Function) : void
		{
			_skin['cancelHandler'] = value;
		}

		override protected function set skin(value : Skin) : void
		{
			for each(var i in ['innerText', 'headerText', 'bgImageClass'])
			{
				if (_skin[i]) value[i] = _skin[i];
			}
			super.skin = value;
		}

	}

}
