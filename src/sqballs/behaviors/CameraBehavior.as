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

import sqballs.controller.SQFieldController;

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
        var playerRatC:ControllerBase = c.playerBallController;
        if(!playerRatC)
            return;

//        var pos:Point = playerRatC.object.position;
//        var debugView:DisplayObject = Config.sceneController.view;
//        if(debugView){
//            debugView.x = Config.stage.stageWidth / 2 - pos.x;
//            debugView.y = Config.stage.stageHeight / 2 - pos.y;
//        }
//
//        var releaseView:ViewBase = Config.fieldController.view;
//        if(releaseView){
//            releaseView.x = Config.stage.stageWidth / 2 - pos.x;
//            releaseView.y = Config.stage.stageHeight / 2 - pos.y;
//        }
    }

}
}
