package service
{
	import actions.FREEZE;

	import core.ILogger;

	import tl.service.Service;

	public class FreezeService extends Service implements IFreezeService
	{
		[Injection]
		public var logger : ILogger;

		public var text : String = "";

		[Action]
		FREEZE function onFreeze() : void
		{
			logger.log( text );
		}
	}
}