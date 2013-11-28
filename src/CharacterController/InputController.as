package CharacterController 
{
	import CharacterStates.AttackState;
	import CharacterStates.CharacterWalking;
	import CharacterStates.IdleState;
	import flash.geom.Point;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class InputController extends CharacterController 
	{
		
		public function InputController(char:Character,game:PlayState) 
		{
			super(char, game);
			char.ChangeState(new CharacterWalking(mCharacter));
		}
		
		override public function update():void 
		{
			super.update();
			handleInput();
		}
		
		protected function handleInput():void
		{
			var speed:Number = mCharacter.Speed();
				
			if (mCharacter.IsInState(CharacterState.ATTACK_STATE) || mCharacter.IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.justPressed("A")) 
			{
				mCharacter.ChangeState(new AttackState(mCharacter));
			}
				
			else if (FlxG.keys.pressed("LEFT"))
			{
				mCharacter.Move(new Point( -1, 0), speed);
				//mCharacter.ChangeAnimation(this.Animation_WalkLeft);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				mCharacter.Move(new Point( 1, 0), speed);
				//ChangeAnimation(this.Animation_WalkRight);
			}
			else if (FlxG.keys.pressed("UP"))
			{
				mCharacter.Move(new Point( 0, -1), speed);
				//mCharacter.ChangeAnimation(this.Animation_WalkUp);
			}
			else if (FlxG.keys.pressed("DOWN"))
			{
				mCharacter.Move(new Point( 0, 1), speed);
				//mCharacter.ChangeAnimation(this.Animation_WalkDown);
			}
			else
			{
				mCharacter.StopMoving();
				mCharacter.ChangeAnimation("idle");
				//mCharacter.ChangeState(new IdleState(CharacterState.IDLE_STATE, mCharacter));
			}
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				var factory:BulletFactory = new BulletFactory(mGame);
				//mGame.getBulletMgr().addBullet(factory.createRayFromCharacter(this, 5, 50)); 
				mGame.getBulletMgr().addBullet(factory.createBulletFromCharacter(mCharacter, 0.2, 50));
			}
		}
		
		
		
	}

}