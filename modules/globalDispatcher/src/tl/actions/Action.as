package tl.actions
{
	import flash.net.registerClassAlias;

	registerClassAlias( "ru.trylogic.messages.MethodInvokeMessage", Action );

	/**
	 * This is utility class, used for AMF-based protocol.
	 * It's mapped to ru.trylogic.messages.MethodInvokeMessage Java-class
	 *
	 */
	public class Action
	{
		/**
		 * String-based action identifer
		 */
		public var type : String;

		/**
		 * Array with parameters, passed to action listener for this Action
		 */
		public var params : Array;

		/**
		 *
		 * @param type	String-based action identifer
		 * @param params Array with parameters, passed to action listener for this Action
		 */
		public function Action( type : String = "", params : Array = null )
		{
			this.type = type;
			this.params = params;
		}

		public function clone() : Action
		{
			return new Action( type, params );
		}

		public function toString() : String
		{
			return "Action[" + type + "(" + params + ")}";
		}
	}

}
