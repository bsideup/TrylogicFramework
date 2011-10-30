package tl.core
{
	import flash.display.*;

	public class Loader extends Sprite
	{
		protected var _embeddedDisplayObject : DisplayObject = new Sprite();
		protected var _source : Object;
		protected var _width : Number;
		protected var _height : Number;

		override public function set width( value : Number ) : void
		{
			_embeddedDisplayObject.width = _width = value;
		}

		override public function get width() : Number
		{
			return _embeddedDisplayObject.width;
		}

		override public function set height( value : Number ) : void
		{
			_embeddedDisplayObject.height = _height = value;
		}

		override public function get height() : Number
		{
			return _embeddedDisplayObject.height;
		}

		public function get embeddedDisplayObject() : DisplayObject
		{
			return _embeddedDisplayObject;
		}

		public function get source() : Object
		{
			return _source;
		}

		public function set source( value : Object ) : void
		{
			if ( value == null ) return;
			_source = value;

			if ( value is Class )
			{
				this.source = new (value as Class)();
			} else
			{
				if ( numChildren )
				{
					removeChild( _embeddedDisplayObject );
				}

				if ( value is Bitmap )
				{
					_embeddedDisplayObject = Bitmap( value );
				} else if ( value is BitmapData )
				{
					_embeddedDisplayObject = new Bitmap( BitmapData( value ) );
				} else if ( value is DisplayObject )
				{
					_embeddedDisplayObject = DisplayObject( value );
				} else
				{
					throw new ArgumentError( value );
				}

				addChild( _embeddedDisplayObject );
			}
		}
	}
}
