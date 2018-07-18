package pl.nedu.snake.display;

import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.Assets;

class Bonus extends Sprite {
    public var position:Vector2;

    public function new(scale:Float) {
        super();

        var coffee = Assets.getBitmapData('assets/coffee.png', true);
        var assetScale = Math.min(scale / coffee.width, scale / coffee.height);

        graphics.beginBitmapFill(coffee, new Matrix(assetScale, 0, 0, assetScale, 0, 0), false, true);
        graphics.drawRect(0, 0, scale, scale);
        graphics.endFill();
    }
}
