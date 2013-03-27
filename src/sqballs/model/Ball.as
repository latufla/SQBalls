/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 26.03.13
 * Time: 16:07
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.utils.nape.CustomCircle;
import core.utils.nape.CustomMaterial;
import core.utils.nape.CustomShape;
import core.utils.nape.PhysEngineConnector;

import flash.geom.Point;
import flash.geom.Rectangle;

public class Ball extends SQObjectBase{

    private static const DEFAULT_RADIUS:uint = 50;
    private static const DEFAULT_SHAPE:CustomCircle = new CustomCircle(DEFAULT_RADIUS);

    protected var _radius:uint = DEFAULT_RADIUS;
    protected var _color:uint = 0xFFFFFF;
    protected var _rectSize:Rectangle;

    public function Ball() {
        super();
        _rectSize = new Rectangle();
    }

    public static function create(libDesc:String, pos:Point, radius:int, material:CustomMaterial):Ball{
        var obj:Ball = new Ball();
        obj.libDesc = libDesc;
        obj.shapes = new <CustomShape>[DEFAULT_SHAPE];
        obj.material = material;
        obj.position = pos;
        obj.radius = radius;
        return obj;
    }

    public function get radius():uint {
        return _radius;
    }

    public function set radius(value:uint):void {
        _radius = value;
        _rectSize.width = _rectSize.height = _radius * 2;

        PhysEngineConnector.instance.resizeTopmostCircle(this, _radius);
    }

    public function get area():Number {
        return Math.PI * Math.pow(_radius, 2);
    }

    public function set area(value:Number):void {
        radius = Math.pow(value / Math.PI, .5);
    }

    public function get rectSize():Rectangle {
        return _rectSize;
    }

    public function get color():uint {
        return _color;
    }

    public function set color(value:uint):void {
        _color = value;
    }
}
}
