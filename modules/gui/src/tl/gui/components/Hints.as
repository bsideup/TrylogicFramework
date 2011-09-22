package tl.gui.components
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;

	import tl.actions.ActionDispatcher;

	/**
	 * ...
	 * @author
	 */
	[Event(name = "showHint", type = "flash.events.Event")]
	[Event(name = "hideHint", type = "flash.events.Event")]
	public class Hints extends EventDispatcher
	{
		static const showHintEvent : Event = new Event("showHint");
		static const hideHintEvent : Event = new Event("hideHint");

		const timer : Timer = new Timer(1500, 1);

		public var text : String;

		protected var currentTarget : DisplayObject;

		public function Hints()
		{
			super();
			ActionDispatcher.addHandler(this);

			timer.addEventListener(TimerEvent.TIMER_COMPLETE, function(e : TimerEvent) : void
			{
				dispatchEvent(showHintEvent);
			});
		}

		public function set delay(value : Number) : void
		{
			timer.delay = value;
		}

		[Action(className = "Hints", methodName = "hintMe")]
		public function showHint(target : DisplayObject, hintText : String) : void
		{
			text = hintText;

			if (target != currentTarget)
			{
				target.addEventListener(MouseEvent.MOUSE_OUT, targetMouseOut);
				if (target.stage) target.stage.addEventListener(MouseEvent.MOUSE_OUT, targetMouseOut);

				timer.reset();
				timer.start();
			}
			currentTarget = target;
		}


		protected function targetMouseOut(e : MouseEvent) : void
		{
			timer.stop();
			if (currentTarget) currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, arguments.callee);
			currentTarget = null;
			dispatchEvent(hideHintEvent);
		}


	}

}
