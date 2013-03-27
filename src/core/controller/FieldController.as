/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.03.13
 * Time: 14:35
 * To change this template use File | Settings | File Templates.
 */
package core.controller {
import core.behaviors.BehaviorBase;
import core.model.ObjectBase;
import core.utils.DisplayObjectUtil;
import core.utils.VectorUtil;
import core.utils.nape.PhysEngineConnector;

public class FieldController extends ControllerBase{

    protected var _controllers:Vector.<ControllerBase>;

    public function FieldController() {
        super();
        init();
    }

    protected function init():void {
        _controllers = new Vector.<ControllerBase>();
        PhysEngineConnector.instance.initField(this);
    }

    override public function draw():void{
        super.draw();

        for each(var p:ControllerBase in _controllers){
            if(p == this)
                continue;

            p.draw();
            _view.addChild(p.view);
        }
    }

    public function add(c:ControllerBase):void{
        PhysEngineConnector.instance.addObjectToField(this, c.object);
        _controllers.push(c);
        c.startBehaviors();
    }

    public function remove(c:ControllerBase):void{
        c.stopBehaviors();

        PhysEngineConnector.instance.destroyObject(c.object);
        VectorUtil.removeElement(_controllers, c);
        DisplayObjectUtil.tryRemove(c.view);
    }

    public function destroy():void{
        while(_controllers.length != 0){
            remove(_controllers[0]);
        }

        clear();
        PhysEngineConnector.instance.destroyField(this);
    }

    public function doStep(step:Number, debugView:* = null):void{
        for each(var p:ControllerBase in _controllers){
            p.doBehaviorsStep(step);
            p.object.applyTerrainFriction(0.2, 0.01, step);
        }

        PhysEngineConnector.instance.doStep(this, step, debugView);
    }

    public function getControllerByObject(obj:ObjectBase):ControllerBase{
        for each(var p:ControllerBase in _controllers){
            if(p.object == obj)
                return p;
        }

        return null;
    }

    public function getControllerByBehavior(b:BehaviorBase):ControllerBase{
        for each(var p:ControllerBase in _controllers){
            if(p.hasBehavior(b))
                return p;
        }

        return null;
    }

    public function getControllersByBehaviorClass(bClass:Class):Vector.<ControllerBase>{
        return _controllers.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return e.getBehaviorByClass(bClass);
        });
    }

    public function getControllersByClass(cls:Class):Vector.<ControllerBase>{
        return _controllers.filter(function (e:ControllerBase, i:int, v:Vector.<ControllerBase>):Boolean{
            return e is cls;
        });
    }


}
}
