package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WallSwitch extends GameObject
	{
		
		protected var mIsOpen:Boolean;
		protected var mNotifier:EntityNotifier;
		
		public function WallSwitch(_x:Number, _y:Number) 
		{
			super(_x, _y, null);
			loadGraphic(GameResources.WallSwitch, true, false, 32, 32, false);
			Init();
			
			mNotifier = new EntityNotifier();
		}
		
		override public function Init():void 
		{
			super.Init();
			addAnimation("open", [0],0,false);
			addAnimation("closed", [1], 0, false);
			play("open");
		}
		
		public function addListener(listener:NotifyListener) {
			mNotifier.addListener(listener);
		}
		
		
		public function setOpen(status:Boolean) {
			mIsOpen = status;
			mNotifier.notify();
		}
		
		public function isOpen():Boolean {
			return mIsOpen;
		}
		
		
	}

}