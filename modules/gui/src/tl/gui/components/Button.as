package tl.gui.components
{
	//{ imports

	import flash.events.MouseEvent;

	import mx.core.IStateClient;
	import mx.core.UIComponent;

	import tl.gui.*;
	import tl.core.StateClient;

	import flash.net.*;

	import tl.gui.defaultSkins.*;

	//}

	/**
	 * Button component class.
	 * @author aSt
	 */
	[DefaultProperty("text")]
	public class Button extends GUIComponent
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//{-------------------------------------------------------------------------

		[Bindable]
		public function get text() : String
		{
			return _skin['text'];
		}

		public function set text(value : String) : void
		{
			_skin['text'] = value;
		}

		[Bindable]
		public function get icon() : Class
		{
			return _skin['icon'];
		}

		public function set icon(value : Class) : void
		{
			_skin['icon'] = value;
		}

		[Bindable]
		public function get upSkin() : Class
		{
			return _skin['upSkin'];
		}

		public function set upSkin(value : Class) : void
		{
			_skin['upSkin'] = value;
		}

		[Bindable]
		public function get overSkin() : Class
		{
			return _skin['overSkin'];
		}

		public function set overSkin(value : Class) : void
		{
			_skin['overSkin'] = value;
		}

		[Bindable]
		public function get downSkin() : Class
		{
			return _skin['downSkin'];
		}

		public function set downSkin(value : Class) : void
		{
			_skin['downSkin'] = value;
		}

		[Bindable]
		public function get disabledSkin() : Class
		{
			return _skin['disabledSkin'];
		}

		public function set disabledSkin(value : Class) : void
		{
			_skin['disabledSkin'] = value;
		}


		//}--------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//{--------------------------------------------------------------------------

		override protected function set skin(value : Skin) : void
		{
			for each(var i in ['text', 'icon', 'upSkin', 'downSkin', 'overSkin', 'disabledSkin'])
			{
				if (_skin[i]) value[i] = _skin[i];
			}
			super.skin = value;
		}

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//{--------------------------------------------------------------------------

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function Button()
		{
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//{--------------------------------------------------------------------------

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//{--------------------------------------------------------------------------

		override protected function configureListeners() : void
		{
			addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
		}

		protected function mouseHandler(e : MouseEvent) : void
		{
			if (_skin.currentState != "disabled") _skin.currentState = e.type;
		}

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//{--------------------------------------------------------------------------

		//}--------------------------------------------------------------------------
	}
}
