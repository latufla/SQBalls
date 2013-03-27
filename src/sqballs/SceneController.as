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
import flash.display.Sprite;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.Dictionary;

import nape.util.BitmapDebug;

import sqballs.behaviors.gameplay.GameResultResolveBehavior;

import sqballs.controller.SQFieldController;
import sqballs.event.GameEvent;
import sqballs.model.info.GameInfo;
import sqballs.model.info.UserInfo;
import sqballs.utils.Config;
import sqballs.utils.FieldLib;
import sqballs.utils.FlashAssetsLib;
import sqballs.utils.tr.en.Tr;
import sqballs.view.DialogWindowView;

import starling.events.EnterFrameEvent;

public class SceneController extends EventDispatcher{
    private static const RESTART_BUTTON_POS:Point = new Point(900, 2);

    private var _gameEventHandlers:Dictionary; // sqballs.event type -> function

    private var _view:MovieClip;
    private var _restartButton:Sprite;

    private var _fieldController:SQFieldController;
    private var _fieldDebugView:BitmapDebug;

    public function SceneController() {
        init();
    }

    private function init():void {
        _view = new MovieClip();
        Config.stage.addChild(_view);

        initRestartButton();

        addEventListeners();

        var player:UserInfo = UserInfo.create(0, "ball0", new Point(99, 90), 20);
        Config.gameInfo = new GameInfo(player);

        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_BRAWL));
        Config.sceneController = this;
    }

    private function initRestartButton():void {
        _restartButton = FlashAssetsLib.instance.createAssetBy(FlashAssetsLib.REFRESH_BUTTON);
        _restartButton.x = RESTART_BUTTON_POS.x;
        _restartButton.y = RESTART_BUTTON_POS.y;
        _restartButton.useHandCursor = _restartButton.buttonMode = true;
        _restartButton.mouseChildren = false;

        _restartButton.addEventListener(MouseEvent.CLICK, onRefreshButtonClick);
        Config.stage.addChild(_restartButton);
    }

    private function onRefreshButtonClick(e:MouseEvent):void {
        stopSimulation();
        showRestartRaceWindow(Tr.restartBrawlText, false);
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
        stopSimulation();

        var text:String = Tr.defeatText;
        if(data.result == GameResultResolveBehavior.VICTORY)
            text= Tr.victoryText;

        showRestartRaceWindow(text, true);
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

        startSimulation();
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
        stopSimulation();
        DisplayObjectUtil.removeAll(_view);
        _fieldController.destroy();

        EventHeap.instance.dispatch(new GameEvent(GameEvent.NEED_BRAWL));
    }

    private function showRestartRaceWindow(text:String, noDeny:Boolean = false):void{
        var resultWnd:DialogWindowView = new DialogWindowView();
        resultWnd.contentField.text = text;

        if(noDeny)
            resultWnd.applyNoDeny();

        resultWnd.x = resultWnd.y = 300;
        resultWnd.okButtonCallback = restartRace;
        resultWnd.cancelButtonCallback = resultWnd.closeButtonCallback = startSimulation;
        Config.stage.addChild(resultWnd);
    }

    private function startSimulation():void{
        Config.mainScene.addEventListener(EnterFrameEvent.ENTER_FRAME, mainLoop);
    }

    private function stopSimulation():void{
        Config.mainScene.removeEventListener(EnterFrameEvent.ENTER_FRAME, mainLoop);
    }

}
}