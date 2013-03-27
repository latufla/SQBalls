/**
 * Created with IntelliJ IDEA.
 * User: Latufla
 * Date: 04.03.13
 * Time: 14:49
 * To change this template use File | Settings | File Templates.
 */
package sqballs.view {
import core.utils.DisplayObjectUtil;
import core.utils.DisplayObjectUtil;

import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import sqballs.utils.FlashAssetsLib;

public class DialogWindowView extends Sprite{

    private var _container:DisplayObjectContainer;
    private var _okButtonCallback:Function;

    [Embed(source="../../../assets/fonts/ARIALUNI.TTF", fontName = "myArial", mimeType = "application/x-font", unicodeRange = "U+0020-007E", fontWeight="normal", fontStyle="normal", advancedAntiAliasing="true", embedAsCFF="false")]
    private var myArialFont:Class;

    public function DialogWindowView() {
        super();
        init();
    }

    private function init():void{
        _container = FlashAssetsLib.instance.createAssetBy(FlashAssetsLib.DIALOG_WINDOW) as DisplayObjectContainer;
        addChild(_container);

        closeButton.buttonMode =  closeButton.useHandCursor = true;

        cancelButton.buttonMode =  cancelButton.useHandCursor = true;
        cancelButton.mouseChildren = false;

        okButton.buttonMode =  okButton.useHandCursor = true;
        okButton.mouseChildren = false;

        contentField.autoSize = TextFieldAutoSize.LEFT;
        contentField.embedFonts = true;
        contentField.defaultTextFormat = new TextFormat("myArial", 16);
        contentField.textColor = 0xFFFFFF;
        contentField.text = "Default SQBalls dialog sign!";

        addEventListeners();
    }

    public function applyNoDeny():void{
        cancelButton.visible = closeButton.visible = false;
        DisplayObjectUtil.alignByCenter(okButton, true, false);
    }

    public function get okButtonCallback():Function {
        return _okButtonCallback;
    }

    public function set okButtonCallback(value:Function):void {
        _okButtonCallback = value;
    }

    public function get contentField():TextField{
        return _container["contentField"];
    }

    public function get closeButton():MovieClip{
        return _container["closeButton"];
    }

    // TODO: use normal buttons
    public function get cancelButton():MovieClip{
        return _container["cancelButton"];
    }

    public function get okButton():MovieClip{
        return _container["okButton"];
    }

    protected function addEventListeners():void {
        closeButton.addEventListener(MouseEvent.CLICK, onCloseButtonClick);
        cancelButton.addEventListener(MouseEvent.CLICK, onCancelButtonClick);
        okButton.addEventListener(MouseEvent.CLICK, onOkButtonClick);
    }

    protected function removeEventListeners():void {
        closeButton.removeEventListener(MouseEvent.CLICK, onCloseButtonClick);
        cancelButton.removeEventListener(MouseEvent.CLICK, onCancelButtonClick);
        okButton.removeEventListener(MouseEvent.CLICK, onOkButtonClick);
    }

    protected function onCloseButtonClick(e:MouseEvent = null):void {
        DisplayObjectUtil.tryRemove(this);
        removeEventListeners();
    }

    protected function onCancelButtonClick(e:MouseEvent = null):void {
        onCloseButtonClick();
    }

    protected function onOkButtonClick(e:MouseEvent = null):void {
        if(_okButtonCallback)
            _okButtonCallback();

        onCloseButtonClick();
    }
}
}