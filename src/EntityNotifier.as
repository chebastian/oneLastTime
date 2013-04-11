package  
{
	import org.flixel.system.FlxList;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EntityNotifier 
	{
		var mListeners:Vector.<NotifyListener>;
		var mLastTime:uint;
		var mTimeBetweenNotifications:uint;

		public function EntityNotifier() 
		{
			mListeners = new Vector.<NotifyListener>();
			mTimeBetweenNotifications = 0;
			mLastTime = 0;
		}
			
		public function addListener(listener:NotifyListener) 
		{
			mListeners.push(listener);
		}
		
		public function removeListener(listener:NotifyListener) 
		{
			for (var i:int = 0; i < mListeners.length; i++)
			{
				if (mListeners[i].getId() == listener.getId()) {
					delete mListeners[i];
					return;
				}
			}
		}
		
		public function notify()
		{
			var now:uint = FlxU.getTicks();
			
			var timeSinceLast = now - mLastTime;
			
			if (timeSinceLast >= mTimeBetweenNotifications)
			{
				for (var i:int = 0; i < mListeners.length; i++)
				{	
					mListeners[i].onNotify();
				}
				
				mLastTime = FlxU.getTicks();
			}
		}
		
		public function setNotificationCooldown(milliseconds:uint):void {
			mTimeBetweenNotifications = milliseconds;
		}
	}

}