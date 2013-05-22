package  
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class GameResources 
	{
		
		var mImages:Dictionary;
		
		public function GameResources() 
		{
			mImages = new Dictionary();
			trace("INSTANCE CREATED");
		}
		
		public function initResources():void
		{
			//
		//New pirate char
		//
				[Embed(source = "../media/Player_sheet.png")]
				var ps:Class;
		
				[Embed(source = "../media/player_attack.png")]
				var pa:Class;
				
				[Embed(source = "../media/pirate/pirate_attackD.png")]
				var pad:Class;
				
				[Embed(source = "../media/pirate/pirate_walkLR2.png")]
				var newp:Class;
					
				[Embed(source = "../media/pirate/pirate_walkD22.png")]
				var newp2:Class;
				
				[Embed(source = "../media/pirate/pirate_walkU2.png")]
				var newp3:Class;
				
				[Embed(source = "../media/pirate/pirate_attackR.png")]
				var newp4:Class;
				
				addResource("Pirate_attackR", newp4);
				addResource("Pirate_walkLR", newp);
				addResource("Pirate_walkD", newp2);
				addResource("Pirate_walkU", newp3);
				addResource("Player_AttackD", pad);
				addResource("Player_Sheet", ps);
				addResource("Player_Attack", pa);
		}
		
		public function addResource(name:String, img:Class)
		{
			mImages[name] = img;
		}
		
		public function getResource(name:String):Class
		{
			return mImages[name];
		}
		
		[Embed(source = "../media/Player_sheet.png")]
		public static var Player_Sheet:Class;
		
		[Embed(source = "../media/player_attack.png")]
		public static var Player_Attack:Class;
				
		//
		// Level Tiles
		//
		
		[Embed(source="../media/tiles_16_75.png")]
		public static var Tiles_Base:Class;
		
		[Embed(source="../media/tiles_zelda_16_75.png")]
		public static var Tiles_Zelda:Class;
		
		//
		// Links animations
		//
		[Embed(source="../media/link_walk_down_32_32.png")]
		public static var Anim_LinkWalkDown:Class;
		
		[Embed(source="../media/link_walk_up_32_32.png")]
		public static var Anim_LinkWalkUp:Class;
		
		[Embed(source="../media/link_walk_side_32_32.png")]
		public static var Anim_LinkWalkRight:Class;
		
		[Embed(source="../media/Rlink_walk_side_32_32.png")]
		public static var Anim_LinkWalkLeft:Class;
		
		[Embed(source = "../media/link_attack_right.png")]
		public static var Anim_Link_Attack_Right:Class;
		
		[Embed(source = "../media/slash_32_32.png")]
		public static var Anim_Attack:Class;
		
		
		//
		//Slime animations
		//
		[Embed(source = "../media/slime_walk_32_32.png")]
		public static var Anim_SlimeWalk:Class;
		
		[Embed(source = "../media/slime_trail_32_32.png")]
		public static var Anim_SlimeTrail:Class;
		
		[Embed(source = "../media/slime_dmg.png")]
		public static var Anim_SlimeDamaged:Class;
		
		[Embed(source = "../media/slime_death.png")]
		public static var Anim_SlimeDeath:Class;
		
		//
		//Map images
		//
		[Embed(source = "../media/map_tile.png")]
		public static var Map_Tile:Class;
		
		[Embed(source = "../media/tile_locked_16_16.png")]
		public static var Tile_Locked:Class;
		
		//[Embed(source = "../media/rouge_tiles.png")]
		[Embed(source = "../media/rouge_alpha2.png")]
		public static var Map_Tile_2:Class;
		
		
		//
		//Pickups and items
		//
		[Embed(source = "../media/pickups.png")]
		public static var Pickups:Class;
		
		[Embed(source = "../media/raisablewall.png")]
		public static var RaisableWall:Class;
		
		[Embed(source = "../media/wallSwitch.png")]
		public static var WallSwitch:Class;
	}

}

