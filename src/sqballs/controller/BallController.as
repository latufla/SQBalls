/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 18:59
 * To change this template use File | Settings | File Templates.
 */
package sqballs.controller {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.model.ObjectBase;

import flash.geom.Point;

import sqballs.model.Ball;

public class BallController extends ControllerBase{

    public function BallController() {
        super();
    }

    public static function create(obj:ObjectBase, behaviors:Vector.<BehaviorBase> = null):BallController{
        var c:BallController = new BallController();
        c.object = obj;
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }

        return c;
    }

    override protected function align():void {
        var obj:Ball = _object as Ball;
        _view.pivotX = obj.pivotX;
        _view.pivotY = obj.pivotY;

        _view.width = obj.rectSize.width;
        _view.height = obj.rectSize.height;

        var pos:Point = _object.position;
        _view.x = pos.x;
        _view.y = pos.y;

        _view.rotation = _object.rotation;
    }
}
}
