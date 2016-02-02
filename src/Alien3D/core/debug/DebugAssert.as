package Alien3D.core.debug
{
	public class DebugAssert
	{
		public function DebugAssert(message:String)
		{
			throw new Error("[Alien3D][Assert]" + message);
		}
	}
}