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

public class FieldLib {

    [Embed(source="../../../assets/levels/1/borders.png")]
    private static var FieldBorderViewClass:Class;

    public function FieldLib() {
    }

    public static function getFieldByLevel(l:uint = 1):Field{
        var border:BitmapData = Bitmap(new FieldBorderViewClass()).bitmapData;
        var f:Field = new Field(border, Config.gameInfo.users);
        f.libDesc = StarlingAssetsLib.LEVEL_1;
        return f;
    }
}
}
