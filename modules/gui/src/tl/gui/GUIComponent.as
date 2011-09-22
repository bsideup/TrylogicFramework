package tl.gui
{
	import tl.actions.ActionDispatcher;

	import flash.utils.getQualifiedClassName;

	import tl.core.StateClient;

	//{ imports

	import flash.display.*;
	import flash.events.*;

	import mx.core.*;

	import flash.net.getClassByAlias;

	//}

	/**
	 * GUI component class.
	 * @author aSt
	 */
	public class GUIComponent extends Sprite implements IMXMLObject
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//{--------------------------------------------------------------------------

		public function get skinClass() : Class
		{
			return _skinClass;
		}

		public function set skinClass(value : Class) : void
		{
			if (value == _skinClass) return;
			skin = new (_skinClass = value)();
		}

		[Bindable]
		protected function get skin() : Skin
		{
			return _skin;
		}

		protected function set skin(value : Skin) : void
		{
			value.width = _skin.width;
			value.height = _skin.height;
			value.currentState = _skin.currentState;

			removeChild(_skin);
			addChild(_skin = value);
		}

		[Bindable]
		override public function get width() : Number
		{
			return _skin.width;
		}

		override public function set width(value : Number) : void
		{
			_skin.width = value;
		}

		[Bindable]
		override public function get height() : Number
		{
			return _skin.height;
		}

		override public function set height(value : Number) : void
		{
			_skin.height = value;
		}

		[Bindable]
		public function get disabled() : Boolean
		{
			return _skin.currentState == "disabled";
		}

		public function set disabled(value : Boolean) : void
		{
			_skin.currentState = value == true ? "disabled" : MouseEvent.MOUSE_OUT;
		}

		public function set currentState(value : String) : void
		{
			_skin.currentState = value;
		}

		public function get currentState() : String
		{
			return _skin.currentState;
		}


		public function set hint(value : String) : void
		{
			if (value == null || value == "")
			{
				removeEventListener(MouseEvent.MOUSE_OVER, hintHandler);
				_hintText = null;
			}
			else
			{
				if (_hintText == null)
				{
					addEventListener(MouseEvent.MOUSE_OVER, hintHandler);
				}

				_hintText = value;
			}
		}

		protected function hintHandler(e : MouseEvent) : void
		{
			ActionDispatcher.dispatch('Hints', 'hintMe', [e.currentTarget, _hintText]);
		}

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//{--------------------------------------------------------------------------

		protected var _hintText : String;
		protected var _skinClass : Class = getClassByAlias(getQualifiedClassName(this));
		protected var _skin : Skin = new _skinClass();

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

		public function GUIComponent()
		{
			addChild(_skin);
			configureListeners();
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

		protected function configureListeners() : void
		{
		}

		public function initialized(document : Object, id : String) : void
		{
			_skin.initialized(document, id);
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
