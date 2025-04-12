// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//DFrame2MC

package 
{
    import Main.UI.AbstractDropFrame;
    import flash.display.MovieClip;
    import Main.Model.Item;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Aqw.LPF.*;

    public class DFrame2MC extends AbstractDropFrame 
    {

        public var cnt:MovieClip;

        public function DFrame2MC(item:Item):void
        {
            addFrameScript(3, this.frame4, 11, this.frame12);
            this.fWidth = 250;
            this.fHeight = 86;
            this.fData = item;
            this.durFrameT = 35;
        }

        private static function setCT(mc:MovieClip, color:uint):void
        {
            var ct:ColorTransform = mc.transform.colorTransform;
            ct.color = color;
            mc.transform.colorTransform = ct;
        }

        private static function yMouseOver(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0x222222);
        }

        private static function yMouseOut(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0);
        }

        private static function nMouseOver(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0x222222);
        }

        private static function nMouseOut(_arg1:MouseEvent):void
        {
            setCT(MovieClip(_arg1.currentTarget).bg, 0);
        }


        override public function init():void
        {
            this.cnt.strName.autoSize = "left";
            this.cnt.strName.htmlText = fData.sName;
            if (fData.iStk > 1)
            {
                this.cnt.strName.text = (this.cnt.strName.text + (" x" + fData.iQty));
            };
            this.cnt.bg.width = Math.max(((this.cnt.strName.x + int(this.cnt.strName.textWidth)) + 15), 250);
            this.cnt.ybtn.bg.width = Math.round((this.cnt.bg.width >> 1));
            this.cnt.nbtn.bg.width = Math.round((this.cnt.bg.width - this.cnt.ybtn.bg.width));
            this.cnt.nbtn.x = this.cnt.ybtn.width;
            this.cnt.ybtn.ti.mouseEnabled = false;
            this.cnt.nbtn.ti.mouseEnabled = false;
            this.cnt.strType.text = rootClass.getDisplaysType(fData);
            super.init();
            this.cnt.ybtn.buttonMode = true;
            this.cnt.nbtn.buttonMode = true;
            this.cnt.ybtn.addEventListener(MouseEvent.CLICK, this.yClick, false, 0, true);
            this.cnt.ybtn.addEventListener(MouseEvent.MOUSE_OVER, yMouseOver, false, 0, true);
            this.cnt.ybtn.addEventListener(MouseEvent.MOUSE_OUT, yMouseOut, false, 0, true);
            this.cnt.nbtn.addEventListener(MouseEvent.CLICK, this.nClick, false, 0, true);
            this.cnt.nbtn.addEventListener(MouseEvent.MOUSE_OVER, nMouseOver, false, 0, true);
            this.cnt.nbtn.addEventListener(MouseEvent.MOUSE_OUT, nMouseOut, false, 0, true);
            this.autoAcceptDrop();
        }

        private function autoAcceptDrop():void
        {
            var item:Item;
            for each (item in rootClass.world.myAvatar.items)
            {
                if (item.ItemID == fData.ItemID)
                {
                    this.yClick(null);
                    break;
                };
            };
        }

        public function fClose():void
        {
            this.killButtons();
            parent.removeChild(this);
        }

        private function frame4():void
        {
            stop();
        }

        private function frame12():void
        {
            this.fClose();
        }

        private function killButtons():void
        {
            this.cnt.ybtn.removeEventListener(MouseEvent.CLICK, this.yClick);
            this.cnt.ybtn.removeEventListener(MouseEvent.MOUSE_OVER, yMouseOver);
            this.cnt.ybtn.removeEventListener(MouseEvent.MOUSE_OUT, yMouseOut);
            this.cnt.nbtn.removeEventListener(MouseEvent.CLICK, this.nClick);
            this.cnt.nbtn.removeEventListener(MouseEvent.MOUSE_OVER, nMouseOver);
            this.cnt.nbtn.removeEventListener(MouseEvent.MOUSE_OUT, nMouseOut);
        }

        private function onPreviewClick(mouseEvent:MouseEvent):void
        {
            LPFLayoutChatItemPreview.linkItem(fData);
        }

        private function yClick(_arg1:MouseEvent):void
        {
            var item:Item;
            var b:Boolean = true;
            for each (item in rootClass.world.myAvatar.items)
            {
                if (((item.ItemID == fData.ItemID) && (item.iQty < item.iStk)))
                {
                    b = false;
                };
            };
            if (((b) && (rootClass.world.myAvatar.items.length < rootClass.world.myAvatar.objData.iBagSlots)))
            {
                b = false;
            };
            if (((rootClass.isHouseItem(fData)) && (rootClass.world.myAvatar.houseitems.length >= rootClass.world.myAvatar.objData.iHouseSlots)))
            {
                rootClass.MsgBox.notify("House Inventory Full!");
            }
            else
            {
                if (b)
                {
                    rootClass.MsgBox.notify("Item Inventory Full!");
                }
                else
                {
                    setCT(this.cnt.ybtn.bg, 3385873);
                    this.cnt.ybtn.mouseEnabled = false;
                    this.cnt.ybtn.mouseChildren = false;
                    rootClass.network.send("getDrop", [fData.ItemID]);
                };
            };
        }

        private function nClick(_arg1:MouseEvent):void
        {
            rootClass.network.send("denyDrop", [fData.ItemID]);
            this.killButtons();
        }


    }
}//package 

