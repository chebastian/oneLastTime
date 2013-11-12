package  
{
	import com.adobe.air.crypto.EncryptionKeyGenerator;
	import flash.geom.Point;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class Bullet extends Character 
	{
		var mAnimLoader:AnimationLoader;
		var LifeTime:Number;
		var TimeSinceCreation:Number;
		
		public function Bullet(game:PlayState, _x:Number, _y:Number,dir:Point) 
		{
			super(game, _x, _y);
			mHeading = dir;
			TimeSinceCreation = 0.0;
			LifeTime = 5.0;
		}
		
		override public function Init():void 
		{
			
		}
		
		override public function InitAnimations():void 
		{
			mAnimLoader = new AnimationLoader(mGame);
			mAnimLoader.loadBankFromFile("../media/player/bullet_anim.png");
			ChangeAnimation("bullet");
		}
		
		override public function update():void 
		{
			super.update();
			
			if (active)
			{
				updateLifeTime();
				if (isTimeToDie())
				{
					active = false;
				}
			}
		}
		
		public virtual function updateLifeTime():void
		{
			TimeSinceCreation += FlxG.elapsed;
		}
		
		public virtual function isTimeToDie():Boolean
		{
			return TimeSinceCreation >= LifeTime;
		}
	}

}