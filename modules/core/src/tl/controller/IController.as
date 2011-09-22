package tl.controller
{
	import mx.core.IMXMLObject;

	import tl.actions.Action;

	public interface IController
	{
		function activate() : void;

		function deactivate() : void;

		function dispose() : void;
	}
}
