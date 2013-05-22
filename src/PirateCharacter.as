package  
{
	import CharacterStates.AttackState;
	import flash.accessibility.AccessibilityImplementation;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.NetGroupReplicationStrategy;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import PlayerCharacter;
	import org.flixel.*;
	import com.adobe.serialization.json.JSON;
	import flash.display.LoaderInfo;

	
	/**
	 * ...
	 * @author Sebastian Ferngren
	 */
	public class PirateCharacter extends PlayerCharacter 
	{
		var mWeaponReach:Number;
		var mLoader:ExternalBitmap;
		var mWalkAnim:FlxSprite;
		
		public function PirateCharacter(game:PlayState, pos:Point) 
		{
			super(game, pos);
			srcWH = new Point(16, 16);
			mAABBOffset = new Point(0, 36);
			mAABBHeightOffset = -16;
			mWeaponReach = 5;
			mWeaponHitbox = new GameObject(this.x, this.y, null);
			mWeaponHitbox.width = 3;
			mWeaponHitbox.height = 3;	
		}
		
		public function onLoadedBitmap(e:ExternalBitmap)
		{
			mWalkAnim = new FlxSprite(0, 0, null);
		}
		
		override public function InitAnimations():void 
		{	
			var resources:GameResources = new GameResources();
			resources.initResources();
			loadGraphic(resources.getResource("Player_Sheet"), true, true, 16, 16, false);
			mCurrentAnimation = "";
			srcWH = new Point(24, 32);
			
			/*var resources:GameResources = new GameResources();
			resources.initResources();
			loadGraphic(resources.getResource("Pirate_WalkLR"), true, true, 16, 16, false);
			mCurrentAnimation = "";
			srcWH = new Point(24, 32);*/
			
			
		/*	this.addAnimationClip(Animation_Idle, [8], mAnimationFrameRate, srcWH.x, srcWH.y, true, resources.getResource("Player_Sheet"));
			this.addAnimationClip(Animation_WalkRight, [0, 1, 2, 3], mAnimationFrameRate, srcWH.x, srcWH.y, true, resources.getResource("Player_Sheet"));
			this.addAnimationClip(Animation_WalkLeft, [4, 5, 6, 7], mAnimationFrameRate, srcWH.x, srcWH.y, true, resources.getResource("Player_Sheet"));
			this.addAnimationClip(Animation_WalkDown, [8, 9, 10], mAnimationFrameRate, srcWH.x, srcWH.y, true, resources.getResource("Player_Sheet"));
			this.addAnimationClip(Animation_WalkUp, [11, 12, 13], mAnimationFrameRate, srcWH.x, srcWH.y, true, resources.getResource("Player_Sheet"));
			this.addAnimationClip(Animation_Attack_R, [0, 1, 0], mAnimationFrameRate, 24, srcWH.y, true, resources.getResource("Player_Attack"));
			
			var attackLeft:AnimationClip = new AnimationClip(Animation_Attack_L, [2, 3, 2], 24, srcWH.y, resources.getResource("Player_Attack"));
			attackLeft.fps = mAnimationFrameRate;
			attackLeft.origin.x = -8;
			attackLeft.origin.y = 0;
			this.addClip(attackLeft);*/
			
			//loadAnimationFromJSON("../media/pirate/animations.txt");
			loadAnimationFromJSON("../media/pirate/character_anim.txt");
			
		}
		
		override public function onLoadedAnimations(e:Event):void 
		{
			var data:Object = JSON.decode(mLoaderJSON.data);	
			
			for (var i = 0; i < data.animations.length; i++)
			{
				parseAnimationFromJSONObject(data.animations[i]);
			}
			
			ChangeAnimation(Animation_Idle);
		}
		
		public function parseAnimationFromJSONObject(obj:Object)
		{
			var res:GameResources = new GameResources();
			res.initResources();
			
			for (var i = 0; i < obj.clips.length; i++)
			{	
				var clip:AnimationClip = parseAnimationsClipFromJSONOjbect(obj.clips[i], obj.fw, obj.fh);
				if (clip.name == Animation_Attack_L)
				{
					var b:Boolean = true;
				}
				clip.fps = obj.fps;
				clip.src = res.getResource(obj.img);
				addClip(clip);
			}
		}
		
		public function parseAnimationsClipFromJSONOjbect(obj:Object,fw:int,fh:int):AnimationClip
		{
			var clip:AnimationClip = new AnimationClip(obj.name, parseFramesFromJSONClip(obj.frames), fw, fh, null);
			clip.origin.x = obj.origin_x;
			clip.origin.y = obj.origin_y;
			return clip;
		}
		
		public function parseFramesFromJSONClip(strFrames:Object):Array
		{
			var framesArr = new Array();
			var str = new String(strFrames);
			var num = new String("");
			var validStr = new String("01234567890");
			for (var i = 0; i < str.length; i++)
			{
				var ch = str.charAt(i);
				if (ch != ",")
					num += ch;
				else {
					framesArr.push(parseInt(num));
					num = "";
				}
			}
			framesArr.push(parseInt(num));
			
			return framesArr;
		}
		
		override public function update():void 
		{
			super.update();
			this.mWeaponHitbox.x = this.x + (mHeading.x * this.mWeaponReach);
			this.mWeaponHitbox.y = this.y + (mHeading.y * this.mWeaponReach);
		}
		
		override public function draw():void 
		{
			super.draw();
			//this.mWeaponHitbox.draw();
		}
		override public function HandleInput():void 
		{
			var speed:Number = 100.0;
		
				
			if (IsInState(CharacterState.ATTACK_STATE) || IsInState(CharacterState.DAMAGED_STATE) )
				return;
				
			if (FlxG.keys.justPressed("A")) 
			{
				ChangeState(new AttackState(this));
			}
				
			else if (FlxG.keys.pressed("LEFT"))
			{
				Move(new Point( -1, 0), speed);
				ChangeAnimation(Character.Animation_WalkLeft, GameResources.Player_Sheet);
			}
			
			else if (FlxG.keys.pressed("RIGHT"))
			{
				Move(new Point( 1, 0), speed);
				ChangeAnimation(Character.Animation_WalkRight, GameResources.Player_Sheet);
				this.facing = RIGHT;
			}
			else if (FlxG.keys.pressed("UP"))
			{
				Move(new Point( 0, -1), speed);
				ChangeAnimation(Character.Animation_WalkUp, GameResources.Player_Sheet);
			}
			else if (FlxG.keys.pressed("DOWN"))
			{
				Move(new Point( 0, 1), speed);
				ChangeAnimation(Character.Animation_WalkDown, GameResources.Player_Sheet);
			}
			else
			{
				//ChangeAnimation(Character.Animation_Idle);
				this.play(mCurrentAnimation, true);
				StopMoving();
			}
		}
		
	}

}