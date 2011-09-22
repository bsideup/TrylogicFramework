package tl.actions
{
	import flash.events.Event;
	import flash.net.registerClassAlias;

	/**
	 * ...
	 * @author aSt
	 */
	registerClassAlias("ru.trylogic.messages.MethodInvokeMessage", Action);
	public class Action
	{
		public var className : String;
		public var methodName : String;
		public var params : Array;

		public function Action(className : String = null, methodName : String = null, params : Array = null)
		{
			this.className = className;
			this.methodName = methodName;
			this.params = params;
		}

		public function clone() : Action
		{
			return new Action(className, methodName, params);
		}

		public function toString() : String
		{
			return "Action[" + className + "::" + methodName + "(" + params + ")}";
		}
	}

}
