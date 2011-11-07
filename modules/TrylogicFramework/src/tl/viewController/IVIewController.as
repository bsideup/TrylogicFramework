package tl.viewController
{
	import flash.display.DisplayObjectContainer;

	public interface IVIewController
	{
		//function get viewIsLoaded() : Boolean;

		//function get view() : IView;

		function addViewToContainer( container : DisplayObjectContainer ) : void;

		function addViewToContainerAtIndex( container : DisplayObjectContainer, index : int ) : void;

		function setViewIndexInContainer( container : DisplayObjectContainer, index : int ) : void;

		function removeViewFromContainer( container : DisplayObjectContainer ) : void;

		function get parentViewController() : IVIewController;

		function set parentViewController( value : IVIewController ) : void;

		function getViewInterface() : Class;

		//function viewBeforeAddedToStage() : void;

		//function viewBeforeRemovedFromStage() : void;

		function destroy() : void;
	}
}
