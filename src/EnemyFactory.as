package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class EnemyFactory 
	{
		var mGame:PlayState;
		
		public function EnemyFactory(game:PlayState) 
		{
			mGame = game;
		}
		
		
		public function createEnemyFromXMLNode(xml:XML):Enemy 
		{
			var x:int = parseInt( readAttribute("x",xml) );
			var y:int = parseInt( readAttribute("y",xml) );
			
			var e:Enemy = new Enemy(mGame, new Point(x, y));
			var enemyType = readAttribute("type",xml);
			
			if (enemyType == "walker")
				e = new EnemyWalker(mGame, new Point(x, y));
			else if (enemyType == "turret")
				e = new EnemyTurret(mGame, new Point(x, y));
			
			return e;
		}
		
		protected function readAttribute(name:String, attr:XML):String
		{
			for each(var node in attr)
			{
				if (node.name() == name)
					return node;
			}
			
			return "NOT FOUND";
		}
		
		
	}

}