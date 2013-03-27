package sqballs {

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import sqballs.utils.Config;

import starling.core.Starling;

[SWF(width="1024", height="768", backgroundColor="#000000", frameRate="60")]
public class SQBalls extends Sprite {

    private var _starlingConnector:Starling;

    public function SQBalls() {
        addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
    }

    private function onAddToStage(e:Event):void {
        Config.stage = stage;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        _starlingConnector = new Starling(Engine, stage);
        _starlingConnector.start();
    }
}
}




