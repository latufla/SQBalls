/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 30.12.12
 * Time: 20:12
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {
import flash.display.Stage;
import flash.geom.Rectangle;

import sqballs.Engine;
import sqballs.SceneController;
import sqballs.controller.SQFieldController;
import sqballs.model.info.GameInfo;

public class Config {

    public static const fps:uint = 60;
    public static const DEBUG:Boolean = false;

    public static var stage:Stage;
    public static var mainScene:Engine;

    public static var fieldController:SQFieldController;
    public static var sceneController:SceneController;
    public static var gameInfo:GameInfo;

    public static var enemyColors:Array = [0x0000FF, 0xFF0000];

    public static var ballRadiusSteps:Array = [10, 20, 30];
    public static var levelRect:Rectangle = new Rectangle(44, 40, 935, 668);
    public static var maxBallsCount:uint = 20;

    // gameplay
    public static function get pointsForPlacePlanet1():Array{
        return [1000, 700, 400, 0];
    }

    public static function get racesCountPlanet1():uint{
        return 8;
    }

    public static function get maxBotsCount():uint{
        return 30;
    }
}
}
