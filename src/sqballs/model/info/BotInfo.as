/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 24.03.13
 * Time: 12:57
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model.info {
import flash.geom.Point;

public class BotInfo extends UserInfo{
    public static const RETARDED:uint = 0;
    public static const DUMB:uint = 1;
    public static const ORDINARY:uint = 2;
    public static const SMART:uint = 3;

    private var _intelligence:uint = SMART;

    public function BotInfo(id:uint, name:String) {
        super(id, name)
    }

    public static function create(id:uint, name:String, initialPosition:Point, initialRadius:uint, intelligence:uint = SMART):UserInfo{
        var info:UserInfo = new BotInfo(id, name);
        info.initialPosition = initialPosition;
        info.initialRadius = initialRadius;
        return info;
    }

    public function get intelligence():uint {
        return _intelligence;
    }

    public function set intelligence(value:uint):void {
        _intelligence = value;
    }

    override public function toString():String{
        return "{ id: " + _id  +
                ", name: " + _name +
                ", initialPosition: " + _initialPosition +
                ", initialRadius: " + _initialRadius +
                ", intelligence: " + _intelligence + " }";
    }
}
}
