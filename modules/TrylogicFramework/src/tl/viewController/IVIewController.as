package tl.viewController
{
	import flash.display.DisplayObject;

	import tl.view.IView;

	public interface IVIewController
	{
		function get viewIsLoaded() : Boolean;

		function get view() : IView;

		function getViewInterface() : Class;

		function viewBeforeAddedToStage() : void;

		function viewBeforeRemovedFromStage() : void;

		function destroy() : void;
	}
}
