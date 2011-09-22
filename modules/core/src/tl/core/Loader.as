package tl.core
{
	import flash.display.*;
	import flash.events.Event;
	import flash.net.*;
	import flash.system.LoaderContext;

	public class Loader extends Sprite
	{
		protected var _child : Sprite = new Sprite();
		protected var _source : Object;
		protected var _width : Number;
		protected var _height : Number;

		override public function set width(value : Number) : void
		{
			_child.width = _width = value;
		}

		override public function get width() : Number
		{
			return _child.width;
		}


		override public function set height(value : Number) : void
		{
			_child.height = _height = value;
		}

		override public function get height() : Number
		{
			return _child.height;
		}

		public function get source() : Object
		{
			return _source;
		}

		public function set source(value : Object) : void
		{
			if (value == null) return;
			_source = value;
			if (numChildren)
			{
				removeChild(_child);
			}
			_child = new Sprite();
			var bitmap : Bitmap;

			if (value is Class)
			{
				var obj : * = new (value)();
				if (obj is Bitmap)
				{
					bitmap = obj;
				}
				else if (obj is DisplayObject)
				{
					obj.width = _width;
					obj.height = _height;
					addChild(_child = obj);
					return;
				}
				else
				{
					throw new ArgumentError(value);
				}
			}
			else if (value is Bitmap)
			{
				bitmap = Bitmap(value);
			}
			else if (value is BitmapData)
			{
				bitmap = new Bitmap(BitmapData(value));
			}
			else if (value is DisplayObject)
			{
				Sprite(_child).graphics.copyFrom(value.graphics);
				addChild(_child);
				return;
			}
			else
			{
				throw new ArgumentError(value);
			}

			_child.graphics.beginBitmapFill(bitmap.bitmapData);
			_child.graphics.drawRect(0, 0, bitmap.width, bitmap.height);
			_child.graphics.endFill();

			addChild(_child);
		}
	}
}
