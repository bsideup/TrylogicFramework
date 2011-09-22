package tl.utils
{
	public function getActionsInType(type : Object) : Array
	{
		var result : Array = [];
		var desc : XML = describeTypeCached(type);
		var clazz : String = desc.@name.toString().split("::")[1];
		var className : String;
		var methodName : String;

		desc.method.(valueOf().metadata.(@name == "Action").length()).(
				result.push(
						{
							className :  (((className = metadata.(@name == "Action").arg.(@key == "className").@value.toString()) == "") ? clazz : className.toString()),
							methodName :  (((methodName = metadata.(@name == "Action").arg.(@key == "methodName").@value.toString()) == "") ? String(@name) : methodName.toString()),
							method : type[String(@name)]
						})
				);
		return result;
	}
}
