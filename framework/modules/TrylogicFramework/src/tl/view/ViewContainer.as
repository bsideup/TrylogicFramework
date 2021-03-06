package tl.view
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class ViewContainer extends View implements IViewContainer
	{
		protected var controllerContainer : Sprite;
		
		public function get container() : DisplayObjectContainer
		{
			if(controllerContainer == null)
			{
				controllerContainer = new Sprite();
				addChildAt(controllerContainer, 0);
			}
			return controllerContainer;
		}

		override internal function internalDestroy() : void
		{
			super.internalDestroy();
			if(controllerContainer && controllerContainer.parent != null)
			{
				controllerContainer.parent.removeChild(controllerContainer);
			}
			controllerContainer = null;
		}
	}
}
