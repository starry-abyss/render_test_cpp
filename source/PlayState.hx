package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	var spriteGroup:FlxGroup = new FlxGroup();
	var atlas:FlxAtlas = new FlxAtlas("atlas");
	
	static var mode:Int = 0;
	
	override public function create():Void
	{
		super.create();
		
		var medvedNode = atlas.addNode("assets/images/medved.png");
		var honeyNode = atlas.addNode("assets/images/honey.png");
		
		//FlxG.scaleMode = new RatioScaleMode();
		
		var count = FlxPoint.get(10, 10);
		var spacing = FlxPoint.get(FlxG.width / count.x, FlxG.height / count.y);
		
		var medvedSize = FlxPoint.get(21, 21);
		var honeySize = FlxPoint.get(14, 15);
		
		for (i in 0...Std.int(count.x))
		for (j in 0...Std.int(count.y))
		{
			var medved = new FlxSprite(i * spacing.x + 0.5, j * spacing.y + 0.5);
			
			if (mode == 0)
				medved.loadGraphic("assets/images/medved.png", true, Std.int(medvedSize.x), Std.int(medvedSize.y));
			else
				medved.frames = medvedNode.getTileFrames(medvedSize);
			
			medved.animation.add("stand", [1, 1, 1, 1, 3], 3, true);
			medved.animation.play("stand");
			if ((i % 2) == 0)
				medved.flipX = true;
			if ((j % 2) == 0)
				medved.animation.reverse();
			
			var honey = new FlxSprite(i * spacing.x + medved.width + 0.5, j * spacing.y + 0.5);
			
			if (mode == 0)
				honey.loadGraphic("assets/images/honey.png", true, Std.int(honeySize.x), Std.int(honeySize.y));
			else
				honey.frames = honeyNode.getTileFrames(honeySize);
			
			honey.animation.add("stand", [0, 1, 2, 3], 6, true);
			if ((j % 2) == 0)
				honey.animation.play("stand");
			
			spriteGroup.add(medved);
			spriteGroup.add(honey);
		}
		
		add(spriteGroup);
		
		var text = new FlxText(10, 10, 100, "Atlas is currently " + ((mode == 0) ? "OFF" : "ON") + " press SPACE to switch mode", 10);
		add(text);
		
		honeySize.put();
		medvedSize.put();
		spacing.put();
		count.put();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.SPACE)
		{
			mode = (mode + 1) % 2;
			FlxG.resetState();
		}
	}
}