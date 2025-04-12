// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelListShopInvA

package Main.Aqw.LPF
{
    import flash.events.*;

    public class LPFPanelListShopInvA extends LPFPanel 
    {


        override public function fOpen(data:Object):void
        {
            super.fOpen(data);
            if (data.closeType != undefined)
            {
                closeType = data.closeType;
            };
            if (data.hideDir != undefined)
            {
                hideDir = data.hideDir;
            };
            if (data.hidePad != undefined)
            {
                hidePad = data.hidePad;
            };
            addFrame({
                "frame":new LPFFrameBackdrop(),
                "fData":null,
                "r":{
                    "x":14,
                    "y":44,
                    "w":(w - 26),
                    "h":396
                }
            });
            addFrame({
                "frame":new LPFFrameGoldDisplay(),
                "fData":fData.objData,
                "r":{
                    "x":-180,
                    "y":-89,
                    "w":-1,
                    "h":24
                },
                "eventTypes":["refreshCoins"]
            });
            var object1:Object = {
                "frame":new LPFFrameSlotDisplay(),
                "fData":fData.objData,
                "r":{
                    "x":32,
                    "y":-40,
                    "w":-1,
                    "h":24
                },
                "eventTypes":["refreshItems", "refreshSlots"]
            };
            object1.fData.list = fData.itemsInv;
            addFrame(object1);
            addFrame({
                "frame":new LPFFrameGenericButton(),
                "fData":{"sText":"Add Space"},
                "r":{
                    "x":185,
                    "y":-38,
                    "w":-1,
                    "h":-1
                },
                "buttonNewEventType":["buyBagSlots"]
            });
            addFrame({
                "frame":new LPFFrameCheapBuySell(),
                "fData":{
                    "textLeft":((fData.shopinfo == undefined) ? "Inventory" : "Buy"),
                    "textRight":((fData.shopinfo == undefined) ? "Temporary" : "Sell"),
                    "sMode1":((fData.shopinfo != undefined) ? "shopSell" : "temporary"),
                    "sMode2":((fData.shopinfo != undefined) ? "shopBuy" : "inventory")
                },
                "eventType":"sModeSet",
                "openOn":"shopBuy",
                "r":{
                    "x":20,
                    "y":365,
                    "w":-1,
                    "h":-1
                }
            });
            addFrame({
                "frame":new LPFFrameListViewTabbed(),
                "fData":{
                    "list":fData.items,
                    "bLimited":(((!(fData.shopinfo == undefined)) && (!(fData.shopinfo.bLimited == undefined))) ? fData.shopinfo.bLimited : false)
                },
                "r":{
                    "x":20,
                    "y":50,
                    "w":265,
                    "h":315
                },
                "tabStates":fParent.getTabStates(),
                "sortOrder":fParent.getSortOrder(),
                "filterMap":fParent.getFilterMap(),
                "sName":"itemListA",
                "itemEventType":"listItemASel",
                "eventTypes":["refreshItems", "sModeSet", "refreshInv"]
            });
            drawBG();
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            if (!(("showDragonLeft" in data) && (data.showDragonLeft)))
            {
                bg.dragonLeft.visible = false;
            };
            if (!(("showDragonRight" in data) && (data.showDragonRight)))
            {
                bg.dragonRight.visible = false;
            };
        }


    }
}//package Main.Aqw.LPF

