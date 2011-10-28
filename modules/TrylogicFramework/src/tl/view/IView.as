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

		/**
		 * Destroy this IView instance for future GC. After destroy this instance will not be used.
		 *
		 */
		function destroy() : void;
	}
}
