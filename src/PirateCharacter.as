package  
{
	import flash.geom.Point;
	import PlayerCharacter;
	import org.flixel.*;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PirateCharacter extends PlayerCharacter 
	{
		
		public function PirateCharacter(game:PlayState, pos:Point) 
		{
			super(game, pos);
			srcWH = new Point(16, 16);
			mAABBOffset = new Point(0, 6);
			mAABBHeightOffset = 3;
		}
		
		override public function InitAnimations():void 
		{
			loadGraphic(GameResources.Player_Sheet, true, false, 16, 16, false);
			addAnimation(Animation_Idle, [1], mAnimationFrameRate, true);
			addAnimation(Animation_WalkRight, [0, 1, 2, 3], mAnimationFrameRate, true);
			addAnimation(Animation_WalkLeft, [4, 5, 6, 7], mAnimationFrameRate, true);
			addAnimation(Animation_WalkDown, [8, 9, 10], mAnimationFrameRate, true);
			addAnimation(Animation_WalkUp, [11, 12, 13], mAnimationFrameRate, true);
			mCurrentAnimation = "";
			
			ChangeAnimation(Animation_Idle);
			
		}
		
		override public function HandleInput():void 
		{
			var speed:Number = 100.0;
			
			//if (FlxG.keys.justPressed("A") && !IsInState(CharacterState.ATTACK_STATE))
				//ChangeState(new AttackState(this));
				
			if (IsInState(CharacterState.ATTACK_STATE) || IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.pressed("LEFT"))
			{
				Move(new Point( -1, 0), speed);
				ChangeAnimation(Character.Animation_WalkLeft, GameResources.Player_Sheet);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				Move(new Point( 1, 0), speed);
				ChangeAnimation(Character.Animation_WalkRight, GameResources.Player_Sheet);
			}
			else if (FlxG.keys.pressed("UP"))
			{
				Move(new Point( 0, -1), speed);
				ChangeAnimation(Character.Animation_WalkUp, GameResources.Player_Sheet);
			}
			else if (FlxG.keys.pressed("DOWN"))
			{
				Move(new Point( 0, 1), speed);
				ChangeAnimation(Character.Animation_WalkDown, GameResources.Player_Sheet);
			}
			else
			{
				//ChangeAnimation(Character.Animation_Idle);
				this.play(mCurrentAnimation, true);
				StopMoving();
			}
		}
		
	}

}