/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 20.02.13
 * Time: 13:14
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors {
import core.behaviors.BehaviorBase;

public class StatDisplayBehavior extends BehaviorBase{
    public function StatDisplayBehavior() {
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

//        Config.ammunitionPanel.data = (_controller.object as SQObjectBase).ammunition;
    }
}
}
