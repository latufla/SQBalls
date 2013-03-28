/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 17:32
 * To change this template use File | Settings | File Templates.
 */
package core.view {
import core.utils.DisplayObjectUtil;

import starling.display.DisplayObject;
import starling.display.Sprite;

public class ViewBase extends Sprite{

    private var _asset:*;
    public function ViewBase() {
        super();
    }

    public function get asset():* {
        return _asset;
    }

    public function set asset(value:*):void {
        _asset = value;
    }

    public function draw():void{
        DisplayObjectUtil.removeAll(this);

        if(_asset is DisplayObject)
            addChild(_asset);
    }
}
}
