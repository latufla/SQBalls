/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 23.12.12
 * Time: 15:09
 * To change this template use File | Settings | File Templates.
 */
package core.utils.nape {
import flash.display.BitmapData;

import nape.geom.AABB;
import nape.geom.IsoFunction;

public class NapeBitmapDataIso implements IsoFunction {
    public var bitmap:BitmapData;
    public var alphaThreshold:Number;
    public var bounds:AABB;

    public function NapeBitmapDataIso(bitmap:BitmapData, alphaThreshold:Number = 0x80):void {
        this.bitmap = bitmap;
        this.alphaThreshold = alphaThreshold;
        bounds = new AABB(0, 0, bitmap.width, bitmap.height);
    }

    public function iso(x:Number, y:Number):Number {
        // Take 4 nearest pixels to interpolate linearly.
        // This gives us a smooth iso-function for which
        // we can use a lower quality in MarchingSquares for
        // the root finding.

        var ix:int = int(x); var iy:int = int(y);
        //clamp in-case of numerical inaccuracies
        if(ix<0) ix = 0; if(iy<0) iy = 0;
        if(ix>=bitmap.width) ix = bitmap.width-1;
        if(iy>=bitmap.height) iy = bitmap.height-1;

        // iso-function values at each pixel centre.
        var a11:Number = alphaThreshold - (bitmap.getPixel32(ix,iy)>>>24);
        var a12:Number = alphaThreshold - (bitmap.getPixel32(ix+1,iy)>>>24);
        var a21:Number = alphaThreshold - (bitmap.getPixel32(ix,iy+1)>>>24);
        var a22:Number = alphaThreshold - (bitmap.getPixel32(ix+1,iy+1)>>>24);

        // Bilinear interpolation for sample point (x,y)
        var fx:Number = x - ix; var fy:Number = y - iy;
        return a11*(1-fx)*(1-fy) + a12*fx*(1-fy) + a21*(1-fx)*fy + a22*fx*fy;
    }
}
}
