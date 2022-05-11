package;

import openfl.Lib;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;

#if windows
import llua.Lua;
#end

class PauseSubState extends MusicBeatSubstate
{
	var menuItems:Array<String> = ['Resume', 'Options', 'Restart', 'Exit'];
	var offsetChanged:Bool = false;
	var blizzardSong:Bool = PlayState.SONG.song.toLowerCase() == 'dusty blizzard';
	var winterSong:Bool = PlayState.SONG.song.toLowerCase() == 'winter wasteland';
	var normalDiff:Bool = PlayState.storyDifficulty == 1;
	var curSelected:Int = 0;
	var pauseMusic:FlxSound;
	var perSongOffset:FlxText;
	var itemsBg:FlxSprite;
	var fixBg:FlxSprite;

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded(Paths.music('tea-time'), true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		itemsBg = new FlxSprite(0, -800);
		itemsBg.loadGraphic(Paths.image('snowdin/pause/' + PlayState.SONG.song.toLowerCase() + '/0', 'shared'));
		itemsBg.antialiasing = true;
		itemsBg.scrollFactor.set();
		add(itemsBg);

		if (winterSong)
		{
			fixBg = new FlxSprite(0, -800);
			fixBg.loadGraphic(Paths.image('snowdin/pause/bugfixes/winter wasteland', 'shared'));
			fixBg.antialiasing = true;
			fixBg.scrollFactor.set();
			add(fixBg);
		}
		else if (normalDiff)
		{
			fixBg = new FlxSprite(0, -800);
			fixBg.loadGraphic(Paths.image('snowdin/pause/bugfixes/normal', 'shared'));
			fixBg.antialiasing = true;
			fixBg.scrollFactor.set();
			add(fixBg);
		}

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(itemsBg, {y: 0}, 1, {ease: FlxEase.quartInOut, startDelay: 0.1});
		if (winterSong || normalDiff) FlxTween.tween(fixBg, {y: 0}, 1, {ease: FlxEase.quartInOut, startDelay: 0.1});

		changeSelection();

		#if mobileC
		var camcontrol = new FlxCamera();

		addVirtualPad(UP_DOWN, A_B);

		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_virtualpad.cameras = [camcontrol];
		#end

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;
		var rightP = controls.RIGHT_P;
		var accepted = controls.ACCEPT;
		var songPath = 'assets/data/' + PlayState.SONG.song.toLowerCase() + '/';

		if (upP)
			changeSelection(-1);
		else if (downP)
			changeSelection(1);

		if (accepted)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "Resume":
					close();

				case "Options":
					if (PlayState.loadRep)
					{
						FlxG.save.data.botplay = false;
						FlxG.save.data.scrollSpeed = 1;
						FlxG.save.data.downscroll = false;
					}

					PlayState.loadRep = false;

					#if windows
					if (PlayState.luaModchart != null)
					{
						PlayState.luaModchart.die();
						PlayState.luaModchart = null;
					}
					#end

					if (FlxG.save.data.fpsCap > 290)
						(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);
					
					FlxG.switchState(new OptionsMenu());

				case "Restart":
					FlxG.resetState();

				case "Exit":
					if (PlayState.loadRep)
					{
						FlxG.save.data.botplay = false;
						FlxG.save.data.scrollSpeed = 1;
						FlxG.save.data.downscroll = false;
					}

					PlayState.loadRep = false;

					#if windows
					if (PlayState.luaModchart != null)
					{
						PlayState.luaModchart.die();
						PlayState.luaModchart = null;
					}
					#end

					if (FlxG.save.data.fpsCap > 290)
						(cast (Lib.current.getChildAt(0), Main)).setFPSCap(290);
					
					FlxG.switchState(new MainMenuState());
			}
		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		FlxG.sound.play(Paths.sound('scrollMenu'));

		var daSelected:String = menuItems[curSelected];

		switch (daSelected)
		{
			case "Resume":
				itemsBg.loadGraphic(Paths.image('snowdin/pause/' + PlayState.SONG.song.toLowerCase() + '/0', 'shared'));

			case "Options":
				itemsBg.loadGraphic(Paths.image('snowdin/pause/' + PlayState.SONG.song.toLowerCase() + '/1', 'shared'));

			case "Restart":
				itemsBg.loadGraphic(Paths.image('snowdin/pause/' + PlayState.SONG.song.toLowerCase() + '/2', 'shared'));

			case "Exit":
				if (blizzardSong) 
					itemsBg.loadGraphic(Paths.image('snowdin/pause/bugfixes/hola', 'shared'));
				else	
					itemsBg.loadGraphic(Paths.image('snowdin/pause/' + PlayState.SONG.song.toLowerCase() + '/3', 'shared'));
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}
}