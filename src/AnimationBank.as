package  
{
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AnimationBank 
	{
		var mAnimations:Array;
		public function AnimationBank() 
		{
			mAnimations = new Array();
		}
		
		public function addAnimation(clip:AnimationClip)
		{
			mAnimations.push(clip);
		}
		
		public function containsClip(name:String):Boolean
		{
			for (var i:uint = 0; i < mAnimations.length; i++)
			{
				if (mAnimations[i].name == name)
					return true;
			}
			
			return false;
		}
		
		public function getAnimation(name:String):AnimationClip
		{
			for (var i:uint = 0; i < mAnimations.length; i++)
			{
				if (mAnimations[i].name == name)
					return mAnimations[i];
			}
			
			return null;
		}
		
	}

}