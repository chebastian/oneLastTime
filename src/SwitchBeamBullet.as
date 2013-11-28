package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class SwitchBeamBullet extends Bullet 
	{
		
		public function SwitchBeamBullet(game:PlayState, _x:Number, _y:Number, dir:Point) 
		{
			super(game, _x, _y, dir);
			mAnimationsPath = "../media/beam/animations.txt";
			this.mFireSound = "";
		}
		
		override public function Init():void 
		{
			super.Init();
			mIsAttacking = false;
		}
		
		override public function OnHitCharacter(char:Character):Boolean 
		{
			return super.OnHitCharacter(char);
		}
		
	}

}