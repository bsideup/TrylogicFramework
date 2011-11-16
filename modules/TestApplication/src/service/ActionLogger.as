package service
{
	import tl.actions.IActionLogger;
	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;

	public class ActionLogger implements IActionLogger
	{
		private static var instance : ActionLogger;

		[Injection]
		public var logger : ILogger;

		public function ActionLogger()
		{
			IoCHelper.injectTo( this );
		}

		ioc_internal static function getInstance() : ActionLogger
		{
			if(instance == null)
			{
				instance = new ActionLogger();
			}
			return instance;
		}

		public function log( type : String, params : Array = null ) : void
		{
			logger.log( type + "(" + params + ")!" );
		}
	}
}
