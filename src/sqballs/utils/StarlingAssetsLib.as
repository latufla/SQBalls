/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 30.12.12
 * Time: 15:23
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {
import core.view.ViewBase;

import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class StarlingAssetsLib {

    public static const RAT_IDLE:String = "ratIdle";
    public static const RAT_MOVE_ACC:String = "ratMoveAcc";
    public static const RAT_MOVE_RUN:String = "ratMoveRun";

//    [Embed(source="../../../assets/ratIdle.xml", mimeType="application/octet-stream")]
//    private const RatIdleXml:Class;
//
//    [Embed(source="../../../assets/ratIdle.png")]
//    private const RatIdleTexture:Class;
//
//    [Embed(source="../../../assets/ratMoveAcc.xml", mimeType="application/octet-stream")]
//    private const RatMoveAccXml:Class;
//
//    [Embed(source="../../../assets/ratMoveAcc.png")]
//    private const RatMoveAccTexture:Class;
//
//    [Embed(source="../../../assets/ratMoveRun.xml", mimeType="application/octet-stream")]
//    private const RatMoveRunXml:Class;
//
//    [Embed(source="../../../assets/ratMoveRun.png")]
//    private const RatMoveRunTexture:Class;

    public static const RAT:String = "rat";
//    [Embed(source="../../../assets/rat.png")]
//    private const RatViewClass:Class

    public static const LEVEL_1:String = "level1";
//    [Embed(source="../../../assets/levels/1/level_1.jpg")]
//    private const Level1ViewClass:Class

    private var _assets:Array/* of MovieClip`s */;

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
            trace("AssetsLib -> getAssetBy(): no asset with name: " + name);
        }

        return asset;
    }

    private function init():void {
        _assets = [];

//        _assets[RAT] = RatViewClass;
//        _assets[LEVEL_1] = Level1ViewClass;
    }

    private function createSpriteFrom(bitmapClass:Class):Sprite{
        var sp:Sprite = new Sprite();
        sp.addChild(Image.fromBitmap(new bitmapClass));
        return sp;
    }

}
}
