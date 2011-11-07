package
{
	import tl.bootloader.ApplicationLoader;
	import tl.bootloader.PreloaderBase;
	import tl.bootloader.mixins.LibraryLoader;

	public class TestApplicationPreloader extends PreloaderBase
	{
		public function TestApplicationPreloader( app : ApplicationLoader )
		{
			LibraryLoader;
			
			super( app );

		}
	}
}
