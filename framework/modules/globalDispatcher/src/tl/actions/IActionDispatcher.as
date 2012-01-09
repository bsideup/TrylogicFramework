package tl.actions
{
	public interface IActionDispatcher
	{
		/**
		 * Add action listeners, marked with [Action] Metatag, and declared in Action namespace
		 *
		 * @param object target for metatag scan
		 */
		function addHandler( object : Object ) : void;

		/**
		 * Remove action listeners, marked with [Action] Metatag, and declared in Action namespace
		 *
		 * @param object target for metatag scan
		 */
		function removeHandler( object : Object ) : void;

		/**
		 * Dispatch Action
		 *
		 * @param type		type of the Action to dispatch
		 * @param params	parameters, passed to Action listener
		 * @param async		if true, will be called later (after 1ms)
		 */
		function dispatch( type : String, params : Array = null, async : Boolean = false ) : void;

		/**
		 * Check, if there're Action listeners for type
		 *
		 * @param type	type of the Action to check
		 * @return		A <code>true</code> value means, that there is Action listeners for passed type
		 */
		function hasActionListener( type : String ) : Boolean;
	}
}
