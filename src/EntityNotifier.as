package  
{
	import org.flixel.system.FlxList;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EntityNotifier 
	{
		var mListeners:Vector.<NotifyListener>;

		public function EntityNotifier() 
		{
			mListeners = new Vector.<NotifyListener>();
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
			for (var i:int = 0; i < mListeners.length; i++)
			{
				mListeners[i].onNotify();
			}
		}
	}

}