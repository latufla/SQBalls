/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:48
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.control.ai {
import core.controller.ControllerBase;
import core.utils.VectorUtil;

import flash.geom.Point;

import sqballs.behaviors.control.ControlBehavior;
import sqballs.controller.BallController;
import sqballs.model.Ball;
import sqballs.utils.Config;

public class AIControlBehavior extends ControlBehavior{
    private static const DEFAULT_MAGNITUDE:int = 1;

    private var _moveFrom:Point;
    private var _magnitude:int;

    public function AIControlBehavior() {
        super();
    }

    override public function stop():void{
        super.stop();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        var b:Ball = _controller.object as Ball;
        if(b)
            resolveGeneralRoute(b);
    }

    private function resolveGeneralRoute(b:Ball):void {
        var enemyCs:Vector.<ControllerBase> = Config.fieldController.getControllersByClass(BallController);
        VectorUtil.removeElement(enemyCs, _controller);

        var avoidFrom:Point = resolveAvoidBehavior(b, enemyCs);
        var aspireFrom:Point = resolveAspireBehavior(b, enemyCs);

        if(avoidFrom && !aspireFrom) {
            _moveFrom = avoidFrom;
        }else if(!avoidFrom && aspireFrom){
            _moveFrom = aspireFrom;
        } else if(avoidFrom && aspireFrom){
            _moveFrom = avoidFrom.add(aspireFrom);
        }
    }

    private function resolveAspireBehavior(b:Ball, enemyCs:Vector.<ControllerBase>):Point {
        var bArea:int = b.area;
        var allSmallerBallCs:Vector.<ControllerBase> = enemyCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return (e.object as Ball).area <= bArea;
        });

        if(allSmallerBallCs.length > 0){
            var bPos:Point = b.position;
            _magnitude = DEFAULT_MAGNITUDE;
            return bPos.add(bPos.subtract(allSmallerBallCs[0].object.position));
        }

        _magnitude = 0;
        return null;
    }

    private function resolveAvoidBehavior(b:Ball, enemyCs:Vector.<ControllerBase>):Point {
        var enemyCs:Vector.<ControllerBase> = Config.fieldController.getControllersByClass(BallController);
        VectorUtil.removeElement(enemyCs, _controller);

        var bArea:int = b.area;
        var allInRadiusAndBigger:Vector.<ControllerBase> = enemyCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            var b2:Ball = e.object as Ball;
            return b.isInDefenceRadius(b2) && (b2).area > bArea;
        });

        // run from random bigger ball
        if(allInRadiusAndBigger.length > 0){
            _magnitude = DEFAULT_MAGNITUDE;
            return allInRadiusAndBigger[0].object.position;
        }

        _magnitude = 0;
        return null;
    }

    override public function get moveFrom():Point {
        return _moveFrom;
    }

    override public function get magnitude():int {
        return _magnitude;
    }

}
}
