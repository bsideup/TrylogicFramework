/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 19.06.11
 * Time: 15:38
 * To change this template use File | Settings | File Templates.
 */
package tl.bootloader
{
	import flash.display.IBitmapDrawable;

	public interface IPreloader extends IBitmapDrawable
	{
		function process( completeHandler : Function ) : void;
	}
}
