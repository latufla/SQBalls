/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 18.03.13
 * Time: 14:40
 * To change this template use File | Settings | File Templates.
 */
package sqballs.utils {

import flash.display.Bitmap;
import flash.display.BitmapData;

import sqballs.model.Field;

public class RaceInfoLib {

    [Embed(source="../../../assets/levels/1/borders.png")]
    private static var FieldBorderViewClass:Class;

    public function RaceInfoLib() {
        init();
    }

    private function init():void {

    }

    public static function getRaceInfoByLevel(l:uint = 1):Field{
//        return getDemoRaceInfoByLevel();


//        var border:BitmapData = Bitmap(new Race1BorderViewClass()).bitmapData;
//        var wps:Vector.<Object> = new Vector.<Object>();
//        wps.push({isFinish: true, rect: new Rectangle(1490, 910, 170, 2), inLine: new Line(new Point(1490, 912), new Point(1660, 912)), outLine:new Line(new Point(1490, 910), new Point(1660, 910))});
//        wps.push({rect: new Rectangle(1458, 177, 206, 206), inLine: new Line(new Point(1458, 383), new Point(1664, 383)), outLine:new Line(new Point(1458, 177), new Point(1458, 383))});
//        wps.push({rect: new Rectangle(170, 177, 206, 206), inLine: new Line(new Point(376, 177), new Point(376, 383)), outLine:new Line(new Point(170, 383), new Point(376, 383))});
//        wps.push({rect: new Rectangle(170, 1465, 206, 206), inLine: new Line(new Point(170, 1465), new Point(376, 1465)), outLine:new Line(new Point(376, 1465), new Point(376, 1671))});
//        wps.push({rect: new Rectangle(1458, 1465, 206, 206), inLine: new Line(new Point(1458, 1465), new Point(1458, 1671)), outLine:new Line(new Point(1458, 1465), new Point(1664, 1465))});

//        var f:Field = new Field(border, wps, Config.gameInfo.allRacers);
//        f.libDesc = StarlingAssetsLib.LEVEL_1;
//        return f;

        var border:BitmapData = Bitmap(new FieldBorderViewClass()).bitmapData;
        var f:Field = new Field(border, Config.gameInfo.users);
        f.libDesc = StarlingAssetsLib.LEVEL_1;
        return f;
    }
}
}
