package view.testView
{
	import flash.text.TextField;

	import tl.view.IView;

	public interface ITestView extends IView
	{
		function get myLabel() : TextField;

		function get myAnotherLabel() : TextField;
	}
}
