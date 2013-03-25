/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:48
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.control.ai {
import core.utils.MathUtil;

import flash.geom.Point;

import sqballs.behaviors.control.ControlBehavior;

public class AIControlBehavior extends ControlBehavior{

    private var _run:Boolean;
    private var _turnLeft:Boolean;
    private var _turnRight:Boolean;

    public function AIControlBehavior() {
        super();
    }

    override public function stop():void{
        super.stop();
        _run = _turnLeft = _turnRight = false;
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        _run = true;
        resolveGeneralRoute();
    }

    // resolve main route as it`s kinematic
    private function resolveGeneralRoute():void {
//        var directionToRotate:Point = WaypointManager.instance.getActualDirection(_controller.object);
//        if(!directionToRotate)
//            return;
//
//        var curRotationVector:Point = MathUtil.vectorFromAngle(_controller.object.rotation);
//        var angleDiff:Number = MathUtil.getAngleBetween(directionToRotate, curRotationVector);
//        if(Math.abs(angleDiff) > 0.06){
//            _turnLeft = angleDiff > 0;
//            _turnRight = angleDiff < 0;
//        } else{
//            _turnLeft = _turnRight = false;
//        }
    }

    override public function get turnLeft():Boolean{
        return _turnLeft;
    }

    override public function get turnRight():Boolean{
        return _turnRight;
    }

    override public function get run():Boolean{
        return _run;
    }

}
}
