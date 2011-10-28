package service
{
	import actions.FREEZE;

	import tl.actions.IActionDispatcher;
	import tl.ioc.IoCHelper;
	import tl.ioc.ioc_internal;

	public class FreezeService implements IFreezeService
	{
		private static var instance : FreezeService;

		[Injection]
		public var actionDispatcher : IActionDispatcher;

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

		public function init() : void
		{
			IoCHelper.injectTo( this );
		}
	}
}