// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelListShopInvB

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.display.*;
    import flash.events.*;

    public class LPFPanelListShopInvB extends LPFPanel 
    {

        public function LPFPanelListShopInvB():void
        {
            x = 0;
            y = 0;
            frames = [];
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            var _local3:Object;
            fData = _arg1.fData;
            var _local2:Object = _arg1.r;
            x = _local2.x;
            y = ((_local2.y > -1) ? _local2.y : ((fParent.numChildren > 1) ? ((fParent.getChildAt((fParent.numChildren - 2)).y + fParent.getChildAt((fParent.numChildren - 2)).height) + 10) : 10));
            w = _local2.w;
            h = _local2.h;
            xo = x;
            yo = y;
            if (_arg1.closeType != undefined)
            {
                closeType = _arg1.closeType;
            };
            if (_arg1.hideDir != undefined)
            {
                hideDir = _arg1.hideDir;
            };
            if (_arg1.hidePad != undefined)
            {
                hidePad = _arg1.hidePad;
            };
            _local3 = {};
            _local3.frame = new LPFFrameBackdrop();
            _local3.fData = null;
            _local3.r = {
                "x":14,
                "y":44,
                "w":(w - 26),
                "h":271
            };
            addFrame(_local3);
            _local3 = {};
            _local3.frame = new LPFFrameBackdrop();
            _local3.fData = null;
            _local3.r = {
                "x":14,
                "y":320,
                "w":(w - 26),
                "h":121
            };
            addFrame(_local3);
            _local3 = {};
            _local3.frame = new LPFFrameListViewTabbed();
            _local3.fData = {"list":fData.items};
            _local3.r = {
                "x":20,
                "y":50,
                "w":265,
                "h":258
            };
            _local3.tabStates = LPFLayout(fParent).getTabStates();
            _local3.sortOrder = LPFLayout(fParent).getSortOrder();
            _local3.filterMap = LPFLayout(fParent).getFilterMap();
            _local3.sName = "itemListB";
            _local3.itemEventType = "listItemBSel";
            _local3.eventTypes = ["listItemASel", "refreshItems", "refreshInv"];
            _local3.filter = "sES";
            addFrame(_local3);
            _local3 = {};
            _local3.frame = new LPFFrameEnhText();
            _local3.fData = null;
            _local3.r = {
                "x":18,
                "y":321,
                "w":(w - 20),
                "h":-1
            };
            _local3.eventTypes = ["listItemBSolo", "showItemListB", "refreshItems"];
            addFrame(_local3);
            drawBG();
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            if (!(("showDragonLeft" in _arg1) && (_arg1.showDragonLeft == true)))
            {
                bg.dragonLeft.visible = false;
            };
            if (!(("showDragonRight" in _arg1) && (_arg1.showDragonRight == true)))
            {
                bg.dragonRight.visible = false;
            };
        }

        override public function fHide():void
        {
            var mc:MovieClip;
            isOpen = false;
            visible = false;
            switch (hideDir.toLowerCase())
            {
                case "left":
                    x = ((xo - w) - hidePad);
                    break;
                case "right":
                    x = ((xo + w) + hidePad);
                    break;
                case "top":
                    y = ((yo - h) - hidePad);
                    break;
                case "bottom":
                    y = ((yo + h) + hidePad);
                    break;
                case "":
            };
            var i:int;
            while (i < numChildren)
            {
                mc = MovieClip(getChildAt(i));
                if (mc.notify != undefined)
                {
                    mc.notify({"eventType":"clearState"});
                };
                i++;
            };
        }


    }
}//package Main.Aqw.LPF

