package tl.utils
{
	import flash.display.*;

	public function getChildByNameRecursiveOnTarget( name : String, target : DisplayObjectContainer ) : DisplayObject
	{
		if ( target == null )
		{
			return null;
		}

		var displayObject : DisplayObject;
		var child : DisplayObject;

		for ( var i : uint = 0, lenght : uint = target.numChildren; i < lenght || displayObject == null; i++ )
		{
			child = target.getChildAt( i );
			if ( child.name == name )
			{
				displayObject = child;
			} else if ( child is DisplayObjectContainer )
			{
				displayObject = getChildByNameRecursiveOnTarget( name, child as DisplayObjectContainer );
			}
		}

		return displayObject;
	}
}
