/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.12.12
 * Time: 14:42
 * To change this template use File | Settings | File Templates.
 */
package sqballs {

import core.utils.DisplayObjectUtil;

import core.utils.FPSCounter;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;


import sqballs.utils.Config;

import starling.display.Sprite;

public class Engine extends Sprite{

    private var _scene:SceneController;

    public function Engine() {
        init();
    }

    private function init():void {
        Config.mainScene = this;
        loadConfig(applyConfig, onError);
    }

    private function loadConfig(onComplete:Function, onError:Function):void{
        var urlL:URLLoader = new URLLoader();
        urlL.addEventListener(Event.COMPLETE, applyConfig);
        urlL.addEventListener(IOErrorEvent.IO_ERROR, onError);

        var urlR:URLRequest = new URLRequest(Config.EXTERNAL_CONFIG);
        urlL.load(urlR);
    }

    private function applyConfig(e:Event):void{
        var loader:URLLoader =  URLLoader(e.target);
        var jsonData:Object = JSON.parse(loader.data);

        var colorArr:Array = jsonData["user"]["color"];
        Config.userColor = DisplayObjectUtil.rgbToHex(colorArr[0], colorArr[1], colorArr[2]);

        colorArr = jsonData["enemy"]["color1"];
        var enemyColors:Array = [DisplayObjectUtil.rgbToHex(colorArr[0], colorArr[1], colorArr[2])];

        colorArr = jsonData["enemy"]["color2"];
        enemyColors.push(DisplayObjectUtil.rgbToHex(colorArr[0], colorArr[1], colorArr[2]));

        Config.enemyColors = enemyColors;
        Config.maxBallsCount = jsonData["maxBallsCount"];

        _scene = new SceneController();
        Config.stage.addChild(new FPSCounter(5, 5));
    }

    private function onError(event:IOErrorEvent):void{
        trace(event);
    }
}
}
