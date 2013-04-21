/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 21.04.13
 * Time: 11:28
 * To change this template use File | Settings | File Templates.
 */
package core.utils.graphic {
import core.model.ObjectBase;
import core.view.SequenceView;
import core.view.SpriteView;
import core.view.ViewBase;

import flash.geom.Point;
import flash.geom.Rectangle;

import flash.utils.Dictionary;

import starling.display.DisplayObject;

import starling.display.MovieClip;

import starling.display.Sprite;

public class GraphicsEngineConnector {

    private static var _classes:Dictionary;

    private static var _instance:GraphicsEngineConnector;
    private var _views:Dictionary; // ViewBase -> starling DisplayObject

    public function GraphicsEngineConnector() {
        init();
    }

    public static function get instance():GraphicsEngineConnector {
        _instance ||= new GraphicsEngineConnector();
        return _instance;
    }

    private function init():void {
        _views = new Dictionary();

        _classes = new Dictionary();
        _classes[SpriteView] = Sprite;
        _classes[SequenceView] = MovieClip;
    }

    public function addView(view:ViewBase):void{
        var ViewClass:Class = _classes[(view as Object).constructor];
        if(!ViewClass)
            return;

        _views[view] ||= new ViewClass();
    }

    public function getPosition(view:ViewBase):Point{
        var view:DisplayObject = _views[view];
        return new Point(view.x, view.y);
    }

    public function setPosition(view:ViewBase, pos:Point):void{
        var view:DisplayObject = _views[view];
        view.x = pos.x;
        view.y = pos.y;
    }

    public function getSize(view:ViewBase):Rectangle{
        var view:DisplayObject = _views[view];
        return new Rectangle(0, 0, view.width, view.height);
    }

    public function setSize(view:ViewBase, size:Rectangle):void{
        var view:DisplayObject = _views[view];
        view.width = size.width;
        view.height = size.height;
    }

    public function getRotation(view:ViewBase):Number{
        var view:DisplayObject = _views[view];
        return view.rotation;
    }

    public function setRotation(view:ViewBase, rotation:Number):void{
        var view:DisplayObject = _views[view];
        view.rotation = rotation;
    }

    public function setPivot(view:ViewBase, pivot:Point):void{
        var view:DisplayObject = _views[view];
        view.pivotX = pivot.x;
        view.pivotY = pivot.y;
    }

    public function getPivot(view:ViewBase):Point{
        var view:DisplayObject = _views[view];
        return new Point(view.pivotX, view.pivotY);
    }

}
}
