/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 27.03.13
 * Time: 8:47
 * To change this template use File | Settings | File Templates.
 */
package sqballs.controller {
import core.behaviors.BehaviorBase;
import core.model.ObjectBase;
import core.utils.DisplayObjectUtil;
import core.utils.PixelMaskDisplayObject;

import flash.display.Bitmap;

import flash.display.BitmapData;

import flash.geom.Point;

import sqballs.model.Ball;

import starling.display.Image;
import starling.display.DisplayObject;
import starling.display.Sprite;

public class BallController extends SQControllerBase{

    private var _initialContentView:DisplayObject;
    private var _prevColor:uint;

    public function BallController() {
        super();
    }

    public static function create(obj:ObjectBase, behaviors:Vector.<BehaviorBase> = null):BallController{
        var c:BallController = new BallController();
        c.object = obj;
        for each(var p:BehaviorBase in behaviors){
            c.addBehavior(p);
        }

        return c;
    }

    // TODO: pool of initial ball views
    override protected function redrawContent():void{
        _initialContentView ||= _view.asset as DisplayObject;
        clear();

        var b:Ball = _object as Ball;
        var bd:BitmapData = DisplayObjectUtil.createCircle(new Point(50, 50), 50, b.color);
        var ballImage:Image = Image.fromBitmap(new Bitmap(bd, "auto", true));

        var ballView:Sprite = new Sprite();
        ballView.addChild(ballImage);

        // TODO: opt
        var pMask:PixelMaskDisplayObject = new PixelMaskDisplayObject();
        pMask.addChild(ballView);
        pMask.mask = _view.asset;
        _view.addChild(pMask);

        _prevColor = b.color;
    }

    override protected function align():void{
        super.align();

        var b:Ball = _object as Ball;
        _view.width = b.rectSize.width;
        _view.height = b.rectSize.height;
    }

    override protected function get shouldRedrawContent():Boolean{
        var b:Ball = _object as Ball;
        if(b)
            return _prevColor != b.color;

        return false;
    }
}
}