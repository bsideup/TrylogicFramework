package tl.utils
{
	import flash.utils.describeType;

	/**
	 * Describe type cached. Didnt't safe reference to passed object.
	 *
	 * @see	flash.utils.describeType
	 *
	 * @param type	Object or Class
	 * @return	Same as <code>flash.utils.describeType</code> return value
	 */
	public function describeTypeCached( type : * ) : XML
	{
		var cachedType : XML;
		if ( type is Class )
		{
			cachedType = classCache[type];
			if ( cachedType == null )
			{
				cachedType = classCache[type] = describeType( type );
			}
		} else
		{
			cachedType = objectCache[type.constructor];
			if ( cachedType == null )
			{
				cachedType = objectCache[type.constructor] = describeType( type );
			}
		}

		return cachedType;
	}
}

import flash.utils.Dictionary;

const classCache : Dictionary = new Dictionary();
const objectCache : Dictionary = new Dictionary();