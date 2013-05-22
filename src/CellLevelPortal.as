package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class CellLevelPortal extends GameObject 
	{
		
		var mTo:String;
		var mFrom:String;
		
		public function CellLevelPortal(_x:Number, _y:Number,from:String, to:String) 
		{
			super(_x, _y, null);
			mTo = to;
			mFrom = from;
			width = 32;
			height = 32;
			this.moves = false;
			this.immovable = true;
			solid = true;
		}
		
		public function getDestination():String
		{
			return mTo;
		}
		
		public function getOrigin():String {
			return mFrom;
		}
		
	}

}