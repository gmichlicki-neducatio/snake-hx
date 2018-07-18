package pl.nedu.snake.display;

import openfl.display.Sprite;

class Board extends Sprite {
    private var cellSize:Float;

    public function new(width:Int, height:Int, cellSize:Float = 20) {
        super();

        this.cellSize = cellSize;

        graphics.lineStyle(1, 0x000000, .5, true);

        for (y in 0...height + 1) {
            graphics.moveTo(0, y * cellSize);
            graphics.lineTo(width * cellSize, y * cellSize);
        }

        for (x in 0...width + 1) {
            graphics.moveTo(x * cellSize, 0);
            graphics.lineTo(x * cellSize, height * cellSize);
        }
    }
}
