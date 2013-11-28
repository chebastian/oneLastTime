package RoomAssets 
{
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class SwitchBeam extends Character 
	{
		protected var mFirstObservedY:Number;
		protected var mAreInline:Boolean;
		protected var mWasInline:Boolean;
		protected var mBeamLength:Number;
		
		public function SwitchBeam(game:PlayState, _x:Number, _y:Number) 
		{
			super(game, _x, _y);
			
			mHeading = new Point(0, 0);
			active = true;
			height = 8;
			width = 8;
			mAABBOffset = new Point(0, 0);
			mAABBWidthOffset = 0;
			mAABBHeightOffset = 0;
			mBulletOriginOffset = new Point(0, 0);
			srcWH = new Point(0, 0);
			mIsAttacking = true;
			mFirstObservedY = 0.0;
			mAreInline = false;
			mWasInline = false;
			Init();
		}
		
		override public function Init():void 
		{
			super.Init();
			
			
			ChangeState(new CharacterState(0, this));
			mIsAttacking = true;
			//mWeaponHitbox = new GameObject(x, y, null);
			mHitBox = new GameObject(x, y, null);
			mHitBox.width = 8;
			mHitBox.height = 8;
			//mHitBoxPosOffset = new Point(0, 0);
			//mHitBoxSizeOffset = new Point(0, 0);
			mAABBWidthOffset = -1;
			mAABBHeightOffset = -1;
			mAABBOffset = new Point(1, 1);
			
			mAnimationsPath = "../media/beam/animations.txt";
			srcWH = new Point(8, 8);
			width = 8;
			height = 8;
			mCurrentWeapon = new Weapon(mGame, 0.5, 10, 3.0);
			mCurrentWeapon.setBulletStr("../media/beam/animations.txt");
			mCurrentWeapon.setBulletPrototype(new SwitchBeamBullet(mGame, x, y, Heading()));
			mHeading = new Point(1, 0);
			mBeamLength = 24;
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("beamLeft");
		}
		
		override public function draw():void 
		{
			if (!isReadyToDisplay())
				return;
				
			super.draw();
		}
		
		override public function update():void 
		{
			super.update();
			if (mCurrentWeapon.canFire())
			{
				var beam:SwitchBeamBullet = new SwitchBeamBullet(mGame, x, y, Heading());
				beam.Init();
				beam.setMaxDist(mBeamLength);
				beam.SetSpeed(10);
				beam.InitAnimations();
				mGame.getBulletMgr().addBullet(beam);
			}
			
			if (playerPassedBeam())
			{
				mGame.ActiveLevel().ActiveRoom().testSwitch();
			}
		}
		
		protected function isInSight(char:Character):Boolean
		{
			var dist = distanceBetween(char);
			var xd:Number = x - char.x;
			if (canSeeCharacter(char))
			{
				return Math.abs(xd) < mBeamLength;
			}
			return false;
		}
		
		protected function playerPassedBeam():Boolean
		{
			var wasInline:Boolean = new Boolean(mAreInline.valueOf());
			var char:Character = mGame.ActivePlayer();
			
			if ( isInSight(char) )
			{
				mAreInline = true;
				if (!wasInline)
				{
					mFirstObservedY = char.Heading().y;
				}
			}
			else
			{
				mAreInline = false;
				if (wasInline)
				{
					var curY:Number = char.Heading().y;
					
					if (curY == mFirstObservedY)
						return true;
				}
			}
			
			return false;
		}
	}

}