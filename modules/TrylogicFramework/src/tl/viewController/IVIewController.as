package tl.viewController
{
	import tl.view.IView;

	public interface IVIewController
	{
		function get viewIsLoaded() : Boolean;

		function get view() : IView;

		function getViewInterface() : Class;

		function loadView() : void;

		function viewLoaded() : void;

		function viewUnloaded() : void;

		function viewBeforeAddedToStage() : void;

		function viewBeforeRemovedFromStage() : void;

		function destroy() : void;
	}
}
