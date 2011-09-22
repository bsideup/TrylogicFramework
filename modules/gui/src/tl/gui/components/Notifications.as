/**
 * Created by IntelliJ IDEA.
 * User: BSiDeUp
 * Date: 07.06.11
 * Time: 18:03
 * To change this template use File | Settings | File Templates.
 */
package tl.gui.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	import tl.gui.GUIComponent;
	import tl.gui.Skin;

	import tl.gui.components.notifications.INotification;

	[Event(name="notificationClicked", type="flash.events.Event")]
	public class Notifications extends GUIComponent
	{
		protected var _notifications : Array = [];

		override protected function set skin(value : Skin) : void
		{
			for each(var i in ['notifications'])
			{
				if (_skin[i]) value[i] = _skin[i];
			}
			super.skin = value;
		}

		public function push(nofitication : INotification) : void
		{
			_notifications.push(nofitication);
			_skin['notifications'] = _notifications;
		}

		override protected function configureListeners() : void
		{
			addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);

			addEventListener("notificationClicked", removeNotification);
		}

		public function removeNotification(e : Event) : void
		{
			_notifications.splice(_notifications.indexOf(e), 1);
			_skin['notifications'] = _notifications;
		}

		protected function mouseHandler(e : MouseEvent) : void
		{
			if (_skin.currentState != "disabled") _skin.currentState = e.type;
		}
	}
}
