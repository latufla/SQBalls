/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 17.02.13
 * Time: 13:54
 * To change this template use File | Settings | File Templates.
 */
package core.utils {
import flash.display.BitmapData;
import flash.display.Shape;
import flash.geom.Point;

public class DisplayObjectUtil {

    public static function tryRemove(view:*):void{
        if(view && view.parent)
            view.parent.removeChild(view);
    }

    public static function removeAll(view:*):void{
        while(view.numChildren != 0)
            view.removeChildAt(0);
    }

    public static function createCircle(center:Point, radius:uint, color:uint):BitmapData{
        var c:Shape = new Shape();
        c.graphics.beginFill(color, 1);
        c.graphics.drawCircle(center.x, center.y, radius);
        c.graphics.endFill();

        var bd:BitmapData = new BitmapData(radius * 2, radius * 2, true, 0xFFFFFF);
        bd.draw(c);

        return bd;
    }


    public static function rgbToHex(r:int, g:int, b:int):uint{
        return (r<<16)|(g << 8)|b;
    }
}
}
