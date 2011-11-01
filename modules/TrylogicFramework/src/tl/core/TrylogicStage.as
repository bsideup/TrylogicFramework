package tl.core
{
	import flash.display.Stage;

	import tl.bootloader.ApplicationLoader;
	import tl.ioc.ioc_internal;

	public class TrylogicStage extends Stage
	{
		private static var instance : Stage;

		ioc_internal static function getInstanceForInstance( forInstance : * ) : Stage
		{
			if ( forInstance is ApplicationLoader )
			{
				instance = ApplicationLoader( forInstance ).stage;
			}

			return instance;
		}
	}
}
