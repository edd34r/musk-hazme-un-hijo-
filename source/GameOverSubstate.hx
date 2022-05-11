package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxCamera;

class GameOverSubstate extends MusicBeatSubstate
{
	var heart:FlxSprite;
	var bf:Boyfriend;
	var camFollow:FlxObject;

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = 'pico';
		
		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		bf.alpha = 0;
		add(bf);

		heart = new FlxSprite(x + 60, y + 200);
		heart.frames = Paths.getSparrowAtlas('heartbreak', 'shared');
		heart.animation.addByPrefix('mancocomoyair17', 'slash break', 24);
		heart.animation.addByIndices('tiesocomolospritesdenecky', 'slash break', [4], "", 24);
		add(heart);

		heart.animation.play('mancocomoyair17', true);

		new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			heart.animation.play('tiesocomolospritesdenecky');
		});

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);

		FlxG.sound.play(Paths.sound('heartbreak1'));

		Conductor.changeBPM(100);

		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		#if mobileC
		var camcontrol = new FlxCamera();

		addVirtualPad(NONE, A_B);

		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_virtualpad.cameras = [camcontrol];
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());

			PlayState.loadRep = false;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;

			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd'));

			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
