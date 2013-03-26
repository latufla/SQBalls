/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 20:48
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.control.user {
import core.controller.ControllerBase;

import flash.geom.Point;

import sqballs.behaviors.control.ControlBehavior;
import sqballs.behaviors.gamepad.GamepadBehavior;

public class UserControlBehavior extends ControlBehavior{

    private var _gamepad:GamepadBehavior;

    public function UserControlBehavior() {
        init();
    }

    private function init():void {
        _gamepad = new GamepadBehavior();
    }

    override public function start(c:ControllerBase):void{
        super.start(c);
        _gamepad.start(c);
    }

    override public function stop():void{
        super.stop();
        _gamepad.stop();
    }

    override public function get moveTo():Point{
        if(!_gamepad.touched)
            return null;

        var pos:Point = new Point(_gamepad.touchInfo.x, _gamepad.touchInfo.y);
        return pos;
    }

    override public function get forceK():int{
        if(!_gamepad.touched)
            return 0;

        return _gamepad.touchInfo.touchForce;
    }
}
}
