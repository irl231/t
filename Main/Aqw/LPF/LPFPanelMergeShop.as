// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelMergeShop

package Main.Aqw.LPF
{
    import flash.geom.Point;
    import flash.events.*;
    import flash.geom.*;

    public class LPFPanelMergeShop extends LPFPanel 
    {

        public var rootClass:Game = Game.root;

        public function LPFPanelMergeShop():void
        {
            x = 0;
            y = 0;
            frames = [];
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            var _local2:Object;
            var _local6:int;
            fData = _arg1.fData;
            drawBG(LPFPanelBg2);
            bg.tPane1.text = "Preview";
            bg.tPane2.text = "Cost";
            bg.tPane3.text = "Item List";
            bg.tSearch.visible = false;
            bg.mcSearch.visible = false;
            _local2 = _arg1.r;
            x = _local2.x;
            if (_local2.y > -1)
            {
                y = _local2.y;
            }
            else
            {
                _local6 = fParent.numChildren;
                if (_local6 > 1)
                {
                    y = ((fParent.getChildAt((_local6 - 2)).y + fParent.getChildAt((_local6 - 2)).height) + 10);
                }
                else
                {
                    y = 10;
                };
            };
            var _local3:Point = new Point(0, 0);
            _local3 = bg.localToGlobal(_local3);
            bg.y = (bg.y - int((_local2.y - _local3.y)));
            w = _local2.w;
            h = _local2.h;
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
                "x":15,
                "y":36,
                "w":290,
                "h":204
            };
            addFrame(o);
            o = {};
            o.frame = new LPFFrameBackdrop();
            o.fData = null;
            o.r = {
                "x":15,
                "y":244,
                "w":290,
                "h":121
            };
            addFrame(o);
            o = {};
            o.frame = new LPFFrameItemPreview();
            o.fData = null;
            o.r = {
                "x":19,
                "y":40,
                "w":284,
                "h":-1
            };
            o.eventTypes = ["listItemASel"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameEnhText();
            o.fData = null;
            o.r = {
                "x":19,
                "y":245,
                "w":284,
                "h":-1
            };
            o.eventTypes = ["listItemASel"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameBackdrop();
            o.fData = null;
            o.r = {
                "x":(14 + 581),
                "y":44,
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
            o.fData.list = fData.itemsInv;
            o.r = {
                "x":(15 + 581),
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
            var _local5:int = 50;
            o = {};
            o.frame = new LPFFrameListViewTabbed();
            o.fData = {
                "list":fData.items,
                "bLimited":(("bLimited" in this.rootClass.world.shopinfo) ? this.rootClass.world.shopinfo.bLimited : false)
            };
            o.r = {
                "x":(20 + 581),
                "y":_local5,
                "w":265,
                "h":270
            };
            o.tabStates = LPFLayout(fParent).getTabStates();
            o.sortOrder = LPFLayout(fParent).getSortOrder();
            o.filterMap = LPFLayout(fParent).getFilterMap();
            o.sName = "itemListA";
            o.itemEventType = "listItemASel";
            addFrame(o);
            o = {};
            o.frame = new LPFFrameSimpleText();
            o.fData = {"msg":"<p align='center'>Select an item from the list. Below are the required parts to buy the desired item.</p>"};
            o.r = {
                "x":-1,
                "y":71,
                "w":200,
                "h":-1,
                "center":true
            };
            addFrame(o);
            o = {};
            o.frame = new LPFFrameSimpleList();
            o.fData = {"msg":"<p align='center'>Items must be in your backpack to appear.</p>"};
            o.r = {
                "x":327,
                "y":140,
                "w":240,
                "h":-1,
                "center":false
            };
            o.eventTypes = ["refreshItems", "listItemASel"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameCostDisplay();
            o.fData = null;
            o.r = {
                "x":450,
                "y":-70,
                "w":-1,
                "h":-1,
                "xPosRule":"centerOnX"
            };
            o.eventTypes = ["listItemASel"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameGenericButton();
            o.fData = null;
            o.r = {
                "x":-1,
                "y":-40,
                "w":250,
                "h":-1,
                "center":true
            };
            o.eventTypes = ["previewButton1Update"];
            addFrame(o);
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
        }


    }
}//package Main.Aqw.LPF

