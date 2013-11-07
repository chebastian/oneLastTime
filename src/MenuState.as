package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import Main;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class MenuState extends FlxState
	{
		var state:FlxState;
		public function MenuState() 
		{
			super();
			add(new FlxText(FlxG.width * 0.4, FlxG.height * 0.2, 200, ""));
			add(new FlxText(FlxG.width * 0.3, FlxG.height * 0.3, 200, "Press ENTER to Continue"));
			//FlxG.switchState(new PlayState());
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.pressed( "ENTER" ))
			{
				state = new PlayState();
				FlxG.switchState(state);
			}
		}
		
	}

}