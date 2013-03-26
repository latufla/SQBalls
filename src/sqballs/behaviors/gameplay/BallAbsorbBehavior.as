/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 26.03.13
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.model.ObjectBase;

import sqballs.controller.BallController;

import sqballs.controller.SQFieldController;
import sqballs.model.Ball;

import sqballs.model.SQObjectBase;
import sqballs.utils.Config;

public class BallAbsorbBehavior extends BehaviorBase{
    public function BallAbsorbBehavior() {
        super();
    }

    private var cnt:int = 50;
    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        var obj:SQObjectBase = _controller.object as SQObjectBase;
    }


    override public function start(c:ControllerBase):void{
        super.start(c);

        _controller.object.addInteractionListeners(onBeginInteraction);
    }

    override public function stop():void{
        _controller.object.addInteractionListeners(onBeginInteraction);

        super.stop();
    }


    override protected function onBeginInteraction(obj1:ObjectBase, obj2:ObjectBase):void{
        var b1:Ball = obj1 as Ball;
        var b2:Ball = obj2 as Ball;
        trace(b1, b2);

        if(!shouldAbsorb(b1,  b2))
            return;

        b1.area = b1.area + b2.area;

        var c:ControllerBase = Config.fieldController.getControllerByObject(obj2);
        if(c)
            Config.fieldController.remove(c);
    }

    private function shouldAbsorb(b1:Ball, b2:Ball):Boolean{
        var playerBallC:BallController = (Config.fieldController as SQFieldController).playerBallController as BallController;
        var playerBall:Ball = playerBallC ? playerBallC.object as Ball : null;

        return b1 && b2 && ((b1.area > b2.area) || ((b1.area == b2.area) && playerBall && (b1 == playerBall)));
    }

}
}
