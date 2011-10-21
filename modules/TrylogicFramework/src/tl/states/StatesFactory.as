package tl.states
{
	import mx.core.IStateClient2;

	public class StatesFactory
	{
		public static function buildStateClient( target : * ) : IStateClient2
		{
			return new StateClient2Impl( target );
		}
	}
}