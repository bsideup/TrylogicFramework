package tl.bootloader
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

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
		protected var app : ApplicationLoader;

		/**
		 * Call it when your preloader job is done
		 */
		protected var onCompleteHandler : Function;

		private var mixins : Array;

		public function PreloaderBase( app : ApplicationLoader )
		{
			this.app = app;

			mixins = app.info()["mixins"];
		}

		/**
		 * called when there is some progress
		 *
		 * @param value		(from 0.0 to 1.0) loading progress
		 */
		public function set progress( value : Number ) : void
		{

		}

		/**
		 * Text helper for progress status
		 *
		 * @param value		loading status
		 */
		public function set status( value : String ) : void
		{
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
		protected function onMixinComplete( e : Event = null ) : void
		{
			if ( mixins.length == 0 )
			{
				onCompleteHandler();
				return;
			}

			var mixin : String = mixins.pop();

			// Cutoff Flex stuff
			if ( mixin.indexOf( "_FlexInit" ) == -1 && mixin.indexOf( "_Styles" ) == -1 )
			{
				ApplicationDomain.currentDomain.getDefinition( mixin ).process( app, onMixinProgress, onMixinComplete );
			} else
			{
				onMixinComplete();
			}
		}

		private function onMixinProgress( progress : Number, status : String = "" ) : void
		{
			// We think, that 0.5 - is state, when application already loaded
			var progressValue : Number = 0.5;

			progressValue += (1 - mixins.length / (app.info()["mixins"].length - 1)) / 2;
			progressValue += (progress / (app.info()["mixins"].length - 1)) / 2;

			this.progress = progressValue;
			this.status = status;
		}
	}
}
