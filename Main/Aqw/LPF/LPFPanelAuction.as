// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelAuction

package Main.Aqw.LPF
{
    import flash.geom.Point;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class LPFPanelAuction extends LPFPanel 
    {

        public var mainClass:* = MovieClip(Game.root);

        public function LPFPanelAuction():void
        {
            x = 0;
            y = 0;
            frames = [];
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            var r:Object;
            fData = _arg1.fData;
            drawBG(LPFPanelBg5);
            bg.tTitle.text = ((this.mainClass.vendingOwner == "") ? "Market Place" : (this.mainClass.vendingOwner + "'s Store"));
            bg.tPane1.text = "Item Preview";
            bg.tPane2.text = "Purchase";
            bg.tPane3.text = "Sell";
            bg.tPane4.text = "Retrieve";
            r = _arg1.r;
            x = r.x;
            y = ((r.y > -1) ? r.y : ((fParent.numChildren > 1) ? ((fParent.getChildAt((fParent.numChildren - 2)).y + fParent.getChildAt((fParent.numChildren - 2)).height) + 10) : 10));
            var point:Point = bg.localToGlobal(new Point(0, 0));
            var _local5:Object = {
                "x":340,
                "y":75,
                "w":527,
                "h":245
            };
            bg.y = (bg.y - int((r.y - point.y)));
            w = r.w;
            h = r.h;
            xo = x;
            yo = y;
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
            _local4.eventTypes = ["refreshItems", "refreshBank", "refreshSlots"];
            _local4.isBank = true;
            _local4 = {};
            _local4.frame = new LPFFrameBackdrop();
            _local4.fData = null;
            _local4.r = {
                "x":15,
                "y":70.3,
                "w":294.35,
                "h":202.9
            };
            _local4.buttonNewEventType = ["buyBagSlots"];
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameBackdrop();
            _local4.fData = null;
            _local4.r = {
                "x":15,
                "y":278.6,
                "w":294.35,
                "h":93
            };
            _local4.buttonNewEventType = ["buyBagSlots"];
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameListViewTabbed();
            _local4.fData = {"list":fData.itemsI};
            _local4.r = _local5;
            _local4.tabStates = LPFLayout(fParent).getTabStates(null, true);
            _local4.sortOrder = LPFLayout(fParent).getSortOrder();
            _local4.filterMap = LPFLayout(fParent).getFilterMap();
            _local4.sName = "auctionBuy";
            _local4.itemEventType = "auctionSel";
            _local4.tabEventType = "categorySelAuction";
            _local4.eventTypes = ["refreshItems", "refreshBank", "categorySelAuction"];
            _local4.onAuction = true;
            _local4.onInventory = false;
            _local4.onRetrieve = false;
            _local4.onDemand = false;
            _local4.openBlank = false;
            _local4.refreshTabs = true;
            _local4.allowDesel = false;
            this.mainClass.auctionItem1 = _local4.frame;
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameListViewTabbed();
            _local4.fData = {"list":fData.itemsB};
            _local4.r = _local5;
            _local4.tabStates = LPFLayout(fParent).getTabStates(null, true);
            _local4.sortOrder = LPFLayout(fParent).getSortOrder();
            _local4.filterMap = LPFLayout(fParent).getFilterMap();
            _local4.sName = "auctionSell";
            _local4.itemEventType = "inventorySel";
            _local4.eventTypes = ["refreshItems", "refreshInventory"];
            _local4.onAuction = false;
            _local4.onInventory = true;
            _local4.onRetrieve = false;
            _local4.openBlank = false;
            _local4.allowDesel = false;
            this.mainClass.auctionItem2 = _local4.frame;
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameListViewTabbed();
            _local4.fData = {"list":fData.itemsC};
            _local4.r = _local5;
            _local4.tabStates = LPFLayout(fParent).getTabStates(null, true);
            _local4.sortOrder = LPFLayout(fParent).getSortOrder();
            _local4.filterMap = LPFLayout(fParent).getFilterMap();
            _local4.sName = "auctionRetrieve";
            _local4.itemEventType = "retrieveSel";
            _local4.tabEventType = "categorySelRetrieve";
            _local4.eventTypes = ["refreshItems", "refreshBank", "categorySelRetrieve"];
            _local4.onAuction = false;
            _local4.onInventory = false;
            _local4.onRetrieve = true;
            _local4.onDemand = false;
            _local4.openBlank = false;
            _local4.refreshTabs = true;
            _local4.allowDesel = false;
            this.mainClass.auctionItem3 = _local4.frame;
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
            _local4.frame = new LPFFrameItemPreview();
            _local4.fData = null;
            _local4.r = {
                "x":19,
                "y":72,
                "w":284,
                "h":-1
            };
            _local4.eventTypes = ["inventorySel", "retrieveSel", "auctionSel"];
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameEnhText();
            _local4.fData = null;
            _local4.r = {
                "x":19,
                "y":281,
                "w":284,
                "h":-1
            };
            _local4.eventTypes = ["inventorySel", "retrieveSel", "auctionSel"];
            addFrame(_local4);
            _local4 = {};
            _local4.frame = new LPFFrameGenericButton();
            _local4.fData = null;
            _local4.r = {
                "x":580,
                "y":-40,
                "w":200,
                "h":-1
            };
            _local4.eventTypes = ["previewButton1Update"];
            addFrame(_local4);
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
        }


    }
}//package Main.Aqw.LPF

