package pl.nedu.snake.display;

import openfl.display.CapsStyle;
import openfl.display.LineScaleMode;
import openfl.display.Sprite;

class Snake extends Sprite {
    public var head:SnakeHead;
    public var scale:Float;

    public function new(scale:Float) {
        super();
        this.scale = scale;
    }

    public function draw(snake:SnakeData):Void {
        graphics.clear();

        var prevPart:Vector2 = snake.head;
        graphics.lineStyle(scale * .6, 0, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);

        graphics.moveTo((prevPart.x + .5) * scale, (prevPart.y + .5) * scale);
        for(i in 1...snake.length) {
            var nextPart:Vector2 = snake[i];
            var x = nextPart.x + .5;
            var y = nextPart.y + .5;
            prevPart = nextPart;
            graphics.lineTo(x * scale, y * scale);
        }

        prevPart = snake.head;

        if(head == null) head = cast addChild(new SnakeHead(scale));
        head.x = snake.head.x * scale;
        head.y = snake.head.y * scale;
    }
}
