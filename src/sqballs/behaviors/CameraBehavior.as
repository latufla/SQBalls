/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 15:21
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.view.ViewBase;

import flash.display.DisplayObject;
import flash.geom.Point;

import sqballs.SQBalls;
import sqballs.controller.SQFieldController;
import sqballs.utils.Config;

public class CameraBehavior extends BehaviorBase{
    public function CameraBehavior() {
        super();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        if(_controller)
            applyFocus(_controller as SQFieldController);
    }

    private function applyFocus(c:SQFieldController):void {
        var playerRatC:ControllerBase = c.playerRatController;
        if(!playerRatC)
            return;

//        var pos:Point = playerRatC.object.position;
//        var debugView:DisplayObject = Config.sceneController.view;
//        if(debugView){
//            debugView.x = SQBalls.STAGE.stageWidth / 2 - pos.x;
//            debugView.y = SQBalls.STAGE.stageHeight / 2 - pos.y;
//        }
//
//        var releaseView:ViewBase = Config.fieldController.view;
//        if(releaseView){
//            releaseView.x = SQBalls.STAGE.stageWidth / 2 - pos.x;
//            releaseView.y = SQBalls.STAGE.stageHeight / 2 - pos.y;
//        }
    }

}
}
