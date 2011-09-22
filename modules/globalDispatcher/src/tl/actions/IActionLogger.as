/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 22.09.11
 * Time: 23:39
 * To change this template use File | Settings | File Templates.
 */
package tl.actions
{
	public interface IActionLogger
	{
		function log(text : String, level : uint = 0) : void;
	}
}
