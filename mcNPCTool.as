// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcNPCTool

package 
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.Controller.*;

    public class mcNPCTool extends Sprite 
    {

        public var txtFrame:TextField;
        public var txtCell:TextField;
        public var txtX:TextField;
        public var txtY:TextField;
        public var btnClose:SimpleButton;

        public function mcNPCTool()
        {
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            UIController.close("npc_tool");
        }


    }
}//package 

