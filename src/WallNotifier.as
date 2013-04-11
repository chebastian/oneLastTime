package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class WallNotifier extends EntityObserver
	{
		var mWalls:FlxGroup;
		var mGame:PlayState;
		
		public function WallNotifier(game:PlayState, walls:FlxGroup) 
		{
			super(mUniqueId);
			mWalls = walls;
			mGame = game;
		}
		
		override public function onNotify():void 
		{
			for each(var wall:RaisableWall in mWalls.members)
			{
				mGame.ActiveLevel().setGlobalSwitchState(wall.toggleOpenClosed());
			}
			super.onNotify();
		}
		
	}

}