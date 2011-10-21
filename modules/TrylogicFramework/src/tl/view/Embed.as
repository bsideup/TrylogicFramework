package tl.view
{
	import flash.utils.*;

	public dynamic class Embed extends Proxy
	{
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

			this._instance = new value();
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
			}
			else
			{
				return false;
			}
		}
	}
}
