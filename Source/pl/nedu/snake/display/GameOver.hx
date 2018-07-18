package pl.nedu.snake.display;

import openfl.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.events.MouseEvent;
import openfl.events.Event;
import flash.text.TextField;
import openfl.display.Sprite;

class GameOver extends Sprite {
    public var tileSize:Float;

    public function new(tileSize:Float) {
        super();

        this.tileSize = tileSize;

        addEventListener(Event.ADDED_TO_STAGE, init);
    }

    private function init(_):Void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        graphics.beginFill(0xffffff, 0.9);
        graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
        graphics.endFill();

        var textFormat:TextFormat = new TextFormat();
        textFormat.font = 'Arial';
        textFormat.size = cast Math.round(tileSize);

        var textfield:TextField = cast addChild(new TextField());
        textfield.defaultTextFormat = textFormat;
        textfield.autoSize = TextFieldAutoSize.CENTER;
        textfield.text = 'GAME OVER';
        textfield.embedFonts = true;
        textfield.x = (stage.stageWidth - textfield.width) / 2;
        textfield.y = stage.stageHeight / 2 - textfield.height;

        var button:Sprite = cast addChild(new Sprite());

        var textfield2:TextField = new TextField();
        textfield2.defaultTextFormat = textFormat;
        textfield2.autoSize = TextFieldAutoSize.LEFT;
        textfield2.text = 'RETRY';
        textfield2.embedFonts = true;
        textfield2.x = 0;
        textfield2.y = 0;

        button.addChild(textfield2);

        button.buttonMode = true;
        button.useHandCursor = true;
        button.x = (stage.stageWidth - button.width) / 2;
        button.y = stage.stageHeight / 2 + button.height;

        var padding = button.width * 0.1;
        button.graphics.beginFill(0, 0.2);
        button.graphics.drawRect(-padding, -padding, button.width + 2 * padding, button.height + 2 * padding);
        button.graphics.endFill();

        button.addEventListener(MouseEvent.CLICK, restart);

    }

    private function restart(_):Void {
        dispatchEvent(new Event('restart'));
    }
}
