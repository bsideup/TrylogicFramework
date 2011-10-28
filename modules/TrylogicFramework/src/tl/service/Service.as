package tl.service
{
	import mx.core.IMXMLObject;

	import tl.ioc.IoCHelper;

	public class Service implements IMXMLObject
	{
		public var type : Class;

		private var service : IService;
		
		public function Service()
		{
		}

		public function initialized( document : Object, id : String ) : void
		{
			service = IoCHelper.resolve(type);
		}
	}
}
