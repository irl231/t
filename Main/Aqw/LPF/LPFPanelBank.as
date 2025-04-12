// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelBank

package Main.Aqw.LPF
{
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.FocusEvent;
    import flash.events.*;
    import flash.geom.*;

    public class LPFPanelBank extends LPFPanel 
    {

        public function LPFPanelBank():void
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
            drawBG(LPFPanelBg3);
            bg.tTitle.text = "Bank";
            bg.tPane1.text = "Bank Items";
            bg.tPane2.text = "";
            bg.tPane3.text = "Inventory Items";
            bg.tSearch.visible = true;
            bg.mcSearch.visible = true;
            bg.mcSearch.addEventListener(MouseEvent.CLICK, this.onSearch, false, 0, true);
            bg.tSearch.addEventListener(FocusEvent.FOCUS_IN, this.clearText, false, 0, true);
            r = _arg1.r;
            x = r.x;
            y = ((r.y > -1) ? r.y : ((fParent.numChildren > 1) ? ((fParent.getChildAt((fParent.numChildren - 2)).y + fParent.getChildAt((fParent.numChildren - 2)).height) + 10) : 10));
            var point:Point = bg.localToGlobal(new Point(0, 0));
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
            var o:Object = {};
            o.frame = new LPFFrameBackdrop();
            o.fData = null;
            o.r = {
                "x":(14 + 1),
                "y":40,
                "w":290,
                "h":310
            };
            addFrame(o);
            o = {};
            o.frame = new LPFFrameListViewTabbed();
            o.fData = {
                "list":fData.itemsB,
                "isBank":true
            };
            o.r = {
                "x":(20 + 1),
                "y":46,
                "w":265,
                "h":304
            };
            o.tabStates = LPFLayout(fParent).getTabStates(null, true);
            o.sortOrder = LPFLayout(fParent).getSortOrder();
            o.filterMap = LPFLayout(fParent).getFilterMap();
            o.sName = "bank";
            o.itemEventType = "bankSel";
            o.tabEventType = "categorySel";
            o.eventTypes = ["refreshItems", "refreshBank", "categorySel"];
            o.onDemand = false;
            o.openBlank = false;
            o.allowDesel = true;
            o.refreshTabs = true;
            addFrame(o);
            o = {};
            o.frame = new LPFFrameSlotDisplay();
            o.fData = {};
            o.fData.avatar = fData.avatar;
            o.r = {
                "x":96,
                "y":-40,
                "w":-1,
                "h":24
            };
            o.eventTypes = ["refreshItems", "refreshBank", "refreshSlots"];
            o.isBank = true;
            addFrame(o);
            o = {};
            o.frame = new LPFFrameBackdrop();
            o.fData = null;
            o.r = {
                "x":(14 + 581),
                "y":40,
                "w":290,
                "h":310
            };
            addFrame(o);
            o = {};
            o.frame = new LPFFrameGoldDisplay();
            o.fData = fData.objData;
            o.r = {
                "x":-1,
                "y":-75,
                "w":-1,
                "h":24,
                "center":true,
                "centerOn":740,
                "shiftAmount":0
            };
            o.eventTypes = ["refreshCoins"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameSlotDisplay();
            o.fData = fData.objData;
            o.fData.list = fData.itemsI;
            o.r = {
                "x":(32 + 581),
                "y":-40,
                "w":-1,
                "h":24
            };
            o.eventTypes = ["refreshItems", "refreshSlots"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameGenericButton();
            o.fData = {"sText":"Add Space"};
            o.r = {
                "x":(185 + 581),
                "y":-38,
                "w":-1,
                "h":-1
            };
            o.buttonNewEventType = ["buyBagSlots"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameListViewTabbed();
            o.fData = {"list":fData.itemsI};
            o.r = {
                "x":(20 + 581),
                "y":46,
                "w":265,
                "h":270
            };
            o.tabStates = LPFLayout(fParent).getTabStates(null, true);
            o.sortOrder = LPFLayout(fParent).getSortOrder();
            o.filterMap = LPFLayout(fParent).getFilterMap();
            o.sName = "inventory";
            o.itemEventType = "inventorySel";
            o.eventTypes = ["refreshItems", "refreshInventory", "refreshInv"];
            o.allowDesel = true;
            o.openBlank = false;
            o.refreshTabs = true;
            addFrame(o);
            o = {};
            o.frame = new LPFFrameSimpleText();
            o.fData = {"msg":"<p align='center'>Select an item from your Inventory (right) to move that item to the Bank (left), and vice-versa.<br>Selecting an item from both lists allows you to perform a swap.</p>"};
            o.r = {
                "x":-1,
                "y":10,
                "w":200,
                "h":-1,
                "center":true
            };
            addFrame(o);
            o = {};
            o.frame = new LPFFrameGenericButton();
            o.fData = null;
            o.r = {
                "x":402,
                "y":363.5,
                "w":-1,
                "h":-1,
                "center":false
            };
            o.eventTypes = ["previewButton1Update"];
            addFrame(o);
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
        }

        private function onSearch(_arg1:MouseEvent):void
        {
            Game.root.world.bankinfo.search(bg.tSearch.text.toLowerCase());
        }

        private function clearText(_arg1:FocusEvent):void
        {
            if (bg.tSearch.text == "search")
            {
                bg.tSearch.text = "";
            };
        }


    }
}//package Main.Aqw.LPF

