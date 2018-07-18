package pl.nedu.snake;

@:forward(length)
abstract SnakeData(Array<Vector2>) {
    public var head(get, never):Vector2;

    inline public function new(size:Int, x:Int, y:Int, direction:Vector2) {
        this = [new Vector2(x, y)];

        for (i in 0...size - 1) {
            move(direction, true);
        }
    }

    inline function get_head():Vector2 {
        return this[0];
    }

    @:arrayAccess
    inline public function get(index):Vector2 {
        return this[index];
    }

    public function move(direction:Vector2, addPart:Bool = false):Vector2 {
        var head:Vector2 = this[0];
        var newPart:Vector2 = head + direction;

        this.unshift(newPart);

        if(!addPart) {
            this.pop();
        }

        return newPart;
    }

    public function checkCollision(position:Vector2, startFrom:Int = 0):Bool {
        for(i in startFrom...this.length) {
            var part = this[i];
            if(part == position) {
                return true;
            }
        }

        return false;
    }
}
