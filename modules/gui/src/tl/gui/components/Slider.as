package tl.gui.components
{
	import flash.events.Event;

	import tl.gui.*;

	/**
	 * ...
	 * @author aSt
	 */
	[Event(name="valueChange", type="flash.events.Event")]
	public class Slider extends GUIComponent
	{
		[Bindable]
		public function get value() : Number
		{
			return _skin['value'];
		}

		public function set value(val : Number) : void
		{
			if (val > 1) value = 1;
			if (val < 0) value = 0;
			_skin['value'] = val;
			dispatchEvent(new Event("valueChange"));
		}

		public function Slider()
		{
			super();
		}

		public function updateValue(val : Number) : void
		{
			value = val;
		}

		override protected function set skin(value : Skin) : void
		{
			for each(var i in ['value'])
			{
				if (_skin[i]) value[i] = _skin[i];
			}
			super.skin = value;
		}

	}

}
