package tl.gui.components
{
	//{ imports

	import tl.gui.*;

	//}

	/**
	 * Button component class.
	 * @author aSt
	 */
	[Event(name = "startDrag", type="flash.events.Event")]
	public class Window extends GUIComponent
	{
		//registerClassAlias("tl.gui.components::Window", WindowSkin);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//{-------------------------------------------------------------------------

		[Bindable]
		public function get headerText() : String
		{
			return _skin['headerText'];
		}

		public function set headerText(value : String) : void
		{
			_skin['headerText'] = value;
		}

		[Bindable]
		public function get bgImageClass() : String
		{
			return _skin['bgImageClass'];
		}

		public function set bgImageClass(value : String) : void
		{
			_skin['bgImageClass'] = value;
		}

		[Bindable]
		public function get data() : Array
		{
			return _skin['innerData'];
		}

		public function set data(value : Array) : void
		{
			_skin['innerData'] = value;
		}

		//}--------------------------------------------------------------------------

		//---------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//{--------------------------------------------------------------------------

		override protected function set skin(value : Skin) : void
		{
			for each(var i in ['headerText', 'bgImageClass', 'innerData'])
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
