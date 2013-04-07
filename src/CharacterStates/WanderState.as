package CharacterStates 
{
	/**
	 * ...
	 * @author ...
	 */
	import flash.geom.Point;
	import org.flixel.FlxObject;
	import org.flixel.FlxG;
	public class WanderState extends CharacterState 
	{
		var mElapsedTime:Number;
		var mTimeTillTurn:Number;
		var mMaxTimeTillTurn:Number = 3;
		
		public function WanderState(id:uint, char:Character) 
		{
			super(id, char);
			mCharacter.WalkInDir(new Point(0, 1));
			SetNextTurnTime();
			mCharacter.ChangeAnimation("walkUp", GameResources.Anim_SlimeWalk);
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			
			if (mCharacter.justTouched(FlxObject.DOWN | FlxObject.UP | FlxObject.LEFT | FlxObject.RIGHT))
			{
				OnHitWall();
			}
			else if (mElapsedTime >= mTimeTillTurn)
			{
				OnTurn();
			}
			
			mElapsedTime += FlxG.elapsed;
		}
		
		public function OnHitWall():void
		{
			var rand:Number = FlxG.random();
				var rand2:Number = FlxG.random();
				var xd:Number = 1;
				var xy:Number = 1;
				if (rand > 0.5)
					xd *= -1;
				if (rand2 > 0.5)
					xy *= -1;
				if ((rand > 0.5) && (rand2 > 0.5))
					xy *= 0;
				
				mCharacter.TurnInDir(new Point(xd,xy));
			
			mCharacter.WalkInDir(mCharacter.Heading());
			SetNextTurnTime();
		}
		
		public function OnTurn():void
		{
			if (mElapsedTime >= mMaxTimeTillTurn)
			{
				mCharacter.TurnRight();
			}
			else
			{
				var rand:Number = FlxG.random();
				var rand2:Number = FlxG.random();
				var xd:Number = 1;
				var xy:Number = 1;
				if (rand > 0.5)
					xd *= -1;
				if (rand2 > 0.5)
					xy *= -1;
				if ((rand > 0.5) && (rand2 > 0.5))
					xy *= 0;
				
				mCharacter.TurnInDir(new Point(xd,xy));
			}
			
			mCharacter.WalkInDir(mCharacter.Heading());
			SetNextTurnTime();
		}
		
		public function SetNextTurnTime():void 
		{
			mElapsedTime = 0.0;
			mTimeTillTurn = mMaxTimeTillTurn *  FlxG.random();
		}
		
	}

}