package tl.core
{
	import flash.display.*;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	import mx.core.IMXMLObject;

	[Event(name="complete", type="flash.events.Event")]
	public class SWFLoader extends Sprite implements IMXMLObject
	{
		public var source : String = "";
		public var autoLoad : Boolean = false;
		public var document : Object;
		public var symbol : String;

		public static var cache : Array = [];

		public function set dataFormat( value : String ) : void
		{
			_dataFormat = value;
		}

		protected var _dataFormat : String;

		public function SWFLoader( autoLoad : Boolean = false )
		{
			this.autoLoad = autoLoad;
		}

		public function initialized( document : Object, id : String ) : void
		{
			this.document = document;
			if ( autoLoad )
			{
				load();
			}
		}

		public function dispose() : void
		{
			document = null;
		}

		public function load() : void
		{
			var loader : flash.display.Loader = cache[source];
			if ( cache[source] == null )
			{
				loader = cache[source] = new flash.display.Loader();
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadingComplete );
				loader.load( new URLRequest( source ), new LoaderContext( true, ApplicationDomain.currentDomain ) );
			} else
			{
				if ( loader.contentLoaderInfo.bytesTotal > 0 && loader.contentLoaderInfo.bytesLoaded == loader.contentLoaderInfo.bytesTotal )
				{
					processLoader( loader );
				} else
				{
					loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadingComplete );
				}
			}
		}

		protected function loadingComplete( e : Event ) : void
		{
			processLoader( e.target.loader );
		}

		protected function processLoader( loader : flash.display.Loader ) : void
		{
			while ( numChildren ) removeChildAt( 0 );
			if ( symbol != null )
			{
				var clazz : Class = loader.contentLoaderInfo.applicationDomain.getDefinition( symbol ) as Class;
				addChild( new clazz() );
			} else if ( loader.content )
			{
				addChild( loader.content );
			}
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}
