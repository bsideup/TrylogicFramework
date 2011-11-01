package tl.viewController
{
	import flash.display.Stage;

	public class ApplicationViewController extends ViewControllerContainer implements IApplicationController
	{
		[Injection]
		public var stage : Stage;
	}
}
