/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 12.01.13
 * Time: 17:27
 * To change this template use File | Settings | File Templates.
 */
package core.controller {
import core.behaviors.BehaviorBase;
import core.model.ObjectBase;
import core.utils.VectorUtil;
import core.view.ViewBase;

public class ControllerBase {

    protected var _view:ViewBase;
    protected var _object:ObjectBase;

    protected var _behaviors:Vector.<BehaviorBase>;

    public function ControllerBase() {
        init();
    }

    private function init():void {
        _behaviors ||= new Vector.<BehaviorBase>();
    }

    public static function create(obj:ObjectBase, behaviors:Vector.<BehaviorBase> = null):ControllerBase{
        var c:ControllerBase = new ControllerBase();
        c.object = obj;
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }

        return c;
    }


    public function draw():void{
        if(!_object)
            return;

        _view ||= new ViewBase();
        _view.content ||= _object.createAsset();

        align();
    }

    protected function align():void{

    }

    public function addBehavior(b:BehaviorBase):void{
        _behaviors.push(b);
    }

    public function removeBehavior(b:BehaviorBase):void{
        b.stop();
        VectorUtil.removeElement(b, _behaviors);
    }

    public function startBehaviors():void{
        for each(var p:BehaviorBase in _behaviors){
            p.start(this);
        }
    }

    public function startBehaviorByClass(bClass:Class):void{
        var b:BehaviorBase = getBehaviorByClass(bClass);
        if(b)
            b.start(this);
    }

    public function stopBehaviors():void{
        for each(var p:BehaviorBase in _behaviors){
            p.stop();
        }
    }

    public function doBehaviorsStep(step:Number):void{
        for each(var p:BehaviorBase in _behaviors){
            p.doStep(step);
        }
    }

    public function getBehaviorByClass(bClass:Class):BehaviorBase{
        for each(var p:BehaviorBase in _behaviors){
            if(p is bClass)
                return p;
        }

        return null;
    }

    // not class but concrete behavior
    public function hasBehavior(b:BehaviorBase):Boolean{
        return _behaviors.indexOf(b) != -1;
    }

    public function get view():ViewBase {
        return _view;
    }

    public function set view(value:ViewBase):void {
        _view = value;
    }

    public function get object():ObjectBase {
        return _object;
    }

    public function set object(value:ObjectBase):void {
        _object = value;
    }
}
}
