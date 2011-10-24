package tl.utils
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * Scan passed Object or Class for members with metatag
	 * @param type			Object or Class to scan
	 * @param metatag		Metatag to scan
	 * @param fromFactory	if true, will scan "factory" property of object description instead of itself
	 * @return	Array of <code>tl.utils.MemberDescription</code>
	 */
	public function getMembersInType( type : *, metatag : String, fromFactory : Boolean = false ) : Array
	{
		if ( type == null || type == "" ) return [];
		if ( metatag == null || metatag == "" ) return [];

		var cacheArray : Dictionary = type is Class ? classCache : objectCache;

		var key : * = type is Class ? type : type.constructor;

		var cachedMembersInType : Array = cacheArray[key];

		if ( cachedMembersInType == null )
		{
			cachedMembersInType = cacheArray[key] = [];

			var desc : XML = describeTypeCached( type );

			if ( fromFactory )
			{
				desc.factory.method.(valueOf().metadata.(@name == metatag).length()).(
						cachedMembersInType.push( new MemberDescription( String( @uri ), String( @name ), metadata.(@name == metatag) ) )
						);
			} else
			{
				desc.method.(valueOf().metadata.(@name == metatag).length()).(
						cachedMembersInType.push( new MemberDescription( String( @uri ), String( @name ), metadata.(@name == metatag) ) )
						);

				desc.extendsClass.(
						cachedMembersInType = cachedMembersInType.concat( getMembersInType( getDefinitionByName( String( @type ) ), metatag, true ) )
						);
			}
		}

		return cachedMembersInType;
	}
}

import flash.utils.Dictionary;

const classCache : Dictionary = new Dictionary();
const objectCache : Dictionary = new Dictionary();