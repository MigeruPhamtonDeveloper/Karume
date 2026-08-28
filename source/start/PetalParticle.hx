package start;

import flixel.FlxSprite;
import flixel.animation.FlxAnimation;
import flixel.effects.particles.FlxParticle;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PetalParticle extends FlxParticle
{
    override public function loadGraphic(graphic:FlxGraphicAsset, animated = false, frameWidth = 0, frameHeight = 0, unique = false, ?key:String):FlxSprite
    {
        super.loadGraphic(graphic, animated, frameWidth, frameHeight, unique, key);

        if (animated && frames != null && frames.frames.length > 1 && animation.getByName("idle") == null)
        {
            var frameCount = frames.frames.length;
            var indices:Array<Int> = [];
            for (i in 0...frameCount)
                indices.push(i);

            animation.add("idle", indices, 10, true);
        }

        if (animation.getByName("idle") != null)
            animation.play("idle");

        return this;
    }

    override public function reset(X:Float, Y:Float):Void
    {
        super.reset(X, Y);
        if (animation.getByName("idle") != null)
            animation.play("idle");
    }
}
