package controllers
{
	import tl.ioc.ioc_internal;

	public class Logger implements ILogger
	{
		private static const instance : Logger = new Logger();

		ioc_internal static function getInstance() : Logger
		{
			return instance;
		}

		public function log( ... args ) : void
		{
			trace( "Logger", args );
		}
	}
}
