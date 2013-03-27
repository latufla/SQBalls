/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 13:57
 * To change this template use File | Settings | File Templates.
 */
package sqballs {
import core.utils.DisplayObjectUtil;
import core.utils.EventHeap;

import flash.display.MovieClip;
import flash.events.EventDispatcher;
import flash.geom.Point;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

import nape.util.BitmapDebug;

import sqballs.controller.SQFieldController;
import sqballs.event.GameEvent;
import sqballs.model.Field;
import sqballs.model.info.GameInfo;
import sqballs.model.info.UserInfo;
import sqballs.utils.Config;
import sqballs.utils.RaceInfoLib;

import starling.events.EnterFrameEvent;

public class SceneController extends EventDispatcher{
    private var _gameEventHandlers:Dictionary; // sqballs.event type -> function

    private var _view:MovieClip;

    private var _field:SQFieldController;
    private var _fieldDebugView:BitmapDebug;

    public function SceneController() {
        init();
    }

    private function init():void {
        _view = new MovieClip();
        Config.stage.addChild(_view);

        addEventListeners();

        var player:UserInfo = UserInfo.create(0, "ball0", new Point(99, 90), 30);
        Config.gameInfo = new GameInfo(player);
        trace(Config.gameInfo);

        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_RACE));
        Config.sceneController = this;
    }

    private function addEventListeners():void {
        _gameEventHandlers = new Dictionary();
        _gameEventHandlers[GameEvent.NEED_RACE] = onNeedRace;
        _gameEventHandlers[GameEvent.NEED_RACE_RESULT] = onNeedRaceResult;

        for (var p:String in _gameEventHandlers){
            EventHeap.instance.register(p, onGameEvent);
        }
    }

    // all game events come here
    private function onGameEvent(e:GameEvent):void{
        var handler:Function = _gameEventHandlers[e.type];
        if(handler)
            handler(e.data);
    }

    private function onNeedRaceResult(data:*):void{
        Config.mainScene.removeEventListener(EnterFrameEvent.ENTER_FRAME, mainLoop);
        DisplayObjectUtil.removeAll(_view);
        _field.destroy();
//        Config.gameInfo.refresh();

//        DisplayObjectUtil.removeAll(_view);
//        var raceInfo:RaceInfo = RaceInfoLib.getRaceInfoByLevel(1);
//        _view.addChild(new RaceResultView(data.raceInfo));
    }

    private function onNeedRace(data:*):void{
        DisplayObjectUtil.removeAll(_view);

        var f:Field = RaceInfoLib.getRaceInfoByLevel(1);
        _field = new SQFieldController(f);
//        _field.addBehavior(new CameraBehavior());
        _field.draw();

        if(Config.DEBUG){
            _fieldDebugView = new BitmapDebug(1850, 1870, Config.stage.color);
            _view.addChild(_fieldDebugView.display);
            _view.alpha = 0.5;
        }

        setTimeout(Config.mainScene.addEventListener, 2000,  EnterFrameEvent.ENTER_FRAME, mainLoop);
    }

    private function mainLoop(e:EnterFrameEvent):void {
        _field.draw();
        if(!_field.view.parent)
            Config.mainScene.addChild(_field.view);

//        var passedTime:Number = e.passedTime != 0 ? e.passedTime : 0.00001;
        _field.doStep(1 / 60, _fieldDebugView);
    }

    public function get view():MovieClip {
        return _view;
    }
}
}