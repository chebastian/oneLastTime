package  
{
	import CharacterStates.AttackState;
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author ...
	 */
	
	 import org.flixel.FlxG;
	 
	public class PlayerCharacter extends Character
	{
		public function PlayerCharacter(game:PlayState,pos:Point) 
		{
			super(game, pos.x, pos.y);
			this.scale = new FlxPoint (2, 2);
		}
		
		override public function Init():void 
		{
			super.Init();
			mStrength = 50.0;
		}
		
		override public function InitAnimations():void 
		{
			super.InitAnimations();
			//addAnimation("attack",[8,8], 2,true);
		}
		
		override public function update():void 
		{
			super.update();
				
			HandleInput();
		}
		
		public function HandleInput():void
		{
			var speed:Number = WALK_SPEED;
			
			if (FlxG.keys.justPressed("A") && !IsInState(CharacterState.ATTACK_STATE))
				ChangeState(new AttackState(this));
				
			if (IsInState(CharacterState.ATTACK_STATE) || IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.pressed("LEFT"))
			{
				Move(new Point( -1, 0), speed);
				ChangeAnimation(this.Animation_WalkLeft, GameResources.Anim_LinkWalkLeft);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				Move(new Point( 1, 0), speed);
				ChangeAnimation(this.Animation_WalkRight, GameResources.Anim_LinkWalkRight);
			}
			else if (FlxG.keys.pressed("UP"))
			{
				Move(new Point( 0, -1), speed);
				ChangeAnimation(this.Animation_WalkUp, GameResources.Anim_LinkWalkUp);
			}
			else if (FlxG.keys.pressed("DOWN"))
			{
				Move(new Point( 0, 1), speed);
				ChangeAnimation(this.Animation_WalkDown, GameResources.Anim_LinkWalkDown);
			}
			else
			{
				ChangeAnimation(this.Animation_Idle);
				StopMoving();
			}
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			return super.OnHitCharacter(char);
		}
		
		public function HasKeys():Boolean
		 {
			 return mGame.Keys > 0;
		 }
		 
		 public function UseKey():void
		 {
			 mGame.Keys--;
		 }
		
	}

}