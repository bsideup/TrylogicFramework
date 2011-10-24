package
{
	import tl.bootloader.ApplicationLoader;
	import tl.bootloader.PreloaderBase;
	import tl.bootloader.mixins.LibraryLoader;

	public class Preloader extends PreloaderBase
	{
		public function Preloader( app : ApplicationLoader )
		{
			super( app );

			new LibraryLoader();

		}
	}
}
