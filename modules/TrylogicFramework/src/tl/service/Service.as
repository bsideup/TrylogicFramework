package tl.service
{
	import tl.actions.IActionDispatcher;
	import tl.ioc.IoCHelper;

	public class Service implements IService
	{
		[Injection]
		public var actionDispatcher : IActionDispatcher;

		public final function init() : void
		{
			IoCHelper.injectTo(this);
			internalInit();
		}

		protected function internalInit() : void
		{
			
		}
	}
}
