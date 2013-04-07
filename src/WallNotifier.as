package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WallNotifier extends NotifyListener 
	{
		
		protected var mWall:RaisableWall;
		public function WallNotifier(wall:RaisableWall) 
		{
			super(mUniqueId);
			mWall = wall;
		}
		
		override public function onNotify():void 
		{
			mWall.toggleOpenClosed();
			super.onNotify();
		}
		
	}

}