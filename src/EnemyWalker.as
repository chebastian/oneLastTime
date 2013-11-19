package  
{
	import AttackReactions.DamageReaction;
	import CharacterStates.DamagedState;
	import CharacterStates.IdleState;
	import CharacterStates.WalkerChargeState;
	import CharacterStates.WanderState;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyWalker extends Enemy 
	{
		
		public function EnemyWalker(game:PlayState, pos:Point) 
		{
			super(game, pos);
			mAnimationsPath = "../media/enemy/awlker/animations.txt";
			srcWH = new Point(8, 9);
			InitAnimations();
			SetSpeed(10);
		}
		
		override public function Init():void 
		{
			super.Init();
			mReactions.setReaction(new DamageReaction(this, 50));
			ChangeState(new WanderState(this));
			mHitBoxSizeOffset.x = -4;
			mHitBoxSizeOffset.y = -4;
			mHitBoxPosOffset.x = 2;
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			Animation_WalkDown = "";
			Animation_WalkUp = "";
			Animation_WalkLeft = "walkLeft";
			Animation_WalkRight = "walkRight";
			Animation_Attack_L = "attackL";
			Animation_Attack_R = "attackR";
		}
		
		override public function update():void 
		{
			super.update();
			//updateWalkingAnimation();
			lookForPlayer();
		}
		
		override protected function updateLookAt():void 
		{
			if (mHeading.x > 0 || mHeading.x < 0)
			{
				mLookAt.x = mHeading.x;
				mLookAt.normalize(1.0);
			}
		}
		
		public function lookForPlayer():void
		 {
			if(canSeeCharacter(mGame.ActivePlayer()))
			{
				var d:Number = distanceBetween(mGame.ActivePlayer());
				var minD:Number = 64;
				trace(d);
				if(!IsInState(WalkerChargeState.WALKER_STATEID) && d < minD && canSeeCharacter(mGame.ActivePlayer()))
					ChangeState(new WalkerChargeState(this));
			}
		 }
		 
		 public function canSeeCharacter(char:Character):Boolean {
			 var mid:FlxPoint = getMidpoint();
			 var charMid:FlxPoint = char.getMidpoint();
			 var topDist:Number = y - char.y;
			 var bottomDist:Number = (y + height) - (char.y + char.height);
			 
			 if (Math.abs((mid.y - charMid.y)) < 2)
				return areFacingEachother(char);
			 
			 return false;
		 }
		
		override public function draw():void 
		{
			super.draw();
			//drawDebug();
			//mHitBox.drawDebug();
		}
		public function updateWalkingAnimation():void
		{
			if (mHeading.x < 0)
				ChangeAnimation("walkLeft");
			else 
				ChangeAnimation("walkRight");
				
		}
		
		override public function onAnimationLoadComplete(e:Event):void 
		{
			super.onAnimationLoadComplete(e);
			ChangeAnimation("walkLeft");
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			if (!alive || !char.alive)
				return false;
				
			if (char.Attacking() && mHitBox.overlaps(char))
			{
				ChangeState(new DamagedState(this));
				char.OnHitCharacter(this);
				mReactions.getReaction().onAttacked();
				 FlxG.play(mGame.getResources().getSound("bullet_hit_enemy"),1.0);
				return true;
			}
			
			return false;
		}
		
	}

}