package tl.utils
{
	/**
	 * Utility class for <code>tl.utils.getMembersInType</code>
	 *
	 */
	public class MemberDescription
	{
		private var _uri : String;
		private var _memberName : String;
		private var _metadata : XMLList;

		/**
		 *
		 * @param uri			Namespace URI for instance member
		 * @param methodName	Instance member name
		 * @param metadata		Metadata XMLList for instance member
		 */
		public function MemberDescription( uri : String, methodName : String, metadata : XMLList )
		{
			this._uri = uri;
			this._memberName = methodName;
			this._metadata = metadata;
		}

		/**
		 * Namespace URI for instance member
		 */
		public function get uri() : String
		{
			return _uri;
		}

		/**
		 * Instance member name
		 */
		public function get memberName() : String
		{
			return _memberName;
		}

		/**
		 * Metadata XMLList for instance member
		 */
		public function get metadata() : XMLList
		{
			return _metadata;
		}
	}
}
