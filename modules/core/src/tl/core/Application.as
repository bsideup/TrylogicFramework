package tl.core
{
	import flash.display.*;
	import flash.events.Event;

	import mx.core.IStateClient;

	import tl.actions.Action;
	import tl.actions.ActionDispatcher;
	import tl.controller.IController;
	import tl.utils.*;

	import mx.core.IUIComponent;

	/**
	 * ...
	 * @author aSt
	 */
	public class Application extends StateClient implements IUIComponent
	{
		public var backgroundColor : Number;
		public var frameRate : Number;
		public var preloader : Class;

		protected var _views : Array = [];
		protected var _controllers : Array = [];

		public function Application()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			if (stage) dispatchEvent(new Event(Event.ADDED_TO_STAGE));
		}

		protected function addedToStage(e : Event = null) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, arguments.callee);
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}

		public function dispose() : void
		{

		}

		public function get views() : Array
		{
			return _views.concat();
		}

		public function set views(value : Array) : void
		{
			value = [].concat(value);
			var view : DisplayObject;
			var method : Object;
			for each (view in _views)
			{
				if (value.indexOf(view) == -1)
				{
					removeChild(view);
				}
			}
			for each (view in value)
			{
				if (_views.indexOf(view) == -1)
				{
					addChild(view);
				}
				setChildIndex(view, numChildren - 1);
			}
			_views = value;
		}

		public function get controllers() : Array
		{
			return _controllers.concat();
		}

		public function set controllers(value : Array) : void
		{
			value = [].concat(value);
			var controller : IController;
			var method : Object;
			for each (controller in _controllers)
			{
				if (value.indexOf(controller) == -1)
				{
					controller.deactivate();
				}
			}
			for each (controller in value)
			{
				if (_controllers.indexOf(controller) == -1)
				{
					controller.activate();
				}
			}
			_controllers = value;
		}
	}

}
