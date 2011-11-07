package tl.ioc
{
	/**
	 * MXML helper for IoC associating
	 */
	public class Associate
	{
		/**
		 * Interface
		 */
		public var iface : Class;

		/**
		 * associated class
		 */
		public var withClass : Class;

		/**
		 * factory for this association
		 */
		public var factory : Class;

		public function Associate( iface : Class = null, withClass : Class = null, factory : Class = null )
		{
			this.iface = iface;
			this.withClass = withClass;
			this.factory = factory;
		}
	}
}
