package tl.view
{
	import flash.utils.*;

	import tl.ioc.IoCHelper;

	/**
	 * MXML wrapper for embedded objects
	 *
	 * <listing  version="3.0">
	 *	 &lt;addedToStage&gt;
	 *		 trace(embeddedInstance.getChildAt(0));
	 *		 trace(embeddedInstance.someInstanceID);
	 *	 &lt;/addedToStage&gt;
	 *
	 *	 &lt;tl:Embed id="embeddedInstance" source="@Embed(source='myView.swf', symbol='MySymbol')" /&gt;
	 * </listing>
	 *
	 */
	public dynamic class Embed extends Proxy
	{
		/**
		 * Instance from class, specified in source property
		 *
		 */
		protected var _instance : Object;

		internal function get instance() : Object
		{
			return _instance;
		}

		public function set source( value : Class ) : void
		{
			if ( value == null ) return;

			if ( _instance != null )
			{
				throw new ArgumentError( "You can't set source twice!" );
			}

			this._instance = IoCHelper.makeInstance( value );
		}

		override flash_proxy function getProperty( name : * ) : *
		{
			if ( name == "instance" ) return _instance;
			return instance[name];
		}

		override flash_proxy function setProperty( name : *, value : * ) : void
		{
			instance[name] = value;
		}

		override flash_proxy function callProperty( name : *, ... rest ) : *
		{
			return instance[name].apply( instance, rest );
		}

		override flash_proxy function hasProperty( name : * ) : Boolean
		{
			return instance.hasOwnProperty( name );
		}

		override flash_proxy function deleteProperty( name : * ) : Boolean
		{
			if ( instance.hasOwnProperty( name ) )
			{
				delete instance[name];
				return true;
			} else
			{
				return false;
			}
		}
	}
}
