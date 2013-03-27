/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 27.03.13
 * Time: 22:01
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors.gameplay {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.utils.EventHeap;

import sqballs.controller.BallController;

import sqballs.controller.SQFieldController;
import sqballs.event.GameEvent;
import sqballs.model.Ball;


public class GameResultResolveBehavior extends BehaviorBase{
    public static const VICTORY:String = "victory";
    public static const DEFEAT:String = "defeat";

    public function GameResultResolveBehavior() {
        super();
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);

        var fieldC:SQFieldController = _controller as SQFieldController;
        if(!fieldC)
            return;

        // no user ball - defeat
        var playerBallC:BallController = fieldC.playerBallController;
        if(!playerBallC){
            applyBrawlResult(DEFEAT);
            return;
        }

        // only user ball - victory
        var ballCs:Vector.<ControllerBase> = fieldC.getControllersByClass(BallController);

        if(ballCs.length == 1 && ballCs[0] == playerBallC){
            applyBrawlResult(VICTORY);
            return;
        }

        var playerB:Ball = playerBallC.object as Ball;
        var pBArea:int = playerB.area; // easy for comparision

        var smallerBallsCs:Vector.<ControllerBase> = ballCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return int((e.object as Ball).area) <= pBArea;
        });

         // if there is no balls with smaller or equal areas
        // 1 for player ball
        if(smallerBallsCs.length <= 1){
            applyBrawlResult(DEFEAT);
            return;
        }

        var biggerOppsCs:Vector.<ControllerBase> = ballCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return int((e.object as Ball).area) > pBArea;
        });

        // no bigger balls
        if(biggerOppsCs.length == 0)
            applyBrawlResult(VICTORY);
    }

    private function applyBrawlResult(result:String):void {
        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_BRAWL_RESULT, {result:result}));
    }
}
}
