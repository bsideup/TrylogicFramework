package tl.viewController
{
	import tl.view.IView;

	public interface IVIewController
	{
		function get viewIsLoaded() : Boolean;

		function get view() : IView;

		function get viewControllerContainer() : IViewControllerContainer;

		function set viewControllerContainer( value : IViewControllerContainer ) : void;

		function getViewInterface() : Class;

		function viewBeforeAddedToStage() : void;

		function viewBeforeRemovedFromStage() : void;

		function destroy() : void;
	}
}
