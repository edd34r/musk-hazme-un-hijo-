package;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSubState;
import extension.webview.WebView;

using StringTools;

class VideoState extends MusicBeatState
{
	public static var androidPath:String = 'file:///android_asset/';

	public var nextState:FlxState;

	public function new(source:String, toTrans:FlxState)
	{
		super();

		nextState = toTrans;

		WebView.onClose = onClose;
		WebView.onURLChanging = onURLChanging;

		WebView.open(androidPath + source + '.html', null, ['http://exitme(.*)']);
	}

	public override function update(dt:Float) 
	{
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				onClose();
			}
		}

		if (WebView == null)
		{
			onClose();
		}

		super.update(dt);
	}

	function onClose()
	{
		FlxG.switchState(nextState);
	}

	function onURLChanging(url:String) 
	{
		if (url == 'http://exitme/') onClose();

		trace("WebView is about to open: " + url);
	}
}