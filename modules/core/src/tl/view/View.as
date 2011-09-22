package tl.view
{
	import flash.events.Event;

	import mx.core.UIComponent;

	public class View extends UIComponent
	{

		public function View()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}

		protected function addedToStage(e : Event) : void
		{
		}

		protected function removedFromStage(e : Event) : void
		{
		}

		public function dispose() : void
		{
		}
	}
}
