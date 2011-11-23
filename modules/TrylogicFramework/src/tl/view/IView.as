package tl.view
{
	import flash.events.IEventDispatcher;

	import tl.viewController.IVIewController;

	/**
	 * Main interface for any View
	 *
	 */
	public interface IView extends IEventDispatcher
	{
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

		function initWithController( controller : IVIewController ) : void;

		/**
		 * Destroy this IView instance for future GC. After destroy this instance will not be used.
		 *
		 */
		function destroy() : void;
	}
}
