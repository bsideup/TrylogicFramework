package tl.service
{
	import tl.actions.IActionDispatcher;
	import tl.ioc.IoCHelper;

	public class Service implements IService
	{
		[Injection]
		public var actionDispatcher : IActionDispatcher;

		protected namespace lifecycle = "http://www.trylogic.ru/service/lifecycle";

		public final function init() : void
		{
			IoCHelper.injectTo( this );
			lifecycle::init();
		}

		lifecycle function init() : void
		{

		}
	}
}
