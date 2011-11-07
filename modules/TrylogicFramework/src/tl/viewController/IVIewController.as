package tl.viewController
{
	import flash.display.DisplayObjectContainer;

	public interface IVIewController
	{
		function addViewToContainer( container : DisplayObjectContainer ) : void;

		function addViewToContainerAtIndex( container : DisplayObjectContainer, index : int ) : void;

		function setViewIndexInContainer( container : DisplayObjectContainer, index : int ) : void;

		function removeViewFromContainer( container : DisplayObjectContainer ) : void;

		function get parentViewController() : IVIewController;

		function set parentViewController( value : IVIewController ) : void;

		function getViewInterface() : Class;

		function destroy() : void;
	}
}
