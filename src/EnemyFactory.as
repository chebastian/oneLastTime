package  
{
	import CharacterStates.TurretIdleState;
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
			var x:int = parseInt( readAttribute("x",xml) ) * mGame.getTileWidth();
			var y:int = parseInt( readAttribute("y",xml) ) * mGame.getTileHeight();
			
			var e:Enemy = new Enemy(mGame, new Point(x, y));
			var enemyType = readAttribute("type",xml);
			
			/*if (enemyType == "walker")
				e = new EnemyWalker(mGame, new Point(x, y));
			else if (enemyType == "turretR" || enemyType == "turretL" || enemyType == "turret")
				e = new EnemyTurret(mGame, new Point(x, y));
			else
			{
				e = new EnemyTurret(mGame, new Point(x, y));
			}*/
			
			e = createEnemyFromType(enemyType);
			e.setPosition(new Point(x, y));
			
			return e;
		}
		
		protected function createEnemyFromType(type:String):Enemy
		{
			if (type == "walker")
			{
				return new EnemyWalker(mGame, new Point(0, 0));
			}
			
			if (type == "turretR" || type == "turret")
			{
				var t:EnemyTurret = new EnemyTurret(mGame, new Point(0, 0));
				t.setHeading(new Point(1, 0));
				return t;
			}
			
			if (type == "turretL")
			{
				var t:EnemyTurret = new EnemyTurret(mGame, new Point(0, 0));
				t.setHeading(new Point(-1, 0));
				return t;
			}
			
			return new EnemyWalker(mGame, new Point(0, 0));
			
		}
		
		protected function readAttribute(name:String, attr:XML):String
		{
			for each(var node in attr.attributes())
			{
				if (node.name() == name)
					return node;
			}
			
			return "NOT FOUND";
		}
		
		
	}

}