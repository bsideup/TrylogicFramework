package tl.view
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;

	import tl.viewController.IVIewController;

	public interface IView extends IEventDispatcher
	{
		function set controller( value : IVIewController ) : void;

		function dispose() : void;


		function addChild( child : DisplayObject ) : DisplayObject;

		function addChildAt( child : DisplayObject, index : int ) : DisplayObject;

		function removeChild( child : DisplayObject ) : DisplayObject;

		function removeChildAt( index : int ) : DisplayObject;

		function getChildIndex( child : DisplayObject ) : int;

		function setChildIndex( child : DisplayObject, index : int ) : void;

		function getChildAt( index : int ) : DisplayObject;

		function getChildByName( name : String ) : DisplayObject;

		function get numChildren() : int;

		function getObjectsUnderPoint( point : Point ) : Array;

		function areInaccessibleObjectsUnderPoint( point : Point ) : Boolean;

		function contains( child : DisplayObject ) : Boolean;

		function swapChildrenAt( index1 : int, index2 : int ) : void;

		function swapChildren( child1 : DisplayObject, child2 : DisplayObject ) : void;
	}
}
