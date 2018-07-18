package pl.nedu.snake;

import pl.nedu.snake.display.GameOver;
import haxe.Timer;
import openfl.display.Sprite;
import openfl.events.Event;
import pl.nedu.snake.display.Board;
import pl.nedu.snake.display.Bonus;
import pl.nedu.snake.display.Snake;
import pl.nedu.snake.Vector2;

class Game extends Sprite {
    public var timer:Timer;
    public var board:Board;
    public var snakeData:SnakeData;
    public var snake:Snake;
    public var direction:Vector2;
    public var nextDirection:Vector2 = new Vector2(0, -1);
    public var bonus:Bonus;
    public var gameOver:GameOver;

    public var tileSize:Float;
    public var BOARD_WIDTH:Int = 11;
    public var BOARD_HEIGHT:Int = 11;
    public var SNAKE_SIZE:Int = 3;

    public function new() {
        super();

        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(_):Void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        tileSize = Math.min(stage.stageWidth / BOARD_WIDTH, stage.stageHeight / BOARD_HEIGHT);
        board = cast addChild(new Board(BOARD_WIDTH, BOARD_HEIGHT, tileSize));
        if(stage.stageWidth / BOARD_WIDTH > stage.stageHeight / BOARD_HEIGHT) {
            board.x = (stage.stageWidth - tileSize * BOARD_WIDTH) / 2;
        } else {
            board.y = (stage.stageHeight - tileSize * BOARD_HEIGHT) / 2;
        }

        snake = cast board.addChild(new Snake(tileSize));
        bonus = cast board.addChild(new Bonus(tileSize));

        gameOver = cast addChild(new GameOver(tileSize));
        gameOver.addEventListener('restart', restart);

        restart();
    }

    private function restart(_ = null):Void {
        direction = new Vector2(0, -1);
        nextDirection = new Vector2(0, -1);
        snakeData = new SnakeData(SNAKE_SIZE, Math.floor(BOARD_WIDTH / 2), Math.floor(BOARD_HEIGHT / 2) + SNAKE_SIZE - 1, direction);
        snake.draw(snakeData);
        drawBonus();

        gameOver.visible = false;
        gameOver.mouseEnabled = false;
        gameOver.mouseChildren = false;

        timer = new Timer(200);
        timer.run = update;
    }

    public function resize() {
        // TODO
    }

    private function update() {
        direction = nextDirection;
        var bonusTaken:Bool = (snakeData.head + direction) == bonus.position;
        var head = snakeData.move(direction, bonusTaken);
        if (bonusTaken) {
            drawBonus();
        }

        snake.draw(snakeData);

        if (snakeData.checkCollision(head, 1) || head.x < 0 || head.x >= BOARD_WIDTH || head.y < 0 || head.y >= BOARD_HEIGHT) {
            timer.stop();
            gameOver.visible = true;
            gameOver.mouseEnabled = true;
            gameOver.mouseChildren = true;
        }
    }

    public function move(newDirection:Direction) {
        var directionVector = switch(newDirection) {
            case Left: new Vector2(-1, 0);
            case Up: new Vector2(0, -1);
            case Right: new Vector2(1, 0);
            case Down: new Vector2(0, 1);
        }

        if (direction != directionVector && direction != -directionVector) {
            nextDirection = directionVector;
        }
    }

    private function drawBonus():Void {
        do {
            bonus.position = new Vector2(Math.floor(Math.random() * BOARD_WIDTH), Math.floor(Math.random() * BOARD_HEIGHT));
        }
        while (snakeData.checkCollision(bonus.position, 0));

        bonus.x = bonus.position.x * tileSize;
        bonus.y = bonus.position.y * tileSize;
    }
}
