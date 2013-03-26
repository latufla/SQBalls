/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 13.01.13
 * Time: 12:45
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.control {
import core.behaviors.BehaviorBase;

import flash.geom.Point;

public class ControlBehavior extends BehaviorBase {
    public function ControlBehavior() {
    }

    public function get moveTo():Point{
        return null;
    }

    public function get forceK():int{
        return 0;
    }
}
}
