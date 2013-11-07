package  RoomAssets
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WallSwitch extends Character
	{
		
		protected var mIsOpen:Boolean;
		//protected var mNotifier:WallNotifier;
		protected var mCoolDown:Number;
		protected var mLastSwitch:Number;
		
		public function WallSwitch(game:PlayState, _x:Number, _y:Number) 
		{
			super(game,_x, _y);
			Init();
			immovable = true;
			solid = true;
		}
		
		override public function Init():void 
		{
			super.Init();
			mAABBHeightOffset = 0;
			mAABBWidthOffset = 0;
			mAABBOffset = new Point(0, 0);
			mCoolDown = new Number(0.5);
			mLastSwitch = mCoolDown;
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			loadGraphic(GameResources.WallSwitch, true, false, 32, 32, false);
			addAnimation("open", [0],0,false);
			addAnimation("closed", [1], 0, false);
			play("open");
		}
		
		override public function update():void 
		{
			super.update();
			
			mLastSwitch += FlxG.elapsed;
		}
		
		public function setOpenAnimation(status:Boolean):void {
			if (status)
				play("open");
			else
				play("closed");
		}
		
		public function addNotifier(notifier:WallNotifier):void {
			mNotifier = notifier;
		}
		
		public function toggleOpen():Boolean 
		{
			if (!mNotifier.isReady())
				return mIsOpen;
				
			setOpen(!mIsOpen);
			mNotifier.notify();
			mGame.ActiveLevel().setGlobalSwitchState(mIsOpen);
			
			return mIsOpen;
		}
		public function setOpen(status:Boolean) {
			
			mIsOpen = status;
			setOpenAnimation(mIsOpen);
		}
		
		public function isOpen():Boolean {
			return mIsOpen;
		}
		
		public function onHit(obj:GameObject) {
			/*var len:Number = distanceBetween(obj);
			if (len < this.width + obj.width)
			{
				toggleOpen();
			}*/
			if (obj.overlaps(this))
				toggleOpen();
		}
		
	}

}