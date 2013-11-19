package  
{
	import flash.utils.SetIntervalTimer;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class AnimationBank 
	{
		var mAnimations:Array;
		var Path:String;
		private var LoadComplete:Boolean;
		
		public function AnimationBank() 
		{
			Path = new String("Not Loaded");
			mAnimations = new Array();
			LoadComplete = false;
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
		
		public function imgContainsAnimation(img:String, name:String):Boolean
		{
			for (var i:uint = 0; i < mAnimations.length; i++)
			{
				var animation:AnimationClip = mAnimations[i];
				if (animation.name == name)
				{
					if (animation.src == img)
						return true;
				}
			}
			return false;
		}
		
		public function getAnimationFromImg(img:String, name:String):AnimationClip
		{
			
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
			
			LoadComplete = true;
		}
		
		public function isFinishedLoading():Boolean
		{
			return LoadComplete;
		}
		
	}

}