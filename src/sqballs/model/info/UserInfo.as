/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 21:21
 * To change this template use File | Settings | File Templates.
 */
package sqballs.model.info {
public class UserInfo {
    protected var _id:uint;
    protected var _name:String = "noName";

    protected var _points:uint = 0;
    protected var _races:uint = 0;

    public function UserInfo(id:uint, name:String) {
        _id = id;
        _name = name;
    }

    public static function create(id:uint, name:String):UserInfo{
        var info:UserInfo = new UserInfo(id, name);
        return info;
    }

    public function refresh():void{
    }

    public function get name():String {
        return _name;
    }

    public function get id():uint {
        return _id;
    }

    public function get points():uint {
        return _points;
    }

    public function set points(value:uint):void {
        _points = value;
    }

    public function get races():uint {
        return _races;
    }

    public function set races(value:uint):void {
        _races = value;
    }

    public function toString():String{
        return "{ id: " + _id  +
                ", name: " + _name +
                ", points: " + _points +
                ", races: " + _races + " }";
    }
}
}
