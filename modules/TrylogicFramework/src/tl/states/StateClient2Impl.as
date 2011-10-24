package tl.states
{
	import flash.events.Event;

	import mx.core.IStateClient2;
	import mx.core.mx_internal;
	import mx.states.IOverride;
	import mx.states.State;

	import tl.ioc.ioc_internal;

	internal class StateClient2Impl implements IStateClient2
	{
		private var target : *;

		private var _currentState : String;
		private var _oldState : String;
		private var _states : Object;
		private var _transitions : Array;

		public function StateClient2Impl( target : * )
		{
			this.target = target;
		}

		ioc_internal static function getInstanceForInstance( instance : * ) : StateClient2Impl
		{
			return new StateClient2Impl( instance );
		}

		[Bindable]
		public function get currentState() : String
		{
			return _currentState;
		}

		public function set currentState( value : String ) : void
		{
			_oldState = _currentState;
			_currentState = value;
			statesInvalidate();
		}

		[ArrayElementType("mx.states.State")]
		public function get states() : Array
		{
			var statesArray : Array = [];
			for each ( var state : State in _states )
			{
				statesArray.push( state );
			}
			return statesArray;
		}

		public function set states( value : Array ) : void
		{
			_states = { };
			for each ( var state : State in value )
			{
				state.mx_internal::initialize();
				_states[state.name] = state;
			}
			statesInvalidate();
		}

		[ArrayElementType("mx.states.Transition")]
		public function get transitions() : Array
		{
			return _transitions;
		}

		public function set transitions( value : Array ) : void
		{
			_transitions = value;
		}


		public function hasState( stateName : String ) : Boolean
		{
			return _states[stateName] is State;
		}

		protected function statesInvalidate() : void
		{
			if ( !_states || _oldState == _currentState ) return;
			var oride : IOverride;

			if ( _oldState && _states[_oldState] )
			{
				for each ( oride in _states[_oldState].overrides ) oride.remove( target );
				_states[_oldState].mx_internal::dispatchExitState();
			}

			if ( _states[_currentState] )
			{
				for each ( oride in _states[_currentState].overrides ) oride.apply( target );
				_states[_currentState].mx_internal::dispatchEnterState();
			}

		}

		public function addEventListener( type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void
		{
			target.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}

		public function removeEventListener( type : String, listener : Function, useCapture : Boolean = false ) : void
		{
			target.removeEventListener( type, listener, useCapture );
		}

		public function dispatchEvent( event : Event ) : Boolean
		{
			return target.dispatchEvent( event );
		}

		public function hasEventListener( type : String ) : Boolean
		{
			return target.hasEventListener( type );
		}

		public function willTrigger( type : String ) : Boolean
		{
			return target.willTrigger( type );
		}
	}
}
