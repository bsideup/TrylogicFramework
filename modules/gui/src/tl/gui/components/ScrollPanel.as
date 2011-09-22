package tl.gui.components
{
    import com.hexagonstar.util.debug.Debug;

    import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	import flash.utils.Timer;

	import mx.core.*;
	import mx.events.PropertyChangeEvent;

	/**
	 * ...
	 * @author aSt
	 */
	[DefaultProperty("child")]
	public class ScrollPanel extends Sprite implements IUIComponent, IMXMLObject
	{
		protected var _scrollStaticX : uint = 0;
		protected var _scrollStaticY : uint = 0;
		private var _scrollRect : Rectangle = new Rectangle();
		protected var tmr : Timer = new Timer(25);
		protected var changed : Boolean = false;

		public var document : DisplayObjectContainer;

		override public function get scrollRect() : Rectangle
		{
			return super.scrollRect;
		}

		[Bindable("propertyChange")]
		override public function set scrollRect(value : Rectangle) : void
		{
			super.scrollRect = _scrollRect = value;
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scrollRect", value, value));
		}

		public function set child(value : Sprite) : void
		{
			if (numChildren)
			{
				child.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				removeChildAt(0);
			}
			addChildAt(value, 0);
			value.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, int.MAX_VALUE, true);
			value.cacheAsBitmap = true;
		}

		public function get child() : Sprite
		{
			return getChildAt(0) as Sprite;
		}

		public function positionInvalidate(e : TimerEvent) : void
		{
			scrollRect = _scrollRect;
			tmr.stop();
		}

		protected function dragHandler(e : MouseEvent) : void
		{
			if (!changed) Mouse.cursor = MouseCursor.HAND;

			changed = true;
			posX = _scrollStaticX - e.stageX;
			posY = _scrollStaticY - e.stageY;
		}

		protected function dragUpHandler(e : MouseEvent) : void
		{
            if (changed)
			{
				e.preventDefault();
				e.stopPropagation();
                changed = false;
			}

			getChildAt(0).removeEventListener(MouseEvent.MOUSE_UP, arguments.callee, true);

			savedStage.removeEventListener(MouseEvent.MOUSE_MOVE, dragHandler);
			savedStage.removeEventListener(MouseEvent.MOUSE_UP, arguments.callee, false);
			Mouse.cursor = MouseCursor.AUTO;
		}

		private var savedStage : Stage;
		protected function mouseDownHandler(e : MouseEvent)
		{
			_scrollStaticX = posX + e.stageX;
			_scrollStaticY = posY + e.stageY;

			savedStage = stage;

			stage.addEventListener(MouseEvent.MOUSE_MOVE, dragHandler);

			getChildAt(0).addEventListener(MouseEvent.MOUSE_UP, dragUpHandler, true, int.MAX_VALUE);
            stage.addEventListener(MouseEvent.MOUSE_UP, dragUpHandler, false, int.MAX_VALUE);
		}

		public function initialized(document : Object, id : String) : void
		{
			cacheAsBitmap = true;
			opaqueBackground = 1;
			tmr.addEventListener(TimerEvent.TIMER, positionInvalidate);
		}

		public function dispose() : void
		{

		}

		public function set posX(value : int) : void
		{
			value = Math.max(0, value);
			var maximum : Number = child.width - _scrollRect.width;
			value = value > maximum ? maximum : value;
			_scrollRect.x = value;
			tmr.start();
		}

		public function get posX() : int
		{
			return scrollRect.x;
		}

		public function set posY(value : int) : void
		{
			value = Math.max(0, value);
			var maximum : int = child.height - _scrollRect.height;
			value = value > maximum ? maximum : value;
			_scrollRect.y = value;
			tmr.start();
		}

		public function get posY() : int
		{
			return scrollRect.y;
		}

		override public function set width(value : Number) : void
		{
			_scrollRect.width = value;
			tmr.start();
		}

		override public function get width() : Number
		{
			return _scrollRect.width;
		}

		override public function set height(value : Number) : void
		{
			_scrollRect.height = value;
			tmr.start();
		}

		override public function get height() : Number
		{
			return _scrollRect.height;
		}
	}
}
