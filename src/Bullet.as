package  
{
	import CharacterStates.BulletExplodeState;
	import CharacterStates.BulletTravelState;
	import org.flixel.FlxCamera;
	import adobe.utils.CustomActions;
	import CharacterStates.IdleState;
	import com.adobe.air.crypto.EncryptionKeyGenerator;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxBasic;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Bullet extends Character 
	{
		var mAnimLoader:AnimationLoader;
		public var LifeTime:Number;
		var TimeSinceCreation:Number;
		public var Owner:int;
		protected var VelDir:Point;
		protected var Killed:Boolean;
		protected var mFireSound:String;
		
		public function Bullet(game:PlayState, _x:Number, _y:Number,dir:Point) 
		{
			super(game, _x, _y);
			mHeading = dir;
			TimeSinceCreation = 0.0;
			LifeTime = 5.0;
			Owner = 0;
			Killed = false;
			active = true;
			VelDir = new Point(dir.x, dir.y);
			VelDir.normalize(1.0);
			Init();
			height = 5;
			width = 5;
			mAABBOffset = new Point(0, 0);
			mAABBWidthOffset = 0;
			mAABBHeightOffset = 0;
			mBulletOriginOffset = new Point(0, 0);
			srcWH = new Point(0, 0);
			mIsAttacking = true;
			mAnimationsPath = "../media/player/bullet/bullet_anims.txt";
		}
		
		override public function Init():void 
		{
			//mState = new BulletTravelState(this);
			mFireSound = "bullet_shoot";
			ChangeState(new BulletTravelState(this));
			mIsAttacking = true;
			mWeaponHitbox = new GameObject(x, y, null);
			mHitBox = new GameObject(x, y, null);
			mHitBoxPosOffset = new Point(0, 0);
			mHitBoxSizeOffset = new Point(0, 0);
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("fire");
		}
		
		override public function update():void 
		{
			if (!isReadyToDisplay())
				return;
				
			if (active && exists)
			{
				UpdateHitbox();
				updateLookAt();

				mState.OnUpdate();
			}
		}
		
		override public function draw():void 
		{
			if(isReadyToDisplay())
				super.draw();
				
			
		}
		
		public virtual function updatePosition():void
		{
			Move(VelDir, Speed());
		}
		
		public virtual function updateLifeTime():void
		{
			TimeSinceCreation += FlxG.elapsed;
		}
		
		public virtual function isTimeToDie():Boolean
		{
			return (TimeSinceCreation >= LifeTime) || Killed;
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			super.OnHitCharacter(char);
			if (!IsInState(BulletExplodeState.STATE_ID))
			{
				ChangeState(new BulletExplodeState(this));
				return true;
			}
				
			return false;
		}
		
		public function killBullet():void
		{
			Killed = true;
		}
		
		public function setDir(dir:Point):void
		{
			mHeading = dir;
		}
		
		public function getFireSoundEffect():String
		{
			return mFireSound;
		}
	}

}