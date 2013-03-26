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

public class BallAbsorbBehavior extends BehaviorBase{
    public function BallAbsorbBehavior() {
        super();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);
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

    }

}
}
