package  
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class GameResources 
	{
		
		var mImages:Dictionary;
		var mAnimationBanks:Dictionary;
		var mSound:Dictionary;
		
		public function GameResources() 
		{
			mImages = new Dictionary();
			mAnimationBanks = new Dictionary();
			mSound = new Dictionary();
			
			trace("RESOURCE INSTANCE CREATED");
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
				
				[Embed(source = "../media/pirate/pirate_stabLR.png")]
				var newp4:Class;
				
				[Embed(source = "../media/pirate/pirate_attackU2.png")]
				var newp5:Class;
				
				[Embed(source = "../media/pirate/pirate_attackD2_effect.png")]
				var newp6:Class;
				
				addResource("Pirate_AttackD", newp6);
				addResource("Pirate_attackR", newp4);
				addResource("Pirate_walkLR", newp);
				addResource("Pirate_walkD", newp2);
				addResource("Pirate_walkU", newp3);
				addResource("Pirate_AttackU", newp5);
				addResource("Player_Sheet", ps);
				addResource("Player_Attack", pa);
				
				[]//ADD RESOURCES FOR ANIMs
				
				/*Add Skeleton Resources*/
				[Embed(source = "../media/skeleton/walk_LR.png")]
				var skeleton_anim:Class;
				addResource("Skeleton_walkLR", skeleton_anim);
				
				addPlayerResources();
				addEnemyResources();
				addSoundEffects();
				
				
				[Embed(source = "../media/wallSwitch/wallSwitch.png")]
				var wallSwitch:Class;
				addResource("wallSwitch", wallSwitch);
		}
		
		private function addPlayerResources():void
		{
			[Embed(source = "../media/player/walkLeft.png")]
			var walkLeft:Class;
			
			[Embed(source = "../media/player/walkRight.png")]
			var walkRight:Class;
			
			[Embed(source = "../media/player/walkUp.png")]
			var walkUp:Class;
			
			[Embed(source = "../media/player/walkDown.png")]
			var walkDown:Class;
			
			[Embed(source = "../media/player/bullet/bullet.png")]
			var bullet:Class;
			
			[Embed(source = "../media/player/bullet/ray.png")]
			var bulletRay:Class;
			
			[Embed(source = "../media/player/playerShadow.png")]
			var shadow:Class;
			
			addResource("playerWalkLeft", walkLeft);
			addResource("playerWalkRight", walkRight);
			addResource("playerWalkUp", walkUp);
			addResource("playerWalkDown", walkDown);
			addResource("playerShadow", shadow);
			addResource("bullet", bullet);
			addResource("bulletRay", bulletRay);
		}
		
		public function addEnemyResources():void
		{
			[Embed(source = "../media/enemy/awlker/walkLeft.png")]
			var walkerLeft:Class;
			
			[Embed(source = "../media/enemy/awlker/walkRight.png")]
			var walkerRight:Class;
			
			[Embed(source = "../media/enemy/awlker/attackLeft.png")]
			var attack:Class;
			
			[Embed(source = "../media/enemy/awlker/attackRight.png")]
			var attackR:Class;
			
			[Embed(source = "../media/enemy/awlker/damagedRight.png")]
			var damagedR:Class;
			
			[Embed(source = "../media/enemy/turret/turret.png")]
			var turret:Class;
			
			[Embed(source = "../media/explosion.png")]
			var explosion:Class;
			
			addResource("explosion", explosion);
			addResource("walker_walkLeft", walkerLeft);
			addResource("walker_walkRight", walkerRight);
			
			addResource("walker_attackLeft", attack);
			addResource("walker_attackRight", attackR);
			
			addResource("walker_damagedRight", damagedR);
			
			addResource("turret", turret);
		}
		
		public function addSoundEffects():void
		{
			[Embed(source = "../media/sounds/effects/bullet_shoot.mp3")]
			var sound:Class;
			
			[Embed(source = "../media/sounds/effects/bullet_hit_wall.mp3")]
			var hitWall:Class;
			
			[Embed(source = "../media/sounds/effects/bullet_hit_enemy.mp3")]
			var hitEnemy:Class;
			
			[Embed(source = "../media/sounds/effects/bullet_hit.mp3")]
			var hit:Class;
			
			[Embed(source = "../media/sounds/effects/enemy_charge.mp3")]
			var charge1:Class;
			
			addSound("bullet_hit", hit);
			addSound("bullet_shoot", sound);
			addSound("bullet_hit_wall", hitWall);
			addSound("bullet_hit_enemy", hitEnemy);
			addSound("enemy_charge", charge1);
		}
		
		public function addResource(name:String, img:Class)
		{
			mImages[name] = img;
		}
		
		public function getResource(name:String):Class
		{
			return mImages[name];
		}
		
		public function addAnimationBank(bank:AnimationBank):void
		{
			mAnimationBanks[bank.Path] = bank;
		}
	
		public function hasAnimationBank(name:String):Boolean
		{
			return mAnimationBanks.hasOwnProperty(name);
		}
	
		public function getAnimationBank(name:String):AnimationBank
		{
			return mAnimationBanks[name];
		}
		
		public function addSound(name:String, obj:Class)
		{
			if (!hasSound(name))
				mSound[name] = obj;
		}
		
		public function hasSound(name:String):Boolean
		{
			return mSound.hasOwnProperty(name);
		}
		
		public function getSound(name:String):Class
		{
			return mSound[name];
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
		[Embed(source = "../media/simpleTilesOriginal.png")]
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

