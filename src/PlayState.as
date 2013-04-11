package  
{
	import flash.accessibility.AccessibilityProperties;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import org.flixel.FlxCamera;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import LevelMap;
	import org.flixel.FlxTileblock;
	import org.flixel.system.FlxList;
	import TransitionEffect;
	import Character;
	import CellRoom;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PlayState extends FlxState
	{
		protected var mLevelMap:LevelMap;
		//protected var mLevel:CellRoom;
		protected var mDoneLoadingString:String;
		protected var mCellLevel:CellLevel;
		var mTransEffect:TransitionEffect;
		var mCamera:FlxCamera;
		
		var mPlayer:PlayerCharacter;
		var mSlime:EnemySlime;
		
		public var LAYER_BKG:FlxGroup;
		public var LAYER_BKG1:FlxGroup;
		public var LAYER_MID:FlxGroup;
		public var LAYER_ITEM:FlxGroup;
		public var LAYER_ENEMY:FlxGroup;
		public var LAYER_FRONT:FlxGroup;
		
		public var PlayerCurrentItems:FlxGroup;
		public var Keys:uint;
		
		public function PlayState() 
		{
			FlxG.debug = true;
			super();
			
			testCamera();
			CreateLayers();
			LAYER_BKG.add(new FlxText(0, 0, 100, "PLAYSTATE"));
			
			mDoneLoadingString = "NOT DONE LOADING";
			
			mTransEffect = new TransitionEffect(this);
			mTransEffect.init(20, 20, 5);
			mTransEffect.addEventListener("Fade Complete", FadeComplete);
			mPlayer = new PirateCharacter(this, new Point(300, 200));
			PlayerCurrentItems = new FlxGroup();
			
			LAYER_MID.add(mPlayer);
			
			mCellLevel = new CellLevel(this);
			//mCellLevel.LoadLevel("../media/levels/level_1/level_1.xml");
			mCellLevel.LoadLevel("../media/levels/switchtest/switchtest.xml");
			//mCellLevel.LoadLevel("../media/levels/uno/uno.xml");
			//mCellLevel.LoadLevel("../media/levels/aawallgo/aawallgo.xml");
			//mCellLevel.LoadLevel("../media/levels/bkg/bkg.xml");
		}
		
		public function testCamera():void {
			var cam:FlxCamera = new FlxCamera(50, 0, FlxG.camera.width, FlxG.camera.height, 2);
			cam.x = 50;
			cam.y = 50;
			mCamera = cam;
			FlxG.addCamera(mCamera);
			FlxG.camera.follow(mPlayer);
		}
		
		public function testUpdateCam():void
		{
			FlxG.camera.x = 50;
			FlxG.camera.y = 50;
			FlxG.camera.update();
		}
		
		public function TestPHP():void
		{
			var request:URLRequest = new URLRequest("../src/php_scripts/hello.php");
			var variables:URLVariables = new URLVariables();

			variables.score = String(Math.floor(Math.random()*10));

			request.data = variables;
			request.method = URLRequestMethod.POST ;

			var loader:URLLoader = new URLLoader();
			loader.load(request);
			loader.addEventListener(Event.COMPLETE, OnPhpFinished);
		}
		
		public function OnPhpFinished(evt:Event):void
		{
			trace(evt.target.data);
		}
		
		public function CreateLayers():void
		{
				LAYER_BKG = new FlxGroup();
				LAYER_BKG1 = new FlxGroup();
				LAYER_MID = new FlxGroup();
				LAYER_ITEM = new FlxGroup();
				LAYER_ENEMY = new FlxGroup();
				LAYER_FRONT = new FlxGroup();
				
				add(LAYER_BKG);
				add(LAYER_BKG1);
				add(LAYER_ITEM);
				add(LAYER_MID);
				add(LAYER_ENEMY);
				add(LAYER_FRONT);
		}
		
		public function FadeComplete(e:Event):void
		{
			trace("FADE IS DONE");
			
		}
		
		public function AddItemToPlayer( item:Pickup ):void
		{
			var n:Boolean = false;
			if (!PlayerHasItem(item))
			{
				PlayerCurrentItems.add(item);
				if (item.IsOfType(Pickup.ITEM_KEY))
					AddKeyToPlayer(item);
					
				item.kill();
			}
		}
		
		public function AddKeyToPlayer(item:Pickup):void
		{
			Keys++;
		}
		
		public function PlayerHasItem(item:Pickup):Boolean
		{
			for each(var i:Pickup in PlayerCurrentItems.members)
			{
				if ( i.PickupName().toLowerCase() == item.PickupName().toLowerCase())
				{
					return true;
				}
			}
			
			return false;
		}
		
		override public function update():void 
		{
			super.update();
			FlxG.collide(mPlayer, mCellLevel.ActiveRoom().MapCollisionData());
			
			HandleEnemyCollision();
			HandleDebugInput();
			mCellLevel.update();
			testUpdateCam();
			
		}
		
		public function HandleDebugInput():void
		{
			if (FlxG.keys.SHIFT)
			{
					if (FlxG.keys.justPressed('W'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(0,-1));
			}
			if (FlxG.keys.justPressed('S'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(0,1));
			}
			if (FlxG.keys.justPressed('A'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(-1,0));
			}
			if (FlxG.keys.justPressed('D'))
			{
				mCellLevel.ChangeRoomInDirection(new Point(1,0));
			}
			
			if (FlxG.keys.justPressed('END')) {
				mCellLevel.ActiveRoom().testSwitch();
			}
			}
			
			if (FlxG.keys.justPressed('F1'))
			{
				var tile:FlxTileblock = mCellLevel.ActiveRoom().getRandomTile();
				if (tile == null)
					return;
					
				var pos:Point = new Point(tile.x * tile.width, tile.y * tile.height);
				var enemy:EnemySlime = new EnemySlime(this, pos);
				
				mCellLevel.ActiveRoom().addEnemyToRoom(enemy);
			}
			
			if (FlxG.keys.justPressed('F2'))
			{
				mCellLevel.ActiveRoom().reloadRoom();
			}
		}
		
		public function HandleEnemyCollision():void
		{
			/*if (mPlayer.Attacking())
			{
				for (var i:int = 0; i < mLevel.Enemies().length; i++)
				{
					if (FlxG.collide(mPlayer.WeaponHitBox(), mLevel.Enemies().members[i].HitBox()))
					{	
						if (!mPlayer.IsFacingCharacter(mLevel.Enemies().members[i]))
							break;
						
						var e:Enemy =  mLevel.Enemies().members[i];
						e.OnHitCharacter(mPlayer);
					}
				}
			}*/
		}
		
		override public function draw():void 
		{
			super.draw();
		}
		
		public function ActivePlayer():PlayerCharacter
		{
			return mPlayer;
		}
		
		public function ActiveLevel():CellLevel
		{
			return mCellLevel;
		}
	}

}