package controllers
{
	import tl.actions.IActionLogger;
	import tl.ioc.ioc_internal;

	public class ActionLogger implements IActionLogger
	{
		private static const instance : ActionLogger = new ActionLogger();

		[Injection]
		public var logger : ILogger;

		ioc_internal static function getInstance() : ActionLogger
		{
			return instance;
		}

		public function log( type : String, params : Array = null ) : void
		{
			logger.log( type + "(" + params + ")!" );
		}
	}
}
