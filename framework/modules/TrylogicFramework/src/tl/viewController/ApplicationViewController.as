package tl.viewController
{
	import flash.display.Stage;

	public class ApplicationViewController extends ViewController implements IApplicationController
	{
		[Injection]
		public var stage : Stage;
	}
}
