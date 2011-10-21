package tl.ioc
{
	import flash.utils.*;

	/**
	 * Basic IoC container.
	 *
	 * @example
	 * <listing version="3.0">
	 *     public interface ILogger
	 *     {
	 *     		function log(...args) : void;
	 *     }</listing>
	 *
	 * <listing version="3.0">
	 *     public class MyLogger implements ILogger
	 *     {
	 *     		private static var _instance : MyLogger;
	 *     		
	 *     		ioc_internal static fuction getInstance() : MyLogger
	 *     		{
	 *     			if(_instance == null)
	 *     			{
	 *     				_instance = new MyLogger();
	 *     			}
	 *     			return _instance;
	 *     		}
	 *     		
	 *     		public fuction log(...args) : void
	 *     		{
	 *     			trace(args);
	 *     		}
	 *     }</listing>
	 *
	 * <listing version="3.0">
	 *     public class MyInjectedClass
	 *     {
	 *			[Injection]
	 *			public var logger : ILogger;
	 *
	 *			public function doSomething() : void
	 *			{
	 *				logger.log("something");
	 *			}
	 *		}</listing>
	 *
	 * <listing version="3.0">
	 *     public class MyClass
	 *     {
	 *			public fuction MyClass()
	 *			{
	 *				IoCHelper.registerType(ILogger, MyLogger);
	 *				var injectedObject : MyInjectedClass = IoCHelper.makeInstance(MyInjectedClass);
	 *				injectedObject.doSomething(); // Will trace "something"
	 *			}
	 *		}</listing>
	 */
	public class IoCHelper
	{
		private static const aliases : Dictionary = new Dictionary();

		/**
		 * Return instance for passed iface.
		 *
		 * @see makeInstance
		 *
		 * @param iface		Interface of returned instance
		 * @param instance	Optional instance, passed to <code>getInstanceForInstance</code> function of implementation Class
		 * @return			iface implementator
		 */
		public static function resolve( iface : Class, instance : * = null ) : *
		{
			var clazz : Class = aliases[iface];
			if ( clazz == null )
			{
				throw new Error( "Nothing is registered to " + iface );
			}

			return makeInstance( clazz, instance );
		}


		/**
		 * Instantiate class of instanceClass and setup injections
		 *
		 * @param instanceClass	Return Class type
		 * @param forInstance	Optional instance, passed to <code>getInstanceForInstance</code> function of implementation Class
		 * @return				instance of instanceClass
		 */
		public static function makeInstance( instanceClass : Class, forInstance : * = null ) : *
		{
			var resolvedInstance : *;

			try
			{
				resolvedInstance = instanceClass.ioc_internal::['getInstanceForInstance']( forInstance );
			}
			catch( e : ReferenceError )
			{
				try
				{
					resolvedInstance = instanceClass.ioc_internal::['getInstance']();
				}
				catch( e : ReferenceError )
				{
					resolvedInstance = new instanceClass();
				}
			}

			if ( resolvedInstance != forInstance )
			{
				var desc : XML = describeType( resolvedInstance );

				desc.variable.(metadata.(@name == "Injection").length()).(
						resolvedInstance[String( @name )] = resolve( getDefinitionByName( @type ), resolvedInstance )
						);
			}

			return resolvedInstance;
		}

		/**
		 * Associate iface with targetClass
		 *
		 * @param iface
		 * @param targetClass
		 */
		public static function registerType( iface : Class, targetClass : Class ) : void
		{
			if ( !((new targetClass()) is iface) )
			{
				throw new ArgumentError( targetClass + " must implements " + iface );
			}
			aliases[iface] = targetClass;
		}
	}
}
