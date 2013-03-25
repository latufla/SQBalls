/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 20.03.13
 * Time: 19:31
 * To change this template use File | Settings | File Templates.
 */
package sqballs.behaviors {
import core.behaviors.BehaviorBase;
import core.controller.ControllerBase;
import core.utils.DisplayObjectUtil;

import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import sqballs.model.Field;

public class DebugStatDisplayBehavior extends BehaviorBase{

    private var _raceInfo:Field;
    private var _statField:TextField;

    public function DebugStatDisplayBehavior(raceInfo:Field) {
        super();
        _raceInfo = raceInfo;
    }

    override public function start(c:ControllerBase):void{
        super.start(c);

        _statField ||= new TextField();
        _statField.autoSize = TextFieldAutoSize.LEFT;
        _statField.textColor = 0xFF0000;
    }

    override public function stop():void{
        super.stop();
        DisplayObjectUtil.tryRemove(_statField);
    }

    override public function doStep(step:Number):void {
        if(!_enabled)
            return;

        super.doStep(step);
    }
}
}
