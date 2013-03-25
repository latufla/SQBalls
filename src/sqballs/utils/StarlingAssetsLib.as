/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 30.12.12
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;

public class StarlingAssetsLib {

    public static const BALL:String = "ball";
    [Embed(source="../../../assets/ball.png")]
    private const BallViewClass:Class

    public static const LEVEL_1:String = "level1";
    [Embed(source="../../../assets/levels/1/level.jpg")]
    private const Level1ViewClass:Class

    private var _assets:Array/* String -> Class */;

    private static var _instance:StarlingAssetsLib;

    public function StarlingAssetsLib() {
        init();
    }

    public static function get instance():StarlingAssetsLib {
        if(!_instance)
            _instance = new StarlingAssetsLib();

        return _instance;
    }

    public function getAssetBy(name:String):DisplayObject{
        var asset:DisplayObject;
        try{
            asset = createSpriteFrom(_assets[name]);
        } catch (e:Error){
            trace("StarlingAssetsLib -> getAssetBy(): no asset with name: " + name);
        }

        return asset;
    }

    private function init():void {
        _assets = [];

        _assets[BALL] = BallViewClass;
        _assets[LEVEL_1] = Level1ViewClass;
    }

    private function createSpriteFrom(bitmapClass:Class):Sprite{
        var sp:Sprite = new Sprite();
        sp.addChild(Image.fromBitmap(new bitmapClass));
        return sp;
    }

}
}
