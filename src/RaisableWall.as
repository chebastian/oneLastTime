package  
{
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class RaisableWall extends GameObject 
	{
		protected var mIsOpen:Boolean;
		
		public function RaisableWall(_x:Number, _y:Number) 
		{
			super(_x, _y, null);
			loadGraphic(GameResources.RaisableWall, true, false, 32, 32, false);
			Init();
			mIsOpen = true;
			mNotfier = new WallNotifier(this);
		}
		
		override public function Init():void 
		{
			addAnimation("open", [0], 0, false);
			addAnimation("closed", [1], 0, false);
			play("open", true);
		}
		
		
		public function setOpen(isOpen:Boolean):void
		{
			mIsOpen = isOpen;
			changeAnimationState(mIsOpen);
		}
		
		protected function changeAnimationState(open:Boolean):void
		{
			if (open)
				play("open", true);
			else
				play("closed", true);
		}
		
		public function toggleOpenClosed():Boolean
		{
			mIsOpen = !mIsOpen;
			changeAnimationState(mIsOpen);
			
			return mIsOpen;
		}
		
	}

}