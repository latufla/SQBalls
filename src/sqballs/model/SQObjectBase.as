/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 13:36
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.controller.ControllerBase;
import core.model.ObjectBase;
import core.utils.nape.CustomMaterial;
import core.utils.nape.CustomShape;

import flash.geom.Point;

import sqballs.utils.Config;
import sqballs.utils.StarlingAssetsLib;

public class SQObjectBase extends ObjectBase {

    protected var _pivotX:int = 50;
    protected var _pivotY:int = 50;

    public function SQObjectBase() {
        super();
    }

    public static function create(libDesc:String, pos:Point, shapes:Vector.<CustomShape>, material:CustomMaterial, interactionGroup:int):SQObjectBase{
        var obj:SQObjectBase = new SQObjectBase();
        obj.libDesc = libDesc;
        obj.shapes = shapes;
        obj.material = material;
        obj.position = pos;
        obj.interactionGroup = interactionGroup;

        return obj;
    }

    override public function createAsset():*{
        return StarlingAssetsLib.instance.getAssetBy(_libDesc);
    }

    override public function get controller():ControllerBase{
        return Config.fieldController.getControllerByObject(this);
    }

    public function get pivotX():int {
        return _pivotX;
    }

    public function set pivotX(value:int):void {
        _pivotX = value;
    }

    public function get pivotY():int {
        return _pivotY;
    }

    public function set pivotY(value:int):void {
        _pivotY = value;
    }
}
}
