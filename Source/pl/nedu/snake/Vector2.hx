package pl.nedu.snake;

typedef Vector2Type = { x:Int, y:Int };

@:forward(x, y)
abstract Vector2(Vector2Type) {
    inline public function new(x = 0, y = 0) {
        this = {x: x, y: y};
    }

    @:op(A + B)
    inline public static function add(lhs:Vector2, rhs:Vector2):Vector2 {
        return new Vector2(lhs.x + rhs.x, lhs.y + rhs.y);
    }

    @:op(A == B)
    inline public function isEqual(rhs:Vector2) {
        return this.x == rhs.x && this.y == rhs.y;
    }

    @:op(A != B)
    inline public function isNotEqual(rhs:Vector2) {
        return !isEqual(rhs);
    }

    @:op(-A)
    inline public function negative() {
        return new Vector2(-this.x, -this.y);
    }
}
