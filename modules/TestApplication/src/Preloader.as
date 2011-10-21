package
{
	import mx.core.IFlexModuleFactory;

	import tl.bootloader.PreloaderBase;
	import tl.bootloader.mixins.LibraryLoader;

	public class Preloader extends PreloaderBase
	{
		public function Preloader( app : IFlexModuleFactory )
		{
			super( app );

			new LibraryLoader();

		}
	}
}
