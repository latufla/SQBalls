/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 13:44
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {
import flash.display.DisplayObjectContainer;

public class AssetsLib {

//    public static const RESULT_ITEM:String = "resultItem";
//    [Embed(source="../../../assets/gui/GUI_0_1_a.swf", symbol="ResultItemView")]
//    private const ResultItem:Class;

    private var _assets:Array/* String -> MovieClip`s */;

    private static var _instance:AssetsLib;
    public function AssetsLib() {
        init();
    }

    public static function get instance():AssetsLib{
        _instance ||= new AssetsLib();
        return _instance;
    }

    private function init():void {
        _assets = [];
//        _assets[RESULT_VIEW] = ResultItem;
    }

    public function getAssetClassBy(name:String):Class{
        var asset:Class;
        try{
            asset = _assets[name];
        } catch (e:Error){
            trace("AssetsLib -> getAssetBy(): no asset class with name: " + name);
        }

        return asset;
    }

    public function createAssetBy(className:String):DisplayObjectContainer{
        var asset:Class = getAssetClassBy(className);
        return new asset() as DisplayObjectContainer;
    }
}
}
