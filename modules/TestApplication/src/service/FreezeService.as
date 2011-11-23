package service
{
	import actions.FREEZE;

	import core.ILogger;

	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;
	import tl.service.Service;

	public class FreezeService extends Service implements IFreezeService
	{
		private static var instance : FreezeService;

		[Injection]
		public var logger : ILogger;

		public var text : String = "";

		public function FreezeService()
		{
			instance = this;
		}

		ioc_internal function getInstance() : FreezeService
		{
			if ( instance == null )
			{
				instance = new FreezeService();
			}

			return instance;
		}

		[Action]
		FREEZE function onFreeze() : void
		{
			logger.log( text );
		}

		override protected function internalInit() : void
		{
			IoCHelper.injectTo( this );
		}
	}
}