package  
{
	import CharacterStates.IdleState;
	import com.adobe.air.crypto.EncryptionKeyGenerator;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Bullet extends Character 
	{
		var mAnimLoader:AnimationLoader;
		var LifeTime:Number;
		var TimeSinceCreation:Number;
		var Owner:int;
		protected var VelDir:Point;
		
		public function Bullet(game:PlayState, _x:Number, _y:Number,dir:Point) 
		{
			super(game, _x, _y);
			mHeading = dir;
			TimeSinceCreation = 0.0;
			LifeTime = 5.0;
			Owner = 0;
			active = true;
			VelDir = dir;
			Init();
			InitAnimations();
		}
		
		override public function Init():void 
		{
			mState = new IdleState(0, this);
			scale.x = 5;
			scale.y = 5;
		}
		
		override public function InitAnimations():void 
		{
			mAnimLoader = new AnimationLoader(mGame);
			mAnimLoader.loadBankFromFile("../media/player/bullet/bullet_anims.txt");
			mAnimLoader.addEventListener(Event.COMPLETE, completeLoad);
		}
		
		private function completeLoad(e:Event):void
		{
			mAnimations = mAnimLoader.getAnimationBank();
			mAnimations.registerAnimationsToSprite(this);
			ChangeAnimation("fire");
		}
		
		override public function update():void 
		{
			if (!isReadyToDisplay())
				return;
				
			UpdateHitbox();
			updateLookAt();
			if (active)
			{
				updateLifeTime();
				updatePosition();
				if (isTimeToDie())
				{
					active = false;
				}
			}
		}
		
		override public function draw():void 
		{
			if(isReadyToDisplay())
				super.draw();
		}
		
		public virtual function updatePosition():void
		{
			Move(mHeading, Speed());
		}
		
		public virtual function updateLifeTime():void
		{
			TimeSinceCreation += FlxG.elapsed;
		}
		
		public virtual function isTimeToDie():Boolean
		{
			return finished;
		}
	}

}