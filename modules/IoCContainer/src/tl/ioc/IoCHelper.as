package tl.ioc
{
	import flash.utils.*;

	import tl.ioc.mxml.Associate;
	import tl.ioc.mxml.GroupAssociate;
	import tl.ioc.mxml.IAssociate;
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
	 *			public function MyInjectedClass()
	 *			{
	 *				IoCHelper.injectTo(this);
	 *			}
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
	 *				IoCHelper.registerType(ILogger, MyLogger, SingletonFactory);
	 *				var injectedObject : MyInjectedClass = new MyInjectedClass();
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
			var assoc : Associate = aliases[iface];
			var resolvedInstance : *;

			if ( assoc == null )
			{
				throw new Error( "Nothing is registered to " + iface );
			}

			try
			{
				resolvedInstance = assoc.withClass.ioc_internal::['getInstanceForInstance']( instance );
			}
			catch ( e : ReferenceError )
			{
				try
				{
					resolvedInstance = assoc.withClass.ioc_internal::['getInstance']();
				}
				catch ( e : ReferenceError )
				{
					if ( assoc.factory != null )
					{
						resolvedInstance = Class( assoc.factory ).makeInstance( assoc.withClass, instance );
					}
					else
					{
						resolvedInstance = new assoc.withClass();
					}
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

				describeType( resolvedInstance ).accessor.(@access != "readonly").(valueOf().metadata.(@name == "Injection").length()).(
						resolvedInstance[String( @name )] = resolve( getDefinitionByName( @type ), resolvedInstance )
						);
			}
		}

		/**
		 * Associate iface with targetClass
		 *
		 * @param iface
		 * @param targetClass
		 */
		public static function registerType( iface : Class, targetClass : Class, factory : Class = null ) : void
		{
			registerAssociate( new Associate( iface, targetClass, factory ) );
		}

		public static function registerAssociate( assoc : IAssociate ) : void
		{
			if ( assoc is GroupAssociate )
			{
				for each( var inAssoc : IAssociate in GroupAssociate( assoc ).data )
				{
					registerAssociate( inAssoc );
				}
			}
			else if ( assoc is Associate )
			{
				if ( Associate( assoc ).iface == null )
				{
					throw new Error( "Association's iface property cann't be null!" );
				}

				aliases[Associate( assoc ).iface] = assoc;
			}
		}
	}
}
