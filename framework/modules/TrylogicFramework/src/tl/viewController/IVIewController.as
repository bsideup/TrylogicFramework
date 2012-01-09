package tl.viewController
{
	import flash.display.DisplayObjectContainer;

	import tl.view.IView;

	public interface IVIewController
	{
		function addViewToContainer( container : DisplayObjectContainer ) : void;

		function addViewToContainerAtIndex( container : DisplayObjectContainer, index : int ) : void;

		function setViewIndexInContainer( container : DisplayObjectContainer, index : int ) : void;

		function removeViewFromContainer( container : DisplayObjectContainer ) : void;

		function get parentViewController() : IVIewController;

		function set parentViewController( value : IVIewController ) : void;

		function destroy() : void;

		function initWithView( newView : IView ) : void;
	}
}
