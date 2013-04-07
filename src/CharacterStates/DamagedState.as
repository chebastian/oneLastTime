package CharacterStates 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class DamagedState extends CharacterState 
	{
		
		var mDamageCooldown:Number = 1.0;
		public function DamagedState(char:Character) 
		{
			super(DAMAGED_STATE, char);
		}
		
		override public function OnEnter():void 
		{
			super.OnEnter();
			mCharacter.ChangeAnimation("damaged", GameResources.Anim_SlimeDamaged);
			trace("DAMAGER");
			mStateTimer = 0.0;
			mCharacter.WalkInDir(new Point(0, 0));
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			
			if (mCharacter.finished)
				mCharacter.ChangeState(new WanderState(0, mCharacter));
		}
		
	}

}