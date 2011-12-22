package tl.view
{
	import flash.display.Stage;
	import flash.events.IEventDispatcher;

	import mx.core.IStateClient2;

	import tl.viewController.IVIewController;

	/**
	 * Main interface for any View
	 *
	 */
	public interface IView extends IEventDispatcher, IStateClient2
	{
		function get controller() : IVIewController;

		function set controller( value : IVIewController ) : void;

		/**
		 * IView childs
		 *
		 */
		function get data() : Array;

		function set data( value : Array ) : void;

		function addElement( value : * ) : void;

		function addElementAt( value : *, index : int ) : void;

		function setElementIndex( element : *, index : int ) : void;

		function removeElement( value : * ) : void;

		/**
		 * Destroy this IView instance for future GC. After destroy this instance will not be used.
		 *
		 */
		function destroy() : void;

		function get stage() : Stage;
	}
}
