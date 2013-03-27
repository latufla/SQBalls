/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 16.01.13
 * Time: 19:39
 * To change this template use File | Settings | File Templates.
 */
package sqballs.controller {

import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.controller.FieldController;
import core.utils.nape.CustomMaterial;

import flash.geom.Point;

import sqballs.behaviors.control.user.UserControlBehavior;
import sqballs.behaviors.gameplay.BallAbsorbBehavior;
import sqballs.behaviors.gameplay.BallMoveBehavior;
import sqballs.model.Ball;
import sqballs.model.Field;
import sqballs.model.info.BotInfo;
import sqballs.model.info.UserInfo;
import sqballs.utils.Config;
import sqballs.utils.StarlingAssetsLib;

public class SQFieldController extends FieldController{

    public function SQFieldController(field:Field) {
        _object = field;
        super();
    }

    override protected function init():void {
        super.init();

        Config.fieldController = this;
        add(this);

        createItems(field);
        createBalls(field);
    }

    override public function doStep(step:Number, debugView:* = null):void{
        super.doStep(step, debugView);

        if(!field.raceIsFinished)
            field.updateRaceProgress();
    }

    public function get playerBallController():ControllerBase{
        return getBallControllerByUserInfo(field.player);
    }

    public function getBallControllerByUserInfo(p:UserInfo):ControllerBase{
        var ratCs:Vector.<ControllerBase> = getControllersByClass(BallController);
        var res:Vector.<ControllerBase> = ratCs.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return e.object.name == p.name;
        });

        if(res.length > 0)
            return res[0];

        return null;
    }


    private function get field():Field{
        return _object as Field;
    }

    private function createBalls(f:Field):void {
        var user:UserInfo;
        var ball:Ball;
        var bhs:Vector.<BehaviorBase>;
        var n:uint = f.racers.length;
        for(var i:uint = 0; i < 4; i++){
            ball = Ball.create(StarlingAssetsLib.BALL, new Point(150 + i * 180, 250), new CustomMaterial(), 1);
            ball.radius = 50;
            user = f.racers[i];
            ball.name = user.name;

            if(user is BotInfo)
                bhs = new <BehaviorBase>[new BallMoveBehavior()];
            else
                bhs = new <BehaviorBase>[new UserControlBehavior(), new BallMoveBehavior(), new BallAbsorbBehavior()];

            add(BallController.create(ball, bhs));
        }
    }

    private function createItems(f:Field):void {
//        var medkit:SQObjectBase = SQObjectBase.create("", new Point(650, 250), new <CustomShape>[new CustomPolygon(0, 0, 30, 30)], new CustomMaterial(), 1);
//        medkit.ammunition.health = 35;
//
//        var medkitController:ControllerBase = ControllerBase.create(medkit, new <BehaviorBase>[new MedkitItemBehavior()]);
//        add(medkitController);
//
//        var medkit2:ObjectBase = ObjectBase.create(new Point(130, 500), new <RShape>[new RPolygon(0, 0, 30, 30)], rMaterial, params["other"]["group"]);
//        medkit2.ammunition.health = 35;
//
//        var medkitController2:ControllerBase = ControllerBase.create(medkit2, new <BehaviorBase>[new MedkitItemBehavior()]);
//        _field.add(medkitController2);
//
//        var trap:ObjectBase = ObjectBase.create(new Point(660, 70), new <RShape>[new RPolygon(0, 0, 20, 20)], rMaterial, params["other"]["group"]);
//        trap.ammunition.health = 120;
//
//        var trapController:ControllerBase = ControllerBase.create(trap, new <BehaviorBase>[new TrapItemBehavior()]);
//        _field.add(trapController);
//
//        var trap2:ObjectBase = ObjectBase.create(new Point(70, 70), new <RShape>[new RPolygon(0, 0, 20, 20)], rMaterial, params["other"]["group"]);
//        trap2.ammunition.health = 120;
//
//        var trapController2:ControllerBase = ControllerBase.create(trap2, new <BehaviorBase>[new TrapItemBehavior()]);
//        _field.add(trapController2);
//
//        var trap3:ObjectBase = ObjectBase.create(new Point(400, 70), new <RShape>[new RPolygon(0, 0, 20, 20)], rMaterial, params["other"]["group"]);
//        trap3.ammunition.health = 120;
//
//        var trapController3:ControllerBase = ControllerBase.create(trap3, new <BehaviorBase>[new TrapItemBehavior()]);
//        _field.add(trapController3);
//
//        var trap4:ObjectBase = ObjectBase.create(new Point(70, 300), new <RShape>[new RPolygon(0, 0, 20, 20)], rMaterial, params["other"]["group"]);
//        trap4.ammunition.health = 120;
//
//        var trapController4:ControllerBase = ControllerBase.create(trap4, new <BehaviorBase>[new TrapItemBehavior()]);
//        _field.add(trapController4);
//
//        var trap5:ObjectBase = ObjectBase.create(new Point(400, 650), new <RShape>[new RPolygon(0, 0, 20, 20)], rMaterial, params["other"]["group"]);
//        trap5.ammunition.health = 120;
//
//        var trapController5:ControllerBase = ControllerBase.create(trap5, new <BehaviorBase>[new TrapItemBehavior()]);
//        _field.add(trapController5);
    }
}
}
