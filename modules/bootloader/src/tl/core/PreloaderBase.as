/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 19.06.11
 * Time: 15:31
 * To change this template use File | Settings | File Templates.
 */
package tl.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.ApplicationDomain;

	import mx.core.IFlexModuleFactory;

	public class PreloaderBase extends Sprite implements IPreloader
	{
		protected var app:IFlexModuleFactory;

		protected var mixins:Array;

		protected var onCompleteHandler:Function;

		public function PreloaderBase (app:IFlexModuleFactory)
		{
			this.app = app;

			mixins = app.info()["mixins"];
		}

		public function set progress (value:Number):void
		{
			
		}

		public function set status (value:String):void
		{
		}

		public function process (completeHandler:Function):void
		{
			this.onCompleteHandler = completeHandler;

			onMixinComplete();
		}


		protected function onMixinComplete (e:Event = null):void
		{
			if (mixins.length == 0)
			{
				onCompleteHandler();
				return;
			}

			var mixin:String = mixins.pop();

			if (mixin.indexOf("FlexInit") == -1)
			{
				ApplicationDomain.currentDomain.getDefinition(mixin).process(app, onMixinProgress, onMixinComplete);
			}
			else
			{
				onMixinComplete();
			}
		}

		protected function onMixinProgress (value:Number, status:String = ""):void
		{
			var progressValue:Number = 0.5;
			progressValue += (1 - mixins.length / (app.info()["mixins"].length - 1)) / 2;
			progressValue += (value / (app.info()["mixins"].length - 1)) / 2;
			progress = progressValue;
			this.status = status;
		}
	}
}
