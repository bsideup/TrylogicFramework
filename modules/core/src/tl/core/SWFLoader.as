package tl.core
{
	//{ imports

	import com.hexagonstar.util.debug.Debug;

	import flash.display.*;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.utils.Timer;

	import mx.core.IMXMLObject;

	//}

	/**
	 * SWFLoader class.
	 * @author aSt
	 */
	[Event(name="complete", type="flash.events.Event")]
	public class SWFLoader extends StateClient
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//{--------------------------------------------------------------------------

		public var source : String = "";
		public var autoLoad : Boolean = false;
		public var document : Object;
		public var symbol : String;

		public static var cache : Array = [];

		public function set dataFormat(value : String) : void
		{
			_dataFormat = value;
		}

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//{--------------------------------------------------------------------------

		//protected var loader			: flash.display.Loader		= new flash.display.Loader();

		protected var _dataFormat : String;

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

		public function SWFLoader(autoLoad : Boolean = false)
		{
			//this.mouseEnabled = false;
			//loader.mouseEnabled = false;
			this.autoLoad = autoLoad;
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//{--------------------------------------------------------------------------

		override public function initialized(document : Object, id : String) : void
		{
			this.document = document;
			if (autoLoad)
			{
				load();
			}
		}

		public function dispose() : void
		{
			document = null;
		}

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//{--------------------------------------------------------------------------

		public function load() : void
		{
			var loader : flash.display.Loader = cache[source];
			if (cache[source] == null)
			{
				loader = cache[source] = new flash.display.Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadingComplete);
				loader.load(new URLRequest(source), new LoaderContext(true, ApplicationDomain.currentDomain));
			}
			else
			{
				if (loader.contentLoaderInfo.bytesTotal > 0 && loader.contentLoaderInfo.bytesLoaded == loader.contentLoaderInfo.bytesTotal)
				{
					processLoader(loader);
				}
				else
				{
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadingComplete);
				}
			}
		}

		protected function loadingComplete(e : Event) : void
		{
			processLoader(e.target.loader);
		}

		protected function processLoader(loader : flash.display.Loader) : void
		{
			while (numChildren) removeChildAt(0);
			if (symbol != null)
			{
				addChild(new (loader.contentLoaderInfo.applicationDomain.getDefinition(symbol))());
			}
			else if (loader.content)
			{
				addChild(loader.content);
			}
			dispatchEvent(new Event(Event.COMPLETE));
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
