package tl.gui.components
{
	import tl.actions.ActionDispatcher;

	import flash.text.*;
	import flash.events.*;

	/**
	 * ...
	 * @author aSt
	 */
	public class Text extends TextField
	{
		protected var _hintText : String;

		public function Text()
		{
			super.defaultTextFormat = new TextFormat("Arial", 12);
			super.selectable = false;
		}

		public function get value() : String
		{
			return super.text;
		}

		[Bindable]
		public function set value(newText : String) : void
		{
			if (newText == null) return;
			super.text = newText;
			setTextFormat(defaultTextFormat);
		}

		override public function set defaultTextFormat(value : TextFormat) : void
		{
			super.defaultTextFormat = value;
			setTextFormat(value);
		}

		public function set hint(value : String) : void
		{
			if (value == null || value == "")
			{
				removeEventListener(MouseEvent.MOUSE_OVER, hintHandler);
				_hintText = null;
			}
			else
			{
				if (_hintText == null)
				{
					addEventListener(MouseEvent.MOUSE_OVER, hintHandler);
				}

				_hintText = value;
			}
		}

		protected function hintHandler(e : MouseEvent) : void
		{
			ActionDispatcher.dispatch('Hints', 'hintMe', [e.currentTarget, _hintText]);
		}

		[Bindable]
		override public function set visible(value : Boolean) : void
		{
			super.visible = value;
		}
	}

}
