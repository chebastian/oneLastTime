package  
{
	import CharacterStates.IdleState;
	import flash.accessibility.Accessibility;
	import flash.automation.Configuration;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.net.drm.LoadVoucherSetting;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CellLevel extends Cell
	{
		
		var mRoomList:Array;
		var mClearedRooms:Array;
		var mActiveRoom:CellRoom;
		var mActiveIndex:Point;
		var mMinimapPos:Point;
		var mMiniMap:MiniMap;
		var mPickups:FlxGroup;
		var mSwitchState:Boolean;
		
		var mGameObjects:FlxGroup;
		
		private var mWorkingDir:String;
		private var mLevelName:String;
		
		public function CellLevel(game:PlayState)
		{
			super(new Point(0, 0), game);
			mActiveIndex = new Point(0, 0);
			mRoomList = new Array();
			mActiveRoom = new CellRoom(mGame, 0,"");
			mClearedRooms = new Array();
			mPickups = new FlxGroup();
			mMiniMap = new MiniMap(this, -50, 0);
			mWorkingDir = "../media/levels/";
			mLevelName = "";
			mGameObjects = new FlxGroup();
			mSwitchState = false;
		}
		
		public function AddPickup(item:Pickup):void
		{
			mPickups.add(item);
		}
		
		override public function update():void 
		{
			super.update();
			mActiveRoom.update();
			HandlePlayerExit();
		}
		
		protected function HandlePlayerExit():void	
		{
			var exitIndex:uint = mActiveRoom.PlayerReachExit(mGame.ActivePlayer());
			if (exitIndex != CellRoom.BOUNDS_NONE)
			{
				if(ChangeRoomByBounds(exitIndex))
					mActiveRoom.HandlePlayerExit(mGame.ActivePlayer(), exitIndex);
			}
			
			mActiveRoom.HandlePlayerEnemyCollision(mGame.ActivePlayer());
			mActiveRoom.handlePlayerWallCollision(mGame.ActivePlayer());
		}
		
		protected function ChangeRoomByBounds(bound:uint):Boolean
		{
			if (bound == CellRoom.BOUNDS_NONE)
				return false;
			
			switch(bound)
			{
				case CellRoom.BOUNDS_LEFT:
					return ChangeRoomInDirection(new Point( -1, 0));
					break;
				case CellRoom.BOUNDS_RIGHT:
					return ChangeRoomInDirection(new Point(1, 0));
					break;
				case CellRoom.BOUNDS_UP:
					return ChangeRoomInDirection(new Point(0, -1));
					break;
				case CellRoom.BOUNDS_DOWN:
					return ChangeRoomInDirection(new Point(0, 1));
					break;
				default:
					return false;
					
			}
			return true;
		}
		
		public function LoadLevel(path:String):Boolean
		{
			var xmlLoader:URLLoader = new URLLoader();
			var xmlData:XML = new XML();
			
			xmlLoader.addEventListener(Event.COMPLETE, OnLoadLevel);
			xmlLoader.load(new URLRequest(path));
			return true;
		}
		
		protected function OnLoadLevel(e:Event):void
		{
			var xmlData:XML = new XML(e.target.data);
			var xmlList:XMLList = xmlData.data;
			var dataAttributes:XMLList = xmlData.attributes();
			var levelList:XMLList = xmlData.rooms.room;
			
			ParseLevelInfo(dataAttributes);
			
			CreateEmptyLevel();
			
			ParseLevelRooms(levelList);
			
			
			ChangeRoom(new Point(0, 0));
			mMiniMap = new MiniMap(this, 0, 0);
			mMiniMap.GenerateMap();
			
			//mGame.add(mMiniMap);
		}	
		
		protected function ParseLevelInfo(nodes:XMLList):Boolean
		{
			var id:String = new String();
			var index:Point = new Point();
			var sz:Point = new Point();
			
			for each(var attr in nodes)
			{
				if (attr.name() == "id")
				{
					id = attr;
				}
				else if (attr.name() == "w")
				{
					sz.x = parseFloat(attr);
				}
				else if (attr.name() == "h")
				{
					sz.y = parseFloat(attr);
				}
			}
			
			width = sz.x;
			height = sz.y;
			mLevelName = id;
			
			return true;
		}
		
		public function CreateEmptyLevel():void
		{
			mRoomList = new Array(width*height);
			for (var i:uint = 0; i < width*height; i++)
			{
				var emptyRoom:CellRoom = new CellRoom(mGame,0, CellRoom.FILE_EMPTY_ROOM);
				emptyRoom.SetMapIndex(IndexToPos(i));
				mRoomList[i] = emptyRoom;
				mClearedRooms[i] = new CellEvent(emptyRoom, emptyRoom.GetUniqueId(), false);
			}
		}
		
		protected function ParseLevelRooms(nodes:XMLList):Boolean
		 {
			 for each(var node in nodes)
			 {
				 var id:uint = new uint();
				 var pos:Point = new Point();
				 var file:String = new String();
				 trace(node.name()); 
				 
				 if (node.name() == "room")
				 {
					for each(var attributes in node.attributes())
					{
						if (attributes.name() == "id")
						{
							id = parseInt( attributes );
						}
						
						else if (attributes.name() == "indexX")
						{
							pos.x = parseFloat( attributes );
						}
						
						else if (attributes.name() == "indexY")
						{
							pos.y = parseFloat( attributes );
						}
						
						else if (attributes.name() == "file")
						{
							file = attributes;
							
							file = MatchFilepathToDir(file, mWorkingDir);
						}
					}
					var room:CellRoom = new CellRoom(mGame, id, file);
					ParseGameObjects(node.gameObjects, room);
					AddRoomAtIndex(room, pos);
				 }
				 
			 }
			 return true;
		 
		 }
		 
		 
		protected function ParseGameObjects(nodes:XMLList,room:CellRoom):void {
			var doors:XMLList = nodes.door;
			var switches:XMLList = nodes.doorSwitch;
			
			parseSwitches(switches, room);
			parseDoors(doors, room);
			parseGameObj(nodes, room, "doorSwitch");
			//mGame.LAYER_ENEMY.add(mGameObjects);
			
		}
		
		public function parseGameObj(nodes:XMLList, room:CellRoom, name:String):void
		{
			for (var node in nodes)
			{
				var name:String = node.toString();
				name = name;
			}
		}
		
		private function parseDoors(nodes:XMLList, room:CellRoom)
		{
			for each(var node in nodes)
			{
				var pos:FlxPoint = new FlxPoint();
				var open:Boolean = false;
			
				for each(var attribute in node.attributes())
				{
				if (attribute.name() == "x")
				{
					pos.x = parseInt(attribute);
				}
				else if (attribute.name() == "y")
				{
					pos.y = parseInt(attribute);
				}
				else if (attribute.name() == "open")
				{
					open = attribute == true;
				}
				}
				
				var wall:RaisableWall = new RaisableWall(pos.x * 32, pos.y * 32);
				wall.setOpen(open);
				mGameObjects.add(wall);
				//room.AddGameObjects(wall);
				room.addRaisableWall(wall);
			}
		}
		
		private function parseSwitches(nodes:XMLList, room:CellRoom) 
		{
			for each(var node in nodes)
			{
				var pos:FlxPoint = new FlxPoint();
				var open:Boolean = false;
			
				for each(var attribute in node.attributes())
				{
				if (attribute.name() == "x")
				{
					pos.x = parseInt(attribute);
				}
				else if (attribute.name() == "y")
				{
					pos.y = parseInt(attribute);
				}
				else if (attribute.name() == "open")
				{
					open = attribute == true;
				}
				}
				
				var wallSwitch:WallSwitch= new WallSwitch(mGame,pos.x * 32, pos.y * 32);
				wallSwitch.setOpen(open);
				//mGameObjects.add(wallSwitch);
				room.addWallSwitch(wallSwitch);
		}
		}
		 
		 private function MatchFilepathToDir(file:String, path:String):String
		 {
			 var fullpath:String = "";
			 
			 var res:int = file.search(path);
			 if (res != -1)
			 {
				 return file;
			 }
			 
			 fullpath += path + mLevelName + "/" + file;
			 
			 return fullpath;
		 }
		
		 public function AddRoom(id:uint, pos:Point, file:String):Boolean
		 {
			 
			 var room:CellRoom = new CellRoom(mGame,id, file);
			 room.SetMapIndex(pos);
			 
			 if (GetRoomAtIndex(pos) == null)
				 return false;
			 
			 mRoomList[PosToIndex(pos)] = room;
			 
			 return true;
		 }
		 
		 public function AddRoomAtIndex(room:CellRoom, index:Point):Boolean
		 {
			 if (GetRoomAtIndex(index) == null)
				return false;
				
			 mRoomList[PosToIndex(index)] = room;
			 
			 return true;
		 }
		 
		protected function ChangeRoom(index:Point):Boolean
		{
			var nextRoom:CellRoom = GetRoomAtIndex(index);
			
			if (nextRoom == null)
				return false;
			
				
			ExitCurrentRoom();
			mActiveIndex = index;
			EnterNextRoom(nextRoom);
			UpdateMiniMap();
			
			return true;
		}
		
		protected function ExitCurrentRoom():void 
		{
			if (mActiveRoom != null)
			{
				if (mActiveRoom.RoomIsCleared())
				{
					if (AddClearedRoom(mActiveIndex))
					{
						var c:Boolean = false;
					}
				}
				mActiveRoom.OnExit();
				mActiveRoom.exists = false;
				mActiveRoom.kill();
			}
		}
		
		protected function EnterNextRoom(nextRoom:CellRoom):void
		{
			mActiveRoom = nextRoom;
			if (RoomIsCleared(mActiveIndex))
			{
				mActiveRoom.SetEventStatus(CellRoom.EVT_ROOM_CLEARED, true);
			}
			
			mActiveRoom.OnEnter();
			AddActiveRoomToStage();
		}
		
		protected function RoomIsCleared(index:Point):Boolean
		{
			return mClearedRooms[PosToIndex(index)].State;
		}
		
		private function AddClearedRoom(pos:Point):Boolean
		{
			var index:uint = PosToIndex(pos);
			if (index >= 0 || index < mRoomList.length)
			{
				mClearedRooms[index].State = true;
				return true;
			}
			
			return false;
		}
		
		protected function UpdateMiniMap():void 
		{
			if (mMiniMap != null)
			{
				mMiniMap.SetActiveTile(mActiveIndex);
			}
		}
		
		protected function AddActiveRoomToStage():void
		{
			mGame.LAYER_BKG.add(mActiveRoom);
			mActiveRoom.SetMapIndex(mActiveIndex);
		}
		
		public function RoomExistsAt(pos:Point):Boolean
		{
			var room:CellRoom = GetRoomAtIndex(pos);
			if (room == null)
				return false;
				
			return !room.EmptyRoom();
		}
		
		public function IsActiveRoom(pos:Point):Boolean
		{
			if (mActiveIndex == pos)
				return true;
			
			return false;
		}
		
		public function GetRoomAtIndex(index:Point):CellRoom
		{
			var numIndex:uint = index.x + index.y * width;
			
			if (index.x >= width || index.y >= height || index.y < 0 || index.x < 0)
				return null;
				
			return mRoomList[numIndex];
		}
		
		public function ChangeRoomInDirection(dir:Point):Boolean
		{
			var newIndex:Point = new Point(mActiveIndex.x + dir.x, mActiveIndex.y + dir.y);
			
			var newroom:CellRoom = GetRoomAtIndex(newIndex);
			if (newroom != null)
			{
				ChangeRoom(newIndex);
				return true;
			}
			
			return false;
		}
		
		public function PosToIndex(pos:Point):uint
		{
			return pos.x + pos.y * width;
		}
		
		public function IndexToPos(index:uint):Point
		{
			var point:Point = new Point(0, 0);
			
			point.x = (int)(index / width);
			point.y = (int)(index % width);
			
			return point;
		}
		
		public function ActiveRoom():CellRoom
		{
			return mActiveRoom;
		}
		
		public function getGlobalSwitchState():Boolean {
			return mSwitchState;
		}
		
		public function setGlobalSwitchState(status:Boolean):void {
			mSwitchState = status;
		}
	}

}