// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelTrade

package Main.Aqw.LPF
{
    import flash.geom.Point;
    import flash.events.*;
    import flash.geom.*;

    public class LPFPanelTrade extends LPFPanel 
    {

        public var mainClass:Game = Game.root;

        public function LPFPanelTrade():void
        {
            x = 0;
            y = 0;
            frames = [];
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            fData = _arg1.fData;
            drawBG(LPFPanelBg4);
            bg.tTitle.text = "Trade";
            bg.tPane1.text = "Your Inventory";
            bg.tPane2.text = (this.mainClass.world.myAvatar.objData.strUsername + "'s Offer");
            bg.tPane3.text = (fData.tradeUser + "'s Offer");
            x = (_arg1.r.x + 15);
            y = ((_arg1.r.y > -1) ? _arg1.r.y : ((fParent.numChildren > 1) ? ((fParent.getChildAt((fParent.numChildren - 2)).y + fParent.getChildAt((fParent.numChildren - 2)).height) + 10) : 10));
            var point:Point = bg.localToGlobal(new Point(0, 0));
            bg.y = (bg.y - int((point.y - point.y)));
            w = _arg1.r.w;
            h = _arg1.r.h;
            xo = (x + 15);
            yo = y;
            width = (width - (15 << 1));
            height = (height - 15);
            if (("closeType" in _arg1))
            {
                closeType = _arg1.closeType;
            };
            if (("hideDir" in _arg1))
            {
                hideDir = _arg1.hideDir;
            };
            if (("hidePad" in _arg1))
            {
                hidePad = _arg1.hidePad;
            };
            if (("xBuffer" in _arg1))
            {
                xBuffer = _arg1.xBuffer;
            };
            if (("isOpen" in _arg1))
            {
                isOpen = _arg1.isOpen;
            };
            var _local4:Object = {};
            _local4 = {};
            _local4.frame = new LPFFrameBackdrop();
            _local4.fData = null;
            _local4.r = {
                "x":30,
                "y":37,
                "w":290,
                "h":320
            };
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameBackdrop();
            _local4.fData = null;
            _local4.r = {
                "x":348,
                "y":37,
                "w":290,
                "h":239
            };
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameBackdrop();
            _local4.fData = null;
            _local4.r = {
                "x":670,
                "y":37,
                "w":290,
                "h":239
            };
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameListViewTabbed();
            _local4.fData = {"list":fData.itemsB};
            _local4.r = {
                "x":353,
                "y":41,
                "w":265,
                "h":225
            };
            _local4.tabStates = LPFLayout(fParent).getTabStates();
            _local4.sortOrder = LPFLayout(fParent).getSortOrder();
            _local4.filterMap = LPFLayout(fParent).getFilterMap();
            _local4.sName = "offer";
            _local4.itemEventType = "offerSel";
            _local4.tabEventType = "categorySelMyOffer";
            _local4.eventTypes = ["refreshItems", "refreshBank", "categorySelMyOffer"];
            _local4.onDemand = false;
            _local4.openBlank = false;
            _local4.allowDesel = true;
            _local4.refreshTabs = true;
            this.mainClass.tradeItem1 = _local4.frame;
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameListViewTabbed();
            _local4.fData = {"list":fData.itemsC};
            _local4.r = {
                "x":675,
                "y":41,
                "w":265,
                "h":225
            };
            _local4.tabStates = LPFLayout(fParent).getTabStates();
            _local4.sortOrder = LPFLayout(fParent).getSortOrder();
            _local4.filterMap = LPFLayout(fParent).getFilterMap();
            _local4.sName = "their";
            _local4.itemEventType = "otherSel";
            _local4.tabEventType = "categorySelTheirOffer";
            _local4.eventTypes = ["refreshItems", "refreshBank", "categorySelTheirOffer"];
            _local4.onDemand = false;
            _local4.openBlank = false;
            _local4.allowDesel = true;
            _local4.refreshTabs = true;
            this.mainClass.tradeItem2 = _local4.frame;
            addFrame(_local4);
            _local4.eventTypes = ["refreshItems", "refreshBank", "refreshSlots"];
            _local4.isBank = true;
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameListViewTabbed();
            _local4.fData = {"list":fData.itemsI};
            _local4.r = {
                "x":37,
                "y":41,
                "w":265,
                "h":311
            };
            _local4.tabStates = LPFLayout(fParent).getTabStates();
            _local4.sortOrder = LPFLayout(fParent).getSortOrder();
            _local4.filterMap = LPFLayout(fParent).getFilterMap();
            _local4.sName = "inventory";
            _local4.itemEventType = "inventorySel";
            _local4.tabEventType = "inventorySelMC";
            _local4.eventTypes = ["refreshItems", "refreshInventory", "inventorySelMC"];
            _local4.openBlank = false;
            _local4.allowDesel = true;
            _local4.onDemand = false;
            _local4.refreshTabs = true;
            this.mainClass.tradeItem3 = _local4.frame;
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameSimpleText();
            _local4.fData = {"msg":""};
            _local4.r = {
                "x":-1,
                "y":42,
                "w":200,
                "h":-1,
                "center":true
            };
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameGenericButton();
            _local4.fData = null;
            _local4.r = {
                "x":127,
                "y":365,
                "w":100,
                "h":-1
            };
            _local4.eventTypes = ["previewButton1Update"];
            addFrame(_local4);
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
        }


    }
}//package Main.Aqw.LPF

