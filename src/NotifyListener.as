package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class NotifyListener 
	{
		protected var mUniqueId:int;
		
		public function NotifyListener(uniqueId:int) 
		{
			mUniqueId = uniqueId;
		}
		
		public function onNotify():void {
			
		}
		
		public function getId():int 
		{
			return mUniqueId;
		}
		
		
		
	}

}