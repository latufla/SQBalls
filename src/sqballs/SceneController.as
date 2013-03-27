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

import sqballs.behaviors.gameplay.GameResultResolveBehavior;

import sqballs.controller.SQFieldController;
import sqballs.event.GameEvent;
import sqballs.model.Field;
import sqballs.model.info.GameInfo;
import sqballs.model.info.UserInfo;
import sqballs.utils.Config;
import sqballs.utils.Config;
import sqballs.utils.FieldLib;
import sqballs.utils.tr.en.Tr;
import sqballs.view.DialogWindowView;

import starling.events.EnterFrameEvent;

public class SceneController extends EventDispatcher{
    private var _gameEventHandlers:Dictionary; // sqballs.event type -> function

    private var _view:MovieClip;

    private var _fieldController:SQFieldController;
    private var _fieldDebugView:BitmapDebug;

    public function SceneController() {
        init();
    }

    private function init():void {
        _view = new MovieClip();
        Config.stage.addChild(_view);

        addEventListeners();

        var player:UserInfo = UserInfo.create(0, "ball0", new Point(99, 90), 5);
        Config.gameInfo = new GameInfo(player);

        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_BRAWL));
        Config.sceneController = this;
    }

    // we should be able to dispatch game events in random project files
    // so it`s global
    private function addEventListeners():void {
        _gameEventHandlers = new Dictionary();
        _gameEventHandlers[GameEvent.NEED_BRAWL] = onNeedBrawl;
        _gameEventHandlers[GameEvent.NEED_BRAWL_RESULT] = onNeedBrawlResult;

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

    private function onNeedBrawlResult(data:*):void{
        DisplayObjectUtil.removeAll(_view);
        Config.mainScene.removeEventListener(EnterFrameEvent.ENTER_FRAME, mainLoop);

        var resultWnd:DialogWindowView = new DialogWindowView();
        if(data.result == GameResultResolveBehavior.VICTORY)
            resultWnd.contentField.text = Tr.victoryText;
        else
            resultWnd.contentField.text = Tr.defeatText;

        resultWnd.applyNoDeny();
        resultWnd.x = resultWnd.y = 300;
        resultWnd.okButtonCallback = restartRace;
        Config.stage.addChild(resultWnd);
    }

    private function onNeedBrawl(data:*):void{
        DisplayObjectUtil.removeAll(_view);

        Config.gameInfo.refresh();

        _fieldController = new SQFieldController(FieldLib.getFieldByLevel());
        _fieldController.addBehavior(new GameResultResolveBehavior());
        _fieldController.startBehaviors();
        _fieldController.draw();

        if(Config.DEBUG){
            _fieldDebugView = new BitmapDebug(Config.stage.stageWidth, Config.stage.stageHeight, 0xFFFFFF);
            _view.addChild(_fieldDebugView.display);
            _view.alpha = 0.5;
        }

        Config.mainScene.addEventListener(EnterFrameEvent.ENTER_FRAME, mainLoop);
    }

    private function mainLoop(e:EnterFrameEvent):void {
        _fieldController.draw();
        if(!_fieldController.view.parent)
            Config.mainScene.addChild(_fieldController.view);

        // normaly we should use e.passedTime,
        // but it`s single player so matter only if FPS is dramatically low
        _fieldController.doStep(1 / 60, _fieldDebugView);
    }

    private function restartRace():void{
        Config.mainScene.removeEventListener(EnterFrameEvent.ENTER_FRAME, mainLoop);
        DisplayObjectUtil.removeAll(_view);
        _fieldController.destroy();

        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_BRAWL));
    }
}
}