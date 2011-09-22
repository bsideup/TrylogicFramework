package tl.gui
{
	import flash.display.IBitmapDrawable;

	import mx.core.IStateClient;

	/**
	 * ISkin interface.
	 * @author aSt
	 */
	public interface ISkin extends IBitmapDrawable, IStateClient
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//{--------------------------------------------------------------------------

		function set width(value : Number) : void;

		function get width() : Number;

		function set height(value : Number) : void;

		function get height() : Number;

		function get mouseEnabled() : Boolean ;

		function set mouseEnabled(value : Boolean) : void;

		//}--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//{--------------------------------------------------------------------------

		//}--------------------------------------------------------------------------
	}
}
