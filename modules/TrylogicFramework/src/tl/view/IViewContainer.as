package tl.view
{
	import flash.display.DisplayObjectContainer;

	public interface IViewContainer extends IView
	{
		function get container() : DisplayObjectContainer;
	}
}
