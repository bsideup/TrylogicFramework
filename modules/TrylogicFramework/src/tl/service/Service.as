package tl.service
{
	import mx.utils.ObjectProxy;

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
			ObjectProxy
		}

		lifecycle function init() : void
		{

		}
	}
}
