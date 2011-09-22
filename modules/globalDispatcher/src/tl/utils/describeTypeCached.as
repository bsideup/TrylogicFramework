package tl.utils
{
	import flash.utils.describeType;

	public function describeTypeCached(type : *) : XML
	{
		var cachedType : XML = DescribeTypeCache.cache[type];
		if (!cachedType) cachedType = describeType(type);
		return cachedType;
	}
}

import flash.utils.Dictionary;

class DescribeTypeCache
{
	public static var cache : Dictionary = new Dictionary(true);
}
