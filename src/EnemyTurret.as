package  
{
	import AttackReactions.DamageReaction;
	import CharacterStates.TurretIdleState;
	import CharacterStates.WanderState;
	import flash.events.Event;
	import flash.geom.Point;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyTurret extends EnemyWalker
	{
		
		protected var mFireRate:Number;
		public function EnemyTurret(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "../media/enemy/turret/animations.txt";
			srcWH = new Point(8, 8);
			SetSpeed(0);
			InitAnimations();
		}
		
		override public function Init():void 
		{
			super.Init();
			mReactions.setReaction(new DamageReaction(this, 50));
			//ChangeState(new WanderState(this));
			mFireRate = 3;
			mHitBoxSizeOffset.x = -4;
			mHitBoxSizeOffset.y = -4;
			mHitBoxPosOffset.x = 2;
			ChangeState(new TurretIdleState(this));
			mHeading.x = -1;
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			Animation_Attack_L = "rise";
			Animation_Attack_R = "rise";
			ChangeAnimation("idleDown");
		}
		
		public function changeAnimationBasedOnHeading():void
		{
			if (getLookAt().x < 0)
				mAnimations.changeCurrentBase(mGame.getResources().getResource("turretMirror"));
			else
				mAnimations.changeCurrentBase(mGame.getResources().getResource("turret"));
		}
		
		override public function update():void 
		{
			StopMoving();
			super.update();
			changeAnimationBasedOnHeading();
		}
		
		override public function lookForPlayer():void 
		{
			
		}
		
		public function getFireRate():Number
		{
			return mFireRate;
		}
		
	}

}