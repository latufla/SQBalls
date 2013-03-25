/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 14:50
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model {
import core.controller.ControllerBase;
import core.model.ObjectBase;
import core.utils.EventHeap;
import core.utils.VectorUtil;
import core.utils.nape.PhysEngineConnector;

import flash.display.BitmapData;

import sqballs.event.GameEvent;
import sqballs.model.info.BotInfo;
import sqballs.model.info.UserInfo;
import sqballs.utils.Config;

public class Field extends SQObjectBase{

    private var _laps:uint = 1;

    private var _border:BitmapData;

    private var _racers:Vector.<UserInfo>;

    private var _runners:Vector.<UserInfo>;
    private var _finishers:Vector.<UserInfo>;

    public function Field(border:BitmapData, racers:Vector.<UserInfo>) {
        _border = border;

        _racers = racers;
        _runners = _racers.concat();
        _finishers = new Vector.<UserInfo>();

        super();
    }

    override protected function init():void{
        PhysEngineConnector.instance.createBorders(this, _border);
    }

    public function updateRaceProgress():void{
//        if(raceIsFinished)
//            return;
//
//        for each(var p:ControllerBase in Config.fieldController.ratControllers) {
//            var racerObj:ObjectBase = p.object;
//            var racerInfo:UserInfo = getRacerByName(racerObj.name);
//
//            if(_runners.indexOf(racerInfo) != -1 && racerInfo.currentLap >= _laps){
//                VectorUtil.removeElement(_runners, racerInfo);
//                _finishers.push(racerInfo);
//            } else{
//                racerInfo.distanceToFinish = WaypointManager.instance.getSmartDistanceToFinishLine(racerObj);
//            }
//        }
//        _runners.sort(sortOnDistanceToFinish);
//
//        if(raceIsFinished)
//            EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_RACE_RESULT,{raceInfo:this}));
    }

    public function get racers():Vector.<UserInfo> {
        return _racers;
    }

    public function get player():UserInfo{
        var res:Vector.<UserInfo> = _racers.filter(function (e:UserInfo, i:int, v:Vector.<UserInfo>):Boolean{
            return !(e is BotInfo);
        });

        if(res.length > 0)
            return res[0];

        return null;
    }

    public function getRacerPlace(r:UserInfo):int {
        var fId:int = _finishers.indexOf(r);
        if(fId != -1)
            return fId + 1;

        var fCount:uint = _finishers.length;
        return fCount + _runners.indexOf(r) + 1;
    }

    public function getRacerPoints(r:UserInfo):int {
        var place:int = _finishers.indexOf(r);
        if(place == -1)
            return 0;

        return Config.pointsForPlacePlanet1[place];
    }

    public function get border():BitmapData {
        return _border;
    }

    public function getRacerByName(name:String):UserInfo{
        var res:Vector.<UserInfo> = _racers.filter(function (e:UserInfo, i:int, v:Vector.<UserInfo>):Boolean{
            return e.name == name;
        });
        return res[0];
    }

    public function get laps():uint {
        return _laps;
    }

    public function get finishers():Vector.<UserInfo> {
        return _finishers;
    }


    public function get raceIsFinished():Boolean{
        return _runners.length == 0;
    }
}
}
