package tl.viewController
{
	public interface IViewControllerContainer extends IVIewController
	{
		function get controllers() : Array;

		function set controllers( value : Array ) : void;

		function addController( value : IVIewController ) : void;

		function removeController( value : IVIewController ) : void;
	}
}
