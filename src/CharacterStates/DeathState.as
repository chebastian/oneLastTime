package CharacterStates 
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class DeathState extends CharacterState 
	{
		
		public function DeathState(char:Character) 
		{
			super(DEATH_STATE, char);
			mStateTimer = 0;
		}
		
		override public function OnEnter():void 
		{
			super.OnEnter();
			mCharacter.ChangeAnimation("death", GameResources.Anim_SlimeDeath);
		}
		
		override public function OnUpdate():void 
		{
			super.OnUpdate();
			if (mCharacter.finished)
			{
				mCharacter.kill();
			}
		}
		
		override public function OnExit():void 
		{
			super.OnExit();
		}
		
	}

}