package sqballs {

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import starling.core.Starling;

[SWF(width="1024", height="768", backgroundColor="#FFFFFF", frameRate="60")]
public class SQBalls extends Sprite {

    public static var starlingConnector:Starling;
    public static var STAGE:Stage;

    public function SQBalls() {
        addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
    }

    private function onAddToStage(e:Event):void {
        STAGE = stage;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        starlingConnector = new Starling(Engine, stage);
        starlingConnector.start();
    }
}
}




