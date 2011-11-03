package tl.viewController
{
	import tl.view.IView;

	public interface IVIewController
	{
		function get viewIsLoaded() : Boolean;

		function get view() : IView;

		function get parentViewController() : IVIewController;

		function set parentViewController( value : IVIewController ) : void;

		function getViewInterface() : Class;

		function viewBeforeAddedToStage() : void;

		function viewBeforeRemovedFromStage() : void;

		function destroy() : void;
	}
}
