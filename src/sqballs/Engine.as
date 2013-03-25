/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.12.12
 * Time: 14:42
 * To change this template use File | Settings | File Templates.
 */
package sqballs {
import core.utils.FPSCounter;

import sqballs.utils.Config;

import starling.display.Sprite;

public class Engine extends Sprite{

    private var _scene:SceneController;

    public function Engine() {
        init();
    }

    private function init():void {
        Config.mainScene = this;

        _scene = new SceneController();
        SQBalls.STAGE.addChild(new FPSCounter(5, 5));
    }
}
}
