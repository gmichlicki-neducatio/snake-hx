package pl.nedu.snake.display;

import openfl.geom.Matrix;
import openfl.Assets;
import openfl.display.Sprite;

class SnakeHead extends Sprite {
    public function new(scale:Float) {
        super();

        var antek = Assets.getBitmapData('assets/antek.png', true);
        var assetScale = Math.min(scale / antek.width, scale / antek.height);

        graphics.beginBitmapFill(antek, new Matrix(assetScale, 0, 0, assetScale, 0, 0), false, true);
        graphics.drawRect(0, 0, scale, scale);
        graphics.endFill();
    }
}
