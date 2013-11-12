package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class BulletManager 
	{
		private var mGame:PlayState;
		private var mBullets:FlxGroup;
		
		public function BulletManager(game:PlayState) 
		{
			mGame = game;
			mBullets = new FlxGroup();
		}
		
		public function addBullet(bullet:Bullet):void
		{
			mBullets.add(bullet);
		}
		
		public function getActiveBullets():FlxGroup
		{
			var aliveBullets:FlxGroup;
			for each(var bullet:Bullet in mBullets)
			{
				if (bullet.alive)
				{
					aliveBullets.add(bullet);
				}
			}
			
			return aliveBullets;
		}
		
	}

}