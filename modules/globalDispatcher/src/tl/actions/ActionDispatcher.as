package tl.actions
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	import tl.utils.getActionsInType;

	public class ActionDispatcher
	{
		public static var LOGGER_INSTANCE : IActionLogger;


		private static const callbacks : Array = new Array();

		public static function addHandler(object : Object) : void
		{
			for each (var method : Object in getActionsInType(object))
			{
				addActionListener(method.className, method.methodName, method.method);
			}
		}

		public static function removeHandler(object : Object) : void
		{
			for each (var method : Object in getActionsInType(object))
			{
				removeActionListener(method.className, method.methodName, method.method);
			}
		}

		public static function addActionListener(className : String, methodName : String, listener : Function) : void
		{
			if (getActions(className, methodName)[listener] != null) return;
			getActions(className, methodName)[listener] = listener;
		}

		public static function dispatch(className : String, methodName : String, params : Array) : void
		{
			if (LOGGER_INSTANCE) LOGGER_INSTANCE.log(getTimer().toString() + " : " + [className + "::" + methodName + "(" + params + ")"], 1);

			for each(var f : Function in getActions(className, methodName))
			{
				f.apply(null, params);
			}
		}

		public static function dispatchAction(act : Action) : void
		{
			if (act == null) return;
			dispatch(act.className, act.methodName, act.params);
		}

		public static function hasActionListener(className : String, methodName : String) : Boolean
		{
			return callbacks[className + "." + methodName] != null;
		}

		public static function removeActionListener(className : String, methodName : String, listener : Function) : void
		{
			if (!hasActionListener(className, methodName)) return;

			delete callbacks[className + "." + methodName][listener];
		}

		private static function getActions(className : String, methodName : String) : Dictionary
		{
			if (callbacks[className + "." + methodName] == null)
			{
				return callbacks[className + "." + methodName] = new Dictionary();
			}
			return callbacks[className + "." + methodName];
		}
	}

}
