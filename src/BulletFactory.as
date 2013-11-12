package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletFactory 
	{
		var mGame:PlayState;
		public function BulletFactory(game:PlayState) 
		{
			mGame = game;
		}
		
		public function createBulletFromCharacter(char:Character, lifeTime:Number, speed:Number)
		{
			var bullet:Bullet = new Bullet(mGame, char.x, char.y,char.Heading());
			
			bullet.SetSpeed(speed);
			bullet.velocity.x = char.getLookAt().x;
			bullet.velocity.y = char.getLookAt().y;
			bullet.LifeTime = 1.0;
			
			return bullet;
		}
		
		public function createSimpleBullet():Bullet
		{
			var bullet:Bullet = new Bullet(mGame, 0, 0, new Point(0, 0));
			return bullet;
		}
		
	}

}