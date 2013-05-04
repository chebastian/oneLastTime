package  
{
	import CharacterStates.AttackState;
	import flash.geom.Point;
	import PlayerCharacter;
	import org.flixel.*;
	import com.adobe.serialization.json;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PirateCharacter extends PlayerCharacter 
	{
		var mWeaponReach:Number;
		
		public function PirateCharacter(game:PlayState, pos:Point) 
		{
			super(game, pos);
			srcWH = new Point(16, 16);
			mAABBOffset = new Point(0, 6);
			mAABBHeightOffset = 3;
			mWeaponReach = 5;
			mWeaponHitbox = new GameObject(this.x, this.y, null);
			mWeaponHitbox.width = 3;
			mWeaponHitbox.height = 3;
			
		}
		
		override public function InitAnimations():void 
		{
			loadGraphic(GameResources.Player_Sheet, true, true, 16, 16, false);
			mCurrentAnimation = "";
			srcWH = new Point(16, 16);
			
			this.addAnimationClip(Animation_Idle, [8], mAnimationFrameRate, srcWH.x, srcWH.y, true, GameResources.Player_Sheet);
			this.addAnimationClip(Animation_WalkRight, [0, 1, 2, 3], mAnimationFrameRate, srcWH.x, srcWH.y, true, GameResources.Player_Sheet);
			this.addAnimationClip(Animation_WalkLeft, [4, 5, 6, 7], mAnimationFrameRate, srcWH.x, srcWH.y, true, GameResources.Player_Sheet);
			this.addAnimationClip(Animation_WalkDown, [8, 9, 10], mAnimationFrameRate, srcWH.x, srcWH.y, true, GameResources.Player_Sheet);
			this.addAnimationClip(Animation_WalkUp, [11, 12, 13], mAnimationFrameRate, srcWH.x, srcWH.y, true, GameResources.Player_Sheet);
			this.addAnimationClip(Animation_Attack_R, [0, 1, 0], mAnimationFrameRate, 24, srcWH.y, true, GameResources.Player_Attack);
			
			var attackLeft:AnimationClip = new AnimationClip(Animation_Attack_L, [2, 3, 2], 24, srcWH.y, GameResources.Player_Attack);
			attackLeft.fps = mAnimationFrameRate;
			attackLeft.origin.x = -8;
			attackLeft.origin.y = 0;
			this.addClip(attackLeft);
			
			ChangeAnimation(Animation_Idle);
			
		}
		
		override public function update():void 
		{
			super.update();
			this.mWeaponHitbox.x = this.x + (mHeading.x * this.mWeaponReach);
			this.mWeaponHitbox.y = this.y + (mHeading.y * this.mWeaponReach);
		}
		
		override public function draw():void 
		{
			super.draw();
			this.mWeaponHitbox.draw();
		}
		override public function HandleInput():void 
		{
			var speed:Number = 100.0;
		
				
			if (IsInState(CharacterState.ATTACK_STATE) || IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.justPressed("A")) 
			{
				ChangeState(new AttackState(this));
			}
				
			else if (FlxG.keys.pressed("LEFT"))
			{
				Move(new Point( -1, 0), speed);
				ChangeAnimation(Character.Animation_WalkLeft, GameResources.Player_Sheet);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				Move(new Point( 1, 0), speed);
				ChangeAnimation(Character.Animation_WalkRight, GameResources.Player_Sheet);
				this.facing = RIGHT;
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