package tl.core
{
	import flash.display.*;

	import mx.core.*;
	import mx.states.*;
	import mx.events.PropertyChangeEvent;

	import tl.actions.ActionDispatcher;

	[Event(name="mouseDrop", type="flash.events.MouseEvent")]
	public class StateClient extends Sprite implements IMXMLObject, IStateClient, IStateClient2
	{
		//{ Getters\setters
		protected var _currentState : String;
		private var _oldState : String;
		private var _states : Object;
		private var _transitions : Array;

		//----------------------------------
		//  currentState
		//----------------------------------
		[Bindable]
		public function get currentState() : String
		{
			return _currentState;
		}

		public function set currentState(value : String) : void
		{
			_oldState = _currentState;
			_currentState = value;
			statesInvalidate();
		}

		[ArrayElementType("mx.states.State")]
		//----------------------------------
		//  states
		//----------------------------------
		public function get states() : Array
		{
			var statesArray : Array = [];
			for each (var state : State in _states)
			{
				statesArray.push(state);
			}
			return statesArray;
		}

		public function set states(value : Array) : void
		{
			_states = { };
			for each (var state : State in value)
			{
				state.mx_internal::initialize();
				_states[state.name] = state;
			}
			statesInvalidate();
		}

		//----------------------------------
		//  transitions
		//----------------------------------
		[ArrayElementType("mx.states.Transition")]
		public function get transitions() : Array
		{
			return _transitions;
		}

		public function set transitions(value : Array) : void
		{
			_transitions = value;
		}

		//} endregion

		public function StateClient()
		{
			ActionDispatcher.addHandler(this);
			init();
		}

		public function act(className : String, methodName : String, obj : Array = null) : void
		{
			ActionDispatcher.dispatch(className, methodName, obj);
		}

		protected function init() : void
		{
		}

		public function initialize() : void
		{

		}

		public function initialized(document : Object, id : String) : void
		{
		}

		public function hasState(stateName : String) : Boolean
		{
			return _states[stateName] is State;
		}

		protected function statesInvalidate() : void
		{
			if (!_states || _oldState == _currentState) return;
			var oride : IOverride;

			if (_oldState && _states[_oldState])
			{
				for each (oride in _states[_oldState].overrides) oride.remove(this);
				_states[_oldState].mx_internal::dispatchExitState();
			}

			if (_states[_currentState])
			{
				for each (oride in _states[_currentState].overrides) oride.apply(this);
				_states[_currentState].mx_internal::dispatchEnterState();
			}

		}
	}

}
