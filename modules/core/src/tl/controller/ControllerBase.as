package tl.controller
{
	import flash.display.*;

	import tl.actions.ActionDispatcher;
	import tl.utils.*;

	public class ControllerBase implements IController
	{
		public function activate() : void
		{
			ActionDispatcher.addHandler(this);
		}

		public function deactivate() : void
		{
			ActionDispatcher.removeHandler(this);
		}

		public function dispose() : void
		{
			deactivate();
		}
	}

}
