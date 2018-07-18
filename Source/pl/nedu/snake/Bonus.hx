package pl.nedu.snake;
enum Bonus {
    Coffee;
    Music;
    Icon(assetName:String);
}

enum Color {
    black;
    white;
    rgb(r:Int, g:Int, b:Int);
}

class Test {
    public function test(bonus:Bonus):Void {
        switch(bonus) {
            case Coffee: display('assets/coffee.png');
            case Music: display('assets/music.png');
            case Icon(assetName): display('custom-assets/'+assetName);

        }
    }

    public function display(assetPath:String):Void {

    }
}