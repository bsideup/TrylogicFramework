package service
{
	import tl.actions.IActionLogger;
	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;

	public class ActionLogger implements IActionLogger
	{
		[Injection]
		public var logger : ILogger;

		public function ActionLogger()
		{
			IoCHelper.injectTo( this );
		}

		public function log( type : String, params : Array = null ) : void
		{
			logger.log( type + "(" + params + ")!" );
		}
	}
}
