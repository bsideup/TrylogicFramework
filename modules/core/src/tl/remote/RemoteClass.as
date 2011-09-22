package tl.remote
{
	import flash.events.EventDispatcher;

	import mx.events.PropertyChangeEvent;

	import tl.actions.*;

	/**
	 * ...
	 * @author aSt
	 */
	public class RemoteClass extends EventDispatcher
	{
		protected var channel : String;
		protected var className : String;

		public function RemoteClass(channel : String = "Service", className : String = "Main")
		{
			ActionDispatcher.addHandler(this);

			this.channel = channel;
			this.className = className;
		}

		public function invoke(methodName : String, params : Array = null) : void
		{
			ActionDispatcher.dispatch(channel, "send", [new Action(className, methodName, params)]);
		}

		protected function updateProperty(prop : String, value : *) : void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, prop, null, value));
		}

	}

}
