package;

import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.ui.Multitouch;
import openfl.ui.MultitouchInputMode;
import pl.nedu.snake.Direction;
import pl.nedu.snake.Game;

class Main extends Sprite {
    public var game:Game;

    private var lastTouchX:Float;
    private var lastTouchY:Float;

    public function new() {
        super();

        game = cast addChild(new Game());

        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        if(Multitouch.supportsTouchEvents) {
            stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
            stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);

            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
        }
    }

    private function onTouchBegin(e:TouchEvent):Void {
        lastTouchX = e.stageX;
        lastTouchY = e.stageY;
    }

    private function onTouchEnd(e:TouchEvent):Void {
        var xDist = e.stageX - lastTouchX;
        var yDist = e.stageY - lastTouchY;

        var newDirection:Direction = if(Math.abs(xDist) > Math.abs(yDist)) {
            xDist > 0 ? Right : Left;
        } else {
            yDist > 0 ? Down : Up;
        }

        game.move(newDirection);
    }

    private function keyDownHandler(e:KeyboardEvent) {
        var newDirection:Direction = switch(e.keyCode) {
            case 37: Left;
            case 38: Up;
            case 39: Right;
            case 40: Down;
            default: null;
        }

        if(newDirection != null) game.move(newDirection);
    }

    private function destroy():Void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        stage.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
        stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
    }
}
