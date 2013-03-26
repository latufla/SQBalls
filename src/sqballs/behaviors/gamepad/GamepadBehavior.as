/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 17:48
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gamepad {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;

import flash.geom.Point;

import sqballs.utils.Config;

import starling.events.Touch;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

public class GamepadBehavior extends BehaviorBase{
    // default keys
    private static const TOUCH:String = "touch";


    private var _touchForce:int;
    private var _activeKeys:Array;

    public function GamepadBehavior() {
        super();
        init();
    }

    private function init():void {
        _activeKeys = [];
        _activeKeys[TOUCH] = [false];
    }

    override public function start(c:ControllerBase):void{
        super.start(c);

        Config.mainScene.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(e:TouchEvent):void {
        var touch:Touch = e.getTouch(Config.mainScene);

        if(touch.phase == TouchPhase.BEGAN || touch.phase == TouchPhase.MOVED){
            _activeKeys[TOUCH] = [true, {x: touch.globalX, y: touch.globalY, touchForce: ++_touchForce}];
        }
        else if(touch.phase == TouchPhase.ENDED){
            _activeKeys[TOUCH] = [false];
            _touchForce = 0;
        }
    }

    override public function stop():void{
        super.stop();

        _activeKeys[TOUCH] = [false];
        Config.mainScene.removeEventListener(TouchEvent.TOUCH, onTouch);
    }

    public function get touched():Boolean{
        return _activeKeys[TOUCH] && _activeKeys[TOUCH][0];
    }

    public function get touchInfo():Object{
        if(touched)
            return _activeKeys[TOUCH][1];

        return null;
    }
}
}
