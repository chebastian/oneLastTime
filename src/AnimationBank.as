package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AnimationBank 
	{
		var mAnimations:Array;
		var Path:String;
		
		public function AnimationBank() 
		{
			Path = new String("Not Loaded");
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
		
		
		public function registerAnimationsToSprite(spr:FlxSprite)
		{
			for (var i:int = 0; i < mAnimations.length; i++)
			{
				var anim:AnimationClip = mAnimations[i];
				spr.addAnimation(anim.name, anim.frames, anim.fps, anim.looped);
			}
		}
		
	}

}