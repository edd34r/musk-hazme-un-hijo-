package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import lime.net.curl.CURLCode;

#if windows
import Discord.DiscordClient;
#end

using StringTools;

class StoryMenuState extends MusicBeatState
{
	public static var weekUnlocked:Array<Bool> = [true, true, true, true, true, true, true];

	var scoreText:FlxText;
	var curDifficulty:Int = 0;
	var txtWeekTitle:FlxText;
	var curSelected:Int = 0;
	var curSelected2:Int = 0;
	var epicBar:FlxSprite;
	var epicBar2:FlxSprite;
	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;
	var grpLocks:FlxTypedGroup<FlxSprite>;
	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	var weekData:Array<Dynamic> = [
		['Redeemer', 'Withdrawal', 'Dusty-Blizzard']
	];
	var weekCharacters:Array<Dynamic> = [
		['', '', ''],
	];
	var weekNames:Array<String> = [
		"",
	];
	var epicItems:Array<String> = ['area', 'difficulty'];
	var diffsItems:Array<String> = ['normal', 'hard'];

	var areaSelected:Bool = false;
	var difficultySelected:Bool = false;
	var normalApear:Bool = false;
	var hardApear:Bool = false;

	override function create()
	{
		#if windows
		DiscordClient.changePresence("In the Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('Shootin'));
		}

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, " ", 36);
		scoreText.setFormat("VCR OSD Mono", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("vcr.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		var yellowBG:FlxSprite = new FlxSprite(0, 150);
		yellowBG.loadGraphic(Paths.image('menubackgrounds/menu_snowdin'));

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		trace("Line 70");

		for (i in 0...weekData.length)
		{
			var weekThing:MenuItem = new MenuItem(0, yellowBG.y + yellowBG.height + 10, i);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = true;

			if (!weekUnlocked[i])
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = true;
				grpLocks.add(lock);
			}
		}

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10 - 280, grpWeekText.members[0].y - 5);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.setGraphicSize(Std.int(leftArrow.width * 0.2));
		difficultySelectors.add(leftArrow);

		sprDifficulty = new FlxSprite(leftArrow.x + 145, leftArrow.y);
		sprDifficulty.frames = ui_tex;
		sprDifficulty.animation.addByPrefix('easy', 'EASY');
		sprDifficulty.animation.addByPrefix('normal', 'NORMAL');
		sprDifficulty.animation.addByPrefix('hard', 'HARD');
		sprDifficulty.animation.play('easy');
		sprDifficulty.alpha = 0;
		changeItem(0, 'none');

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + sprDifficulty.width + 130, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.setGraphicSize(Std.int(rightArrow.width * 0.2));
		difficultySelectors.add(rightArrow);

		add(yellowBG);

		var icon1:FlxSprite = new FlxSprite(600, -10);
		icon1.loadGraphic(Paths.image('storyicons/ICONsnowdin', 'shared'));
		icon1.antialiasing = true;
		icon1.updateHitbox();
		icon1.setGraphicSize(Std.int(icon1.width * 0.8));
		add(icon1);

		var icon2:FlxSprite = new FlxSprite(630, 90);
		icon2.loadGraphic(Paths.image('storyicons/ICONpico', 'shared'));
		icon2.setGraphicSize(Std.int(icon2.width * 0.7));
		icon2.antialiasing = true;
		icon2.updateHitbox();
		add(icon2);

		var normal:FlxSprite = new FlxSprite(300, 632);
		normal.loadGraphic(Paths.image('menudifficulties/normal'));
		normal.antialiasing = true;
		normal.updateHitbox();
		add(normal);

		var hard:FlxSprite = new FlxSprite(710, 630);
		hard.loadGraphic(Paths.image('menudifficulties/hard'));
		hard.antialiasing = true;
		hard.updateHitbox();
		add(hard);

		epicBar = new FlxSprite(300, 637);
		epicBar.loadGraphic(Paths.image('menudifficulties/normal-var'));
		epicBar.antialiasing = true;
		epicBar.alpha = 0;
		add(epicBar);

		epicBar2 = new FlxSprite(710, 635);
		epicBar2.loadGraphic(Paths.image('menudifficulties/hard-var'));
		epicBar2.antialiasing = true;
		epicBar2.alpha = 0;
		add(epicBar2);

		var txtTracklist:FlxText = new FlxText(555, 560, "Snowdin", 38);
		txtTracklist.setFormat(Paths.font("determination.ttf"), 40, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
		txtTracklist.setGraphicSize(Std.int(txtTracklist.width * 1.4));
		add(txtTracklist);
		add(scoreText);

		changeSelect(0);

		#if mobileC
		addVirtualPad(FULL, A_B);
		#end

		super.create();
	}

	override function update(elapsed:Float)
	{
		if (!movedBack)
		{
			if (!selectedWeek)
			{
				if (controls.UP_P)
				{
					changeSelect(-1);
				}

				if (controls.DOWN_P)
				{
					changeSelect(1);
				}

				if (controls.RIGHT && areaSelected)
					rightArrow.animation.play('press')
				else
					rightArrow.animation.play('idle');

				if (controls.LEFT && areaSelected)
					leftArrow.animation.play('press');
				else
					leftArrow.animation.play('idle');

				if (controls.RIGHT_P)
				{
					if (difficultySelected)
						changeItem(1, 'difficulty');
					else if (areaSelected)
						changeItem(1, 'area');
				}

				if (controls.LEFT_P)
				{
					if (difficultySelected)
						changeItem(-1, 'difficulty');
					else if (areaSelected)
						changeItem(-1, 'area');
				}
			}

			if (controls.ACCEPT)
			{
				selectWeek();
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		if (normalApear)
		{
			epicBar2.alpha = 0;

			FlxTween.tween(epicBar, {alpha: 1}, 1);
		}
		else if (hardApear)
		{
			epicBar.alpha = 0;
			
			FlxTween.tween(epicBar2, {alpha: 1}, 1);
		}

		super.update(elapsed);
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (stopspamming == false)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'));

			stopspamming = true;
		}

		PlayState.storyPlaylist = weekData[0];
		PlayState.isStoryMode = true;
		selectedWeek = true;

		var diffic = "";

		switch (curDifficulty)
		{
			case 0:
				diffic = '';
				curDifficulty = 1;

			case 1:
				diffic = '-hard';
				curDifficulty = 2;
		}

		PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + diffic, StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
		PlayState.storyWeek = 0;
		PlayState.campaignScore = 0;
		PlayState.storyDifficulty = curDifficulty;

		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			LoadingState.loadAndSwitchState(new PlayState(), true);
		});
	}

	function changeItem(change:Int = 0, typeChange:String):Void
	{
		if (typeChange == 'area')
		{
			curSelected += change;

			if (curSelected < 0)
				curSelected = 1;
			if (curSelected > 1)
				curSelected = 0;
		}
		else if (typeChange == 'difficulty')
		{
			curDifficulty += change;

			if (curDifficulty < 0)
				curDifficulty = 1;
			if (curDifficulty > 1)
				curDifficulty = 0;

			FlxG.sound.play(Paths.sound('scrollMenu'));

			switch (curDifficulty)
			{
				case 0:
					normalApear = true;
					hardApear = false;

				case 1:
					normalApear = false;
					hardApear = true;
			}
		}
	}

	function changeSelect(change:Int = 0):Void
	{
		curSelected2 += change;

		if (curSelected2 >= epicItems.length)
			curSelected2 = 0;
		if (curSelected2 < 0)
			curSelected2 = epicItems.length - 1;

		switch (curSelected2)
		{
			case 0:
				areaSelected = true;
				difficultySelected = false;

			case 1:
				areaSelected = false;
				difficultySelected = true;

				switch (curDifficulty)
				{
					case 0:
						normalApear = true;
						hardApear = false;

					case 1:
						normalApear = false;
						hardApear = true;
				}
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
