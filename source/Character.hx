package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;
	public var isPlayer:Bool = false;
	public var specialAnim:Bool = false; // Yep, Psych Engine
	public var curCharacter:String = 'bf';
	public var holdTimer:Float = 0;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		var tex:FlxAtlasFrames;

		this.isPlayer = isPlayer;
		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;

				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				playAnim('danceRight');

				x -= 0;
				y += 0;

			case 'bf':
				var tex = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);

				playAnim('idle');

				x -= 0;
				y += 0;

				flipX = true;

			case 'pico':
				var tex = Paths.getSparrowAtlas('characters/Dusttale_Pico', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'pico idle0', 12, false);
				animation.addByPrefix('idle-resist', 'pico resist loop0', 12, false);
				animation.addByPrefix('idle-prefix', 'pico idle0', 12, false);
				animation.addByPrefix('singUP', 'pico up0', 12, false);
				animation.addByPrefix('singLEFT', 'pico right0', 12, false);
				animation.addByPrefix('singRIGHT', 'pico left0', 12, false);
				animation.addByPrefix('singDOWN', 'pico down0', 12, false);
				animation.addByPrefix('singUPmiss', 'pico up miss0', 12, false);
				animation.addByPrefix('singLEFTmiss', 'pico left miss0', 12, false);
				animation.addByPrefix('singRIGHTmiss', 'pico right miss0', 12, false);
				animation.addByPrefix('singDOWNmiss', 'pico down miss0', 12, false);
				animation.addByPrefix('shoot', 'pico shoot0', 12, false);
				animation.addByPrefix('resistStart', 'pico resist start0', 12, false);
				animation.addByPrefix('resistEnd', 'pico resist end0', 12, false);

				addOffset('idle', 0, 0);
				addOffset('idle-resist', 6, 0);
				addOffset('idle-prefix', 0, 0);
				addOffset("singUP", 12, -26);
				addOffset("singRIGHT", -18, 2);
				addOffset("singLEFT", 12, -3);
				addOffset("singDOWN", 6, 4);
				addOffset("singUPmiss", 12, -26);
				addOffset("singRIGHTmiss", 12, -3);
				addOffset("singLEFTmiss", -18, 2);
				addOffset("singDOWNmiss", 6, 4);
				addOffset('shoot', 6, 0);
				addOffset('resistStart', 6, 0);
				addOffset('resistEnd', 6, 0);

				playAnim('idle');

				x -= 200;
				y += 70;

				flipX = true;

			case 'flowey':
				var tex = Paths.getSparrowAtlas('characters/Dusttale_Flowey', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'flowey idle0', 12, false);
				animation.addByPrefix('singUP', 'flowey up0', 12, false);
				animation.addByPrefix('singLEFT', 'flowey right0', 12, false);
				animation.addByPrefix('singRIGHT', 'flowey left0', 12, false);
				animation.addByPrefix('singDOWN', 'flowey down0', 12, false);
				animation.addByPrefix('singUPmiss', 'flowey up miss0', 12, false);
				animation.addByPrefix('singLEFTmiss', 'flowey left miss0', 12, false);
				animation.addByPrefix('singRIGHTmiss', 'flowey right miss0', 12, false);
				animation.addByPrefix('singDOWNmiss', 'flowey down miss0', 12, false);

				addOffset('idle', 0, 0);
				addOffset("singUP", -2, -2);
				addOffset("singRIGHT", -4, 0);
				addOffset("singLEFT", -6, -1);
				addOffset("singDOWN", -7, -6);
				addOffset("singUPmiss", -2, -2);
				addOffset("singRIGHTmiss", -6, -1);
				addOffset("singLEFTmiss", -4, 0);
				addOffset("singDOWNmiss", -7, -6);

				playAnim('idle');

				x -= 370;
				y += 40;

				scale.set(0.6, 0.6);

				flipX = true;

			case 'tankman':
				var tex = Paths.getSparrowAtlas('characters/tankman', 'shared');
				frames = tex;

				animation.addByPrefix('idle', 'tankman idle0', 12, false);
				animation.addByPrefix('singUP', 'tankman up0', 12, false);
				animation.addByPrefix('singLEFT', 'tankman right0', 12, false);
				animation.addByPrefix('singRIGHT', 'tankman left0', 12, false);
				animation.addByPrefix('singDOWN', 'tankman down0', 12, false);
				animation.addByPrefix('singUPmiss', 'tankman up miss0', 12, false);
				animation.addByPrefix('singLEFTmiss', 'tankman left miss0', 12, false);
				animation.addByPrefix('singRIGHTmiss', 'tankman right miss0', 12, false);
				animation.addByPrefix('singDOWNmiss', 'tankman down miss0', 12, false);

				addOffset('idle', 0, 0);
				addOffset("singUP", 0, 1);
				addOffset("singRIGHT", -31, -2);
				addOffset("singLEFT", 5, 3);
				addOffset("singDOWN", -3, 5);
				addOffset("singUPmiss", 0, 1);
				addOffset("singRIGHTmiss", 5, 3);
				addOffset("singLEFTmiss", 31, -2);
				addOffset("singDOWNmiss", -3, 5);

				playAnim('idle');

				x -= 200;
				y -= 400;

				flipX = true;

			case 'sans':
				tex = Paths.getSparrowAtlas('characters/Dusttale_Sans');
				frames = tex;

				animation.addByPrefix('idle', 'dust sans idle0', 12);
				animation.addByPrefix('singUP', 'dust sans up0', 12);
				animation.addByPrefix('singRIGHT', 'dust sans right0', 12);
				animation.addByPrefix('singDOWN', 'dust sans down0', 12);
				animation.addByPrefix('singLEFT', 'dust sans left0', 12);

				addOffset('idle', 0, 0);
				addOffset("singUP", -2, -11);
				addOffset("singRIGHT", -39, -11);
				addOffset("singLEFT", -23, -2);
				addOffset("singDOWN", 27, 17);

				x -= 300;
				y -= 70;

				playAnim('idle');

			case 'papyrus':
				tex = Paths.getSparrowAtlas('characters/Dusttale_Papyrus');
				frames = tex;

				animation.addByPrefix('idle', 'papyrus idle0', 12);
				animation.addByPrefix('singUP', 'papyrus up0', 12);
				animation.addByPrefix('singRIGHT', 'papyrus right0', 12);
				animation.addByPrefix('singDOWN', 'papyrus down0', 12);
				animation.addByPrefix('singLEFT', 'papyrus left0', 12);
				animation.addByPrefix('dies', 'papyrus dead0', 12);
				animation.addByIndices('ded', 'papyrus dead0', [19], "", 12);

				addOffset('idle', 0, 0);
				addOffset("singUP", -3, -15);
				addOffset("singRIGHT", -4, -7);
				addOffset("singLEFT", -64, -6);
				addOffset("singDOWN", -79, 17);
				addOffset('dies', -54, -10);
				addOffset('ded', -54, -10);

				x -= 300;
				y -= 120;

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			if (!curCharacter.startsWith('bf'))
			{
				var oldRight = animation.getByName('singRIGHT').frames;

				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (specialAnim && animation.curAnim.finished)
		{
			specialAnim = false;
			dance();
		}

		if (!curCharacter.startsWith('bf') || !curCharacter.startsWith('pico'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (holdTimer >= Conductor.stepCrochet * 0.001 * 4)
			{
				trace('dance');
				dance();
				holdTimer = 0;
			}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	public function dance()
	{
		if (!debugMode && !specialAnim)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		specialAnim = false;
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);

		if (animOffsets.exists(AnimName))
			offset.set(daOffset[0], daOffset[1]);
		else
			offset.set(0, 0);
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
