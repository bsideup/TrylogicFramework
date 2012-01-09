package tl.bootloader
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	import tl.bootloader.mixins.LibraryLoader;

	/**
	 * Basic preloader
	 *
	 * override progress and status setter, if you need to show it
	 */
	public class PreloaderBase extends Sprite
	{
		/**
		 * Reference to ApplicationLoader
		 */
		private var app : ApplicationLoader;

		/**
		 * Call it when your preloader job is done
		 */
		private var onCompleteHandler : Function;

		private var mixins : Array;

		private var _currentStage : Class = ApplicationLoader;

		public function PreloaderBase( app : ApplicationLoader )
		{
			new LibraryLoader();

			this.app = app;

			mixins = app.info()["mixins"];
		}

		/**
		 * called when there is some progress
		 *
		 * @param progress		(from 0.0 to 1.0) loading progress
		 */
		public function setProgress( progress : Number, status : String = "" ) : void
		{

		}

		protected function get currentStage() : Class
		{
			return _currentStage;
		}

		internal function process( completeHandler : Function ) : void
		{
			this.onCompleteHandler = completeHandler;

			onMixinComplete();
		}


		/**
		 * Called each time when some [Mixin] completed. When there is no [Mixin] left, calls onCompleteHandler
		 *
		 * @see onCompleteHandler
		 *
		 * @param e
		 */
		private function onMixinComplete( e : Event = null ) : void
		{
			if ( mixins == null || mixins.length == 0 )
			{
				onCompleteHandler();
				return;
			}

			var mixin : String = mixins.pop();

			// Cutoff Flex stuff
			if ( mixin.indexOf( "_FlexInit" ) == -1 && mixin.indexOf( "_Styles" ) == -1 )
			{
				_currentStage = ApplicationDomain.currentDomain.getDefinition( mixin ) as Class;
				_currentStage['process']( app, setProgress, onMixinComplete );
			} else
			{
				onMixinComplete();
			}
		}
	}
}
