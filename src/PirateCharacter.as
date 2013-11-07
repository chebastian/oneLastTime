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
		var animLoader:AnimationLoader;
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
			mAnimationFrameRate = 2;
		}		
		
		override public function InitAnimations():void 
		{	
			var resources:GameResources = new GameResources();
			resources.initResources();
			//loadGraphic(resources.getResource("Player_Sheet"), true, true, 16, 16, false);
			mCurrentAnimation = "";
			srcWH = new Point(24, 32);
			animLoader = new AnimationLoader(mGame);
			
			animLoader.loadBankFromFile("../media/pirate/character_anim.txt");
			animLoader.addEventListener(Event.COMPLETE, testOnComplete);
			ChangeAnimation(Animation_WalkDown, resources.getResource("Pirate_walkD"));
		}
		
		public function testOnComplete(e:Event):void 
		{
			{
				mAnimations = animLoader.getAnimationBank();
				mAnimations.registerAnimationsToSprite(this);
			}
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
			var speed:Number = WALK_SPEED;
		
				
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