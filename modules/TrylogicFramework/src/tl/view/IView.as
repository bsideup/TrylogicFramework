package tl.view
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;

	import tl.viewController.IVIewController;

	/**
	 * Main interface for any View
	 *
	 */
	public interface IView extends IEventDispatcher
	{
		function set controller( value : IVIewController ) : void;

		/**
		 * IVIewController instance. Can be null.
		 *
		 */
		function get controller() : IVIewController;

		/**
		 * IView childs
		 *
		 */
		function get data() : Array;

		function set data( value : Array ) : void;

		function get parent() : DisplayObjectContainer;

		/**
		 * Destroy this IView instance for future GC. After destroy this instance will not be used.
		 *
		 */
		function destroy() : void;

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
