package tl.actions
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;
	import tl.utils.MemberDescription;
	import tl.utils.describeTypeCached;
	import tl.utils.getMethodsWithMetadata;

	[Action]
	/**
	 * Global dispatcher implementation.
	 *
	 * @example
	 * example of Action declaration:
	 * <listing version="3.0">
	 *	 public namespace SOME_ACTION = "SOME_ACTION";</listing>
	 *
	 * example of action listener class:
	 * <listing version="3.0">
	 *	 public class MyClass
	 *	 {
	 *			public fuction MyClass()
	 *			{
	 *				ActionDispatcher.getInstance().addHandler(this);
	 *			}
	 *
	 *			[Action]
	 *			SOME_ACTION fuction myFunc(myParam : String, myAnotherParam : uint) : void
	 *			{
	 *				trace(myParam, myAnotherParam);
	 *			}
	 *		}</listing>
	 *
	 * example of action dispatching:
	 * <listing version="3.0">
	 *	 ActionDispatcher.getInstance().dispatch(SOME_ACTION, ["Hello, World!", 42]);</listing>
	 */
	public class ActionDispatcher implements IActionDispatcher
	{
		private static var instance : ActionDispatcher;

		private const callbacks : Array = new Array();

		[Injection]
		/**
		 * <code>tl.actions.IActionLogger</code> instance
		 */
		public var logger : IActionLogger;

		{
			if ( describeTypeCached( ActionDispatcher )..metadata.(@name == "Action").length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Action to flex compiler arguments!" )
			}
		}

		public static function getInstance() : ActionDispatcher
		{
			if ( instance == null )
			{
				instance = new ActionDispatcher();
			}

			return instance;
		}

		ioc_internal static function getInstanceForInstance( instance : * ) : ActionDispatcher
		{
			var actionDispatcher : ActionDispatcher = getInstance();

			if ( instance != null ) actionDispatcher.addHandler( instance );

			return actionDispatcher;
		}

		public function ActionDispatcher()
		{
			IoCHelper.injectTo( this );
		}

		/**
		 * Add action listeners, marked with [Action] Metatag, and declared in Action namespace
		 *
		 * @param object target for metatag scan
		 */
		public function addHandler( object : Object ) : void
		{
			var ns : Namespace;
			var methodName : String;
			for each ( var memberDescription : MemberDescription in getMethodsWithMetadata( object, "Action" ) )
			{
				ns = new Namespace( null, memberDescription.uri );
				methodName = memberDescription.memberName;
				addActionListener( memberDescription.uri, object.ns::[methodName] );
			}
		}

		/**
		 * Remove action listeners, marked with [Action] Metatag, and declared in Action namespace
		 *
		 * @param object target for metatag scan
		 */
		public function removeHandler( object : Object ) : void
		{
			var ns : Namespace;
			var methodName : String;
			for each ( var memberDescription : MemberDescription in getMethodsWithMetadata( object, "Action" ) )
			{
				ns = new Namespace( null, memberDescription.uri );
				methodName = memberDescription.memberName;
				removeActionListener( memberDescription.uri, object.ns::[methodName] );
			}
		}

		/**
		 * Dispatch Action
		 *
		 * @param type		type of the Action to dispatch
		 * @param params	parameters, passed to Action listener
		 * @param async		if true, will be called later (after 1ms)
		 */
		public function dispatch( type : String, params : Array = null, async : Boolean = false ) : void
		{
			logger.log( type, params );

			var timer : Timer;

			for each( var f : Function in getActions( type ) )
			{
				if ( async )
				{
					timer = new Timer( 1, 1 );
					timer.addEventListener( TimerEvent.TIMER_COMPLETE, function( e : Event ) : void
					{
						IEventDispatcher( e.currentTarget ).removeEventListener( e.type, arguments.callee );
						f.apply( null, params );
					} );
					timer.start();
				} else
				{
					f.apply( null, params );
				}
			}
		}

		/**
		 * Check, if there're Action listeners for type
		 *
		 * @param type	type of the Action to check
		 * @return		A <code>true</code> value means, that there is Action listeners for passed type
		 */
		public function hasActionListener( type : String ) : Boolean
		{
			return callbacks[type] != null;
		}

		private function addActionListener( type : String, listener : Function ) : void
		{
			if ( type == null || type == "" ) throw new ArgumentError( "Wrong type value! (" + type + ")" );
			if ( getActions( type )[listener] != null ) return;
			getActions( type )[listener] = listener;
		}

		private function removeActionListener( type : String, listener : Function ) : void
		{
			if ( !hasActionListener( type ) ) return;

			delete callbacks[type][listener];
		}

		private function getActions( type : String ) : Dictionary
		{
			if ( callbacks[type] == null )
			{
				return callbacks[type] = new Dictionary();
			}
			return callbacks[type];
		}
	}

}
