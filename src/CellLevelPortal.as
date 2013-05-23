package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CellLevelPortal extends GameObject 
	{
		
		var mTo:String;
		var mFrom:String;
		var mIdentifier:String;
		var mRoom:CellRoom;
		var mExitDir:Point;
		
		public function CellLevelPortal(room:CellRoom,_x:Number, _y:Number,from:String, to:String,identifier:String) 
		{
			super(_x, _y, null);
			mTo = to;
			mFrom = from;
			width = 32;
			height = 32;
			this.moves = false;
			this.immovable = true;
			solid = true;
			mIdentifier = identifier;
			mRoom = room;
			mExitDir = new Point(0, 1);
		}
		
		public function getDestination():String
		{
			return mTo;
		}
		
		public function getOrigin():String {
			return mFrom;
		}
		
		public function getIdentifier():String
		{
			return mIdentifier;
		}
		
		public function getRoom():CellRoom
		{
			return mRoom;
		}
		
		public function passThroughPortal(p:PlayerCharacter):void
		{
			p.x += mExitDir.x * this.width;
			p.y += mExitDir.y * this.height;
		}
		
		public function onCompleteLoad():void
		{
			
		}
		
	}

}