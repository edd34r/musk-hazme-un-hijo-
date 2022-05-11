package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var areaLeft:FlxSprite;
	var areaRight:FlxSprite;
	var diffLeft:FlxSprite;
	var diffRight:FlxSprite;
	var songLeft:FlxSprite;
	var songRight:FlxSprite;
	var memberSong1:FlxSprite;
	var memberSong2:FlxSprite;
	var memberSong3:FlxSprite;

	var memberTxt1:FlxText;
	var memberTxt2:FlxText;
	var memberTxt3:FlxText;
	var memberDiff1:FlxText;
	var memberDiff2:FlxText;
	var memberDiff3:FlxText;
	var areaTxt:FlxText;

	var epicItems:Array<String> = ['snowdin'];
	var epicItems2:Array<String> = ['redeemer', 'withdrawal', 'dusty blizzard', 'winter wasteland'];
	var epicItems3:Array<String> = ['hard', 'normal'];
	var epicItems4:Array<String> = ['area', 'songs', 'difficulty'];

	var curSelected:Int = 0;
	var curSelected2:Int = 0;
	var curSelected3:Int = 0;
	var curSelected4:Int = 0;
	var manDifficulty:Int = 0;

	var songsGroup:Bool = true;
	var txtGroup:Bool = true;
	var difficultysGroup:Bool = true;
	var areasGroup:Bool = true;
	var areaSelected:Bool = false;
	var songSelected:Bool = false;
	var diffSelected:Bool = false;
	
	var songName:String = 'redeemer';
	var dific:String = '-hard';

	override function create()
	{
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplayBG'));
		bg.updateHitbox();
		bg.antialiasing = true;
		add(bg);

		if (areasGroup)
		{
			areaTxt = new FlxText(570, 50, "Snowdin", 38);
			areaTxt.setFormat(Paths.font("determination.ttf"), 40, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			areaTxt.setGraphicSize(Std.int(areaTxt.width * 1.4));
			add(areaTxt);

			areaLeft = new FlxSprite(areaTxt.x - 85, areaTxt.y - 10);
			areaLeft.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
			areaLeft.animation.addByPrefix('idle', 'arrow left');
			areaLeft.animation.addByPrefix('press', 'arrow push left');
			areaLeft.animation.play('idle');
			add(areaLeft);

			areaRight = new FlxSprite(areaTxt.x + 215, areaTxt.y - 5);
			areaRight.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
			areaRight.animation.addByPrefix('idle', 'arrow right');
			areaRight.animation.addByPrefix('press', 'arrow push right', 24, false);
			areaRight.animation.play('idle');
			add(areaRight);
		}

		if (songsGroup)
		{
			memberSong1 = new FlxSprite(50, 220);
			memberSong1.loadGraphic(Paths.image('freeplay/winter wasteland'));
			memberSong1.setGraphicSize(Std.int(memberSong1.width * 0.3));
			memberSong1.updateHitbox();
			memberSong1.antialiasing = true;
			memberSong1.alpha = 0.9;
			add(memberSong1);

			memberSong2 = new FlxSprite(430, 150);
			memberSong2.loadGraphic(Paths.image('freeplay/redeemer'));
			memberSong2.setGraphicSize(Std.int(memberSong2.width * 0.45));
			memberSong2.updateHitbox();
			memberSong2.antialiasing = true;
			add(memberSong2);

			memberSong3 = new FlxSprite(970, 220);
			memberSong3.loadGraphic(Paths.image('freeplay/withdrawal'));
			memberSong3.setGraphicSize(Std.int(memberSong3.width * 0.3));
			memberSong3.updateHitbox();
			memberSong3.antialiasing = true;
			memberSong3.alpha = 0.9;
			add(memberSong3);

			songLeft = new FlxSprite(memberSong2.x - 60, memberSong2.y + 200);
			songLeft.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
			songLeft.animation.addByPrefix('idle', 'arrow left');
			songLeft.animation.addByPrefix('press', 'arrow push left');
			songLeft.animation.play('idle');
			add(songLeft);

			songRight = new FlxSprite(memberSong2.x + 460, memberSong2.y + 200);
			songRight.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
			songRight.animation.addByPrefix('idle', 'arrow right');
			songRight.animation.addByPrefix('press', 'arrow push right', 24, false);
			songRight.animation.play('idle');
			add(songRight);
		}

		if (txtGroup)
		{
			memberTxt1 = new FlxText(memberSong1.x - 60, memberSong1.y + 300, "Winter Wasteland", 38);
			memberTxt1.setFormat(Paths.font("determination.ttf"), 40, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			memberTxt1.alpha = 0.7;
			memberTxt1.setGraphicSize(Std.int(memberTxt1.width * 0.8));
			add(memberTxt1);

			memberTxt2 = new FlxText(memberSong2.x + 130, memberSong2.y + 450, "Redeemer", 38);
			memberTxt2.setFormat(Paths.font("determination.ttf"), 40, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			memberTxt2.setGraphicSize(Std.int(memberTxt2.width * 1.1));
			add(memberTxt2);

			memberTxt3 = new FlxText(memberSong3.x + 30, memberSong3.y + 300, "Withdrawal", 38);
			memberTxt3.setFormat(Paths.font("determination.ttf"), 40, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			memberTxt3.alpha = 0.7;
			memberTxt3.setGraphicSize(Std.int(memberTxt3.width * 0.8));
			add(memberTxt3);
		}
		
		if (difficultysGroup)
		{
			memberDiff1 = new FlxText(400, 662, "Normal", 38);
			memberDiff1.setFormat(Paths.font("determination.ttf"), 37, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			memberDiff1.alpha = 0.7;
			add(memberDiff1);

			memberDiff2 = new FlxText(595, 665, "Hard", 38);
			memberDiff2.setFormat(Paths.font("determination.ttf"), 40, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			add(memberDiff2);

			memberDiff3 = new FlxText(750, 662, "Normal", 38);
			memberDiff3.setFormat(Paths.font("determination.ttf"), 37, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE);
			memberDiff3.alpha = 0.7;
			add(memberDiff3);

			diffLeft = new FlxSprite(memberDiff2.x - 90, memberDiff2.y - 5);
			diffLeft.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
			diffLeft.animation.addByPrefix('idle', 'arrow left');
			diffLeft.animation.addByPrefix('press', 'arrow push left');
			diffLeft.animation.play('idle');
			diffLeft.setGraphicSize(Std.int(diffLeft.width * 0.1));
			add(diffLeft);

			diffRight = new FlxSprite(memberDiff2.x + 60, memberDiff2.y - 5);
			diffRight.frames = Paths.getSparrowAtlas('campaign_menu_UI_assets');
			diffRight.animation.addByPrefix('idle', 'arrow right');
			diffRight.animation.addByPrefix('press', 'arrow push right', 24, false);
			diffRight.animation.play('idle');
			diffRight.setGraphicSize(Std.int(diffRight.width * 0.1));
			add(diffRight);
		}

		changeItem(1, 'none');

		#if mobileC
		addVirtualPad(FULL, A_B);
		#end

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));

				changeItem(-1, 'none');
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));

				changeItem(1, 'none');
			}

			if (controls.LEFT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));

				if (areaSelected)
					changeItem(-1, 'area');
				else if (songSelected)
					changeItem(-1, 'song');
				else if (diffSelected)
					changeItem(-1, 'difficulty');
			}

			if (controls.LEFT)
			{
				if (areaSelected) {
					areaLeft.animation.play('press');
					songLeft.animation.play('idle');
					diffLeft.animation.play('idle');
				} else if (songSelected) {
					areaLeft.animation.play('idle');
					songLeft.animation.play('press');
					diffLeft.animation.play('idle');
				} else if (diffSelected) {
					areaLeft.animation.play('idle');
					songLeft.animation.play('idle');
					diffLeft.animation.play('press');
				}
			} 
			else 
			{
				areaLeft.animation.play('idle');
				songLeft.animation.play('idle');
				diffLeft.animation.play('idle');
			}

			if (controls.RIGHT_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));

				if (areaSelected)
					changeItem(1, 'area');
				else if (songSelected)
					changeItem(1, 'song');
				else if (diffSelected)
					changeItem(1, 'difficulty');
			}

			if (controls.RIGHT)
			{
				if (areaSelected) {
					areaRight.animation.play('press');
					songRight.animation.play('idle');
					diffRight.animation.play('idle');
				} else if (songSelected) {
					areaRight.animation.play('idle');
					songRight.animation.play('press');
					diffRight.animation.play('idle');
				} else if (diffSelected) {
					areaRight.animation.play('idle');
					songRight.animation.play('idle');
					diffRight.animation.play('press');
				}
			} 
			else 
			{
				areaRight.animation.play('idle');
				songRight.animation.play('idle');
				diffRight.animation.play('idle');
			}

			if (controls.ACCEPT)
			{
				selectedSomethin = true;

				PlayState.SONG = Song.loadFromJson(songName + dific, songName);
				PlayState.isStoryMode = false;
				PlayState.storyDifficulty = manDifficulty;

				if (songName != 'dusty-blizzard')
					LoadingState.loadAndSwitchState(new PlayState());
				else
					LoadingState.loadAndSwitchState(new VideoState('assets/videos/OH_NO_SANS_UNDERTALE', new PlayState()));
			}

			if (controls.BACK)
			{
				selectedSomethin = true;

				FlxG.switchState(new MainMenuState());
			}
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0, typeChange:String)
	{
		if (typeChange == 'area')
		{
			curSelected += huh;

			if (curSelected >= epicItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = epicItems.length - 1;
		}
		else if (typeChange == 'song')
		{
			curSelected2 += huh;

			if (curSelected2 >= epicItems2.length)
				curSelected2 = 0;
			if (curSelected2 < 0)
				curSelected2 = epicItems2.length - 1;

			switch (curSelected2)
			{
				case 0:
					memberSong1.loadGraphic(Paths.image('freeplay/winter wasteland'));
					memberSong2.loadGraphic(Paths.image('freeplay/redeemer'));
					memberSong3.loadGraphic(Paths.image('freeplay/withdrawal'));

					songName = 'redeemer';

					memberTxt1.text = 'Winter Wasteland';
					memberTxt2.text = 'Redeemer';
					memberTxt3.text = 'Withdrawal';

					memberTxt1.x = memberSong1.x - 50;
					memberTxt2.x = memberSong2.x + 130;
					memberTxt3.x = memberSong3.x + 30;

				case 1:
					memberSong1.loadGraphic(Paths.image('freeplay/redeemer'));
					memberSong2.loadGraphic(Paths.image('freeplay/withdrawal'));
					memberSong3.loadGraphic(Paths.image('freeplay/dusty blizzard'));

					songName = 'withdrawal';

					memberTxt1.text = 'Redeemer';
					memberTxt2.text = 'Withdrawal';
					memberTxt3.text = 'Dusty Blizzard';

					memberTxt1.x = memberSong1.x + 30;
					memberTxt2.x = memberSong2.x + 110;
					memberTxt3.x = memberSong3.x - 20;

				case 2:
					memberSong1.loadGraphic(Paths.image('freeplay/withdrawal'));
					memberSong2.loadGraphic(Paths.image('freeplay/dusty blizzard'));
					memberSong3.loadGraphic(Paths.image('freeplay/winter wasteland'));

					songName = 'dusty-blizzard';

					memberTxt1.text = 'Withdrawal';
					memberTxt2.text = 'Dusty Blizzard';
					memberTxt3.text = 'Winter Wasteland';

					memberTxt1.x = memberSong1.x + 10;
					memberTxt2.x = memberSong2.x + 50;
					memberTxt3.x = memberSong3.x - 15;

				case 3:
					memberSong1.loadGraphic(Paths.image('freeplay/dusty blizzard'));
					memberSong2.loadGraphic(Paths.image('freeplay/winter wasteland'));
					memberSong3.loadGraphic(Paths.image('freeplay/redeemer'));

					songName = 'winter-wasteland';

					memberTxt1.text = 'Dusty Blizzard';
					memberTxt2.text = 'Winter Wasteland';
					memberTxt3.text = 'Redeemer';

					memberTxt1.x = memberSong1.x - 20;
					memberTxt2.x = memberSong2.x + 30;
					memberTxt3.x = memberSong3.x + 50;
			}
		}
		else if (typeChange == 'difficulty')
		{
			curSelected3 += huh;

			if (curSelected3 >= epicItems3.length)
				curSelected3 = 0;
			if (curSelected3 < 0)
				curSelected3 = epicItems3.length - 1;

			switch (curSelected3)
			{
				case 0:
					manDifficulty = 2;
					dific = '-hard';

					memberDiff2.text = 'Hard';
					memberDiff2.x = 595;

					diffLeft.x = memberDiff2.x - 90;
					diffRight.x = memberDiff2.x + 60;

					memberDiff1.text = 'Normal';
					memberDiff3.text = 'Normal';

				case 1:
					manDifficulty = 1;
					dific = '';

					memberDiff2.text = 'Normal';
					memberDiff2.x = 575;

					diffLeft.x = memberDiff2.x - 80;
					diffRight.x = memberDiff2.x + 95;

					memberDiff1.text = ' Hard';
					memberDiff3.text = ' Hard';
			}
		}
		else if (typeChange == 'none')
		{
			curSelected4 += huh;

			if (curSelected4 >= epicItems4.length)
				curSelected4 = 0;
			if (curSelected4 < 0)
				curSelected4 = epicItems4.length - 1;

			var daChoice:String = epicItems[curSelected];

			switch (curSelected4)
			{
				case 0:
					areaSelected = true;
					songSelected = false;
					diffSelected = false;

					memberDiff2.color = FlxColor.WHITE;

				case 1:
					areaSelected = false;
					songSelected = true;
					diffSelected = false;

					memberDiff2.color = FlxColor.WHITE;

				case 2:
					areaSelected = false;
					songSelected = false;
					diffSelected = true;

					memberDiff2.color = 0xFFFCFD0B;
			}
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}
