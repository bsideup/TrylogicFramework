package tl.ioc
{
	import flash.utils.*;

	import tl.utils.describeTypeCached;

	[Injection]
	/**
	 * Basic IoC container.
	 *
	 * @example
	 * <listing version="3.0">
	 *	 public interface ILogger
	 *	 {
	 *			 function log(...args) : void;
	 *	 }</listing>
	 *
	 * <listing version="3.0">
	 *	 public class MyLogger implements ILogger
	 *	 {
	 *			 private static var _instance : MyLogger;
	 *
	 *			 ioc_internal static fuction getInstance() : MyLogger
	 *			 {
	 *				 if(_instance == null)
	 *				 {
	 *					 _instance = new MyLogger();
	 *				 }
	 *				 return _instance;
	 *			 }
	 *
	 *			 public fuction log(...args) : void
	 *			 {
	 *				 trace(args);
	 *			 }
	 *	 }</listing>
	 *
	 * <listing version="3.0">
	 *	 public class MyInjectedClass
	 *	 {
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
	 *	 public class MyClass
	 *	 {
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
		{
			if ( describeTypeCached( IoCHelper )..metadata.(@name == "Injection").length() == 0 )
			{
				throw new Error( "Please add -keep-as3-metadata+=Injection to flex compiler arguments!" )
			}
		}

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

			var resolvedInstance : *;

			try
			{
				resolvedInstance = clazz.ioc_internal::['getInstanceForInstance']( instance );
			} catch( e : ReferenceError )
			{
				try
				{
					resolvedInstance = clazz.ioc_internal::['getInstance']();
				} catch( e : ReferenceError )
				{
					resolvedInstance = new clazz();
				}
			}

			return resolvedInstance;
		}


		/**
		 * Process injections on target
		 *
		 * @param resolvedInstance	target
		 * @param forInstance		optional and for internal use
		 */
		public static function injectTo( resolvedInstance : Object, forInstance : * = null ) : void
		{
			if ( resolvedInstance != forInstance )
			{
				describeTypeCached( resolvedInstance ).variable.(valueOf().metadata.(@name == "Injection").length()).(
						resolvedInstance[String( @name )] = resolve( getDefinitionByName( @type ), resolvedInstance )
						);

				/*
				 describeType( resolvedInstance ).accessor.(@access != "readonly").(valueOf().metadata.(@name == "Injection").length()).(
				 resolvedInstance[String( @name )] = resolve( getDefinitionByName( @type ), resolvedInstance )
				 );
				 */
			}
		}

		/**
		 * Associate iface with targetClass
		 *
		 * @param iface
		 * @param targetClass
		 */
		public static function registerType( iface : Class, targetClass : Class ) : void
		{
			aliases[iface] = targetClass;
		}
	}
}
