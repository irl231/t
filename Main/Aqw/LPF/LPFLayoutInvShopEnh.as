// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayoutInvShopEnh

package Main.Aqw.LPF
{
    import Main.Model.ShopModel;
    import Main.Model.Item;
    import flash.events.Event;
    import Main.Model.*;
    import flash.events.*;
    import Main.*;

    public class LPFLayoutInvShopEnh extends LPFLayout 
    {

        public var shopinfo:ShopModel;
        public var multiPanel:LPFPanelListShopInvA;
        public var splitPanel:LPFPanelListShopInvB;
        public var previewPanel:LPFPanelPreview;
        private var rootClass:Game = Game.root;
        private var aSel:String = "";
        private var bSel:String = "";


        override public function fOpen(data:Object):void
        {
            super.fOpen(data);
            this.sMode = data.sMode;
            if (("shopinfo" in fData))
            {
                this.shopinfo = this.fData.shopinfo;
            };
            this.x = data.r.x;
            this.y = data.r.y;
            w = data.r.w;
            h = data.r.h;
            this.splitPanel = LPFPanelListShopInvB(addPanel({
                "panel":new LPFPanelListShopInvB(),
                "fData":{
                    "items":this.fData.itemsInv,
                    "sName":"Inventory"
                },
                "r":{
                    "x":322,
                    "y":3,
                    "w":316,
                    "h":495
                },
                "closeType":"hide",
                "hideDir":"right",
                "hidePad":3,
                "isOpen":false
            }));
            this.splitPanel.visible = false;
            this.splitPanel.fHide();
            this.previewPanel = LPFPanelPreview(addPanel({
                "panel":new LPFPanelPreview(),
                "fData":{"sName":"Preview"},
                "r":{
                    "x":322,
                    "y":78,
                    "w":316,
                    "h":420
                },
                "closeType":"hide",
                "xBuffer":3,
                "showDragonLeft":true,
                "isOpen":false
            }));
            this.previewPanel.visible = false;
            this.previewPanel.addEventListener(Event.ENTER_FRAME, this.previewPanelEF, false, 0, true);
            var dataLPFPanelListShopInvA:Object = {
                "panel":new LPFPanelListShopInvA(),
                "fData":{
                    "items":((this.fData.itemsShop != null) ? this.fData.itemsShop : this.fData.itemsInv),
                    "itemsInv":this.fData.itemsInv,
                    "objData":this.fData.objData,
                    "sName":((sMode.toLowerCase().indexOf("shop") > -1) ? this.rootClass.world.shopinfo.sName : "Inventory")
                },
                "r":{
                    "x":641,
                    "y":3,
                    "w":316,
                    "h":495
                },
                "closeType":"close",
                "showDragonRight":true,
                "isOpen":true
            };
            if (this.shopinfo != null)
            {
                dataLPFPanelListShopInvA.fData.shopinfo = this.shopinfo;
            };
            this.multiPanel = LPFPanelListShopInvA(addPanel(dataLPFPanelListShopInvA));
            this.updatePreviewButtons();
        }

        override public function fClose():void
        {
            super.fClose();
            this.previewPanel.removeEventListener(Event.ENTER_FRAME, this.previewPanelEF);
        }

        override protected function handleUpdate(_arg1:Object):Object
        {
            var o:Object;
            var cancelBroadcast:Boolean;
            var iSelPrev:Object;
            var forceO:Object;
            var forceP:Object;
            var sellSel:Item;
            var list:Object;
            var p:Object;
            o = _arg1;
            iSelPrev = iSel;
            var eSelPrev:Object = eSel;
            this.previewPanel.bg.tTitle.text = (((!(iSel == null)) && (!(eSel == null))) ? "Create" : "Preview");
            switch (o.eventType)
            {
                case "sModeSet":
                    if (sMode != o.sModeBroadcast)
                    {
                        sMode = o.sModeBroadcast;
                        iSel = null;
                        eSel = null;
                        o.iSel = iSel;
                        switch (sMode)
                        {
                            case "shopBuy":
                                list = this.fData.itemsShop;
                                break;
                            case "shopSell":
                                list = this.fData.itemsInv;
                                break;
                            case "inventory":
                                list = this.fData.itemsInv;
                                break;
                            case "temporary":
                                list = this.fData.itemsTemp;
                                break;
                        };
                        o.fData = {"list":list};
                        this.splitPanel.fHide();
                        this.previewPanel.fHide();
                    };
                    break;
                case "listItemASel":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        eSel = null;
                        iSel = null;
                        this.aSel = o.fData.sType.toLowerCase();
                        this.bSel = "";
                        if (((this.aSel == "enhancement") || (this.aSel == "boost")))
                        {
                            eSel = o.fData;
                        }
                        else
                        {
                            iSel = o.fData;
                        };
                        switch (o.fData.sType.toLowerCase())
                        {
                            case "enhancement":
                                o.tabStates = getTabStatesEnhancement(o.fData);
                                break;
                            case "boost":
                                o.tabStates = [{
                                    "sTag":"Show All",
                                    "icon":"iipack",
                                    "state":-1,
                                    "filter":"boosted",
                                    "mc":{}
                                }, {
                                    "sTag":"Show only weapons",
                                    "icon":"iwsword",
                                    "state":-1,
                                    "filter":"Weapon_boosted",
                                    "mc":{}
                                }, {
                                    "sTag":"Show only helms",
                                    "icon":"iihelm",
                                    "state":-1,
                                    "filter":"he_boosted",
                                    "mc":{}
                                }, {
                                    "sTag":"Show only capes",
                                    "icon":"iicape",
                                    "state":-1,
                                    "filter":"ba_boosted",
                                    "mc":{}
                                }];
                                break;
                            default:
                                o.tabStates = getTabStates({"sES":"it"});
                        };
                        o.fData = {
                            "iSel":iSel,
                            "eSel":eSel,
                            "oSel":o.fData
                        };
                        this.splitPanel.fHide();
                        this.previewPanel.fShow();
                        if (((iSelPrev == iSel) && (eSelPrev == eSel)))
                        {
                            cancelBroadcast = true;
                        };
                        if (((!(iSel == null)) && (eSel == null)))
                        {
                            this.splitPanel.bg.tTitle.text = "Select Enhancement to Apply";
                        }
                        else
                        {
                            this.splitPanel.bg.tTitle.text = "Select Item to Enhance";
                        };
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "listItemBSel":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        p = this.rootClass.copyObj(o);
                        p.eventType = "listItemBSolo";
                        p.fData = (((o.fData.sType.toLowerCase() == "enhancement") || (o.fData.sType.toLowerCase() == "boost")) ? ({
"iSel":null,
"eSel":p.fData
}) : ({
"iSel":p.fData,
"eSel":null
}));
                        if (((this.bSel == "enhancement") || (this.bSel == "boost")))
                        {
                            eSel = null;
                        }
                        else
                        {
                            if (this.bSel != "")
                            {
                                iSel = null;
                            };
                        };
                        this.bSel = o.fData.sType.toLowerCase();
                        if (((this.bSel == "enhancement") || (this.bSel == "boost")))
                        {
                            eSel = o.fData;
                        }
                        else
                        {
                            iSel = o.fData;
                        };
                        o.fData = {
                            "iSel":iSel,
                            "eSel":eSel
                        };
                        if (((!(iSelPrev == iSel)) || (!(eSelPrev == eSel))))
                        {
                            p.fData.iSel = new Item(p.fData.iSel);
                            notifyByEventType(p);
                        };
                        this.previewPanel.fShow();
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "refreshItems":
                    if (this.fData.itemsInv.indexOf(iSel) == -1)
                    {
                        iSel = null;
                    };
                    if (this.fData.itemsInv.indexOf(eSel) == -1)
                    {
                        eSel = null;
                    };
                    o.fData = {
                        "iSel":iSel,
                        "eSel":eSel
                    };
                    if (o.sInstruction != undefined)
                    {
                        switch (o.sInstruction)
                        {
                            case "closeWindows":
                                this.splitPanel.fHide();
                                this.previewPanel.fHide();
                                break;
                            case "previewEquipOnly":
                                this.splitPanel.fHide();
                                if (((!(iSel == null)) && (!(iSel.bEquip))))
                                {
                                    forceO = {};
                                    forceO.eventType = "previewButton1Update";
                                    forceO.fData = {};
                                    forceO.fData.sText = "Equip";
                                    forceO.sMode = "red";
                                    forceO.r = {
                                        "x":-1,
                                        "y":-40,
                                        "w":-1,
                                        "h":-1
                                    };
                                    forceO.buttonNewEventType = "equipItem";
                                    forceP = {};
                                    forceP.eventType = "previewButton2Update";
                                    forceP.fData = {};
                                    forceP.fData.sText = "";
                                    forceP.sMode = "grey";
                                    forceP.r = {
                                        "x":173,
                                        "y":-40,
                                        "w":-1,
                                        "h":-1
                                    };
                                }
                                else
                                {
                                    this.previewPanel.fHide();
                                };
                                break;
                        };
                    };
                    if (((iSel == null) && (eSel == null)))
                    {
                        this.splitPanel.fHide();
                        this.previewPanel.fHide();
                    };
                    break;
                case "refreshShop":
                    this.rootClass.world.sendReloadShopRequest(this.shopinfo.ShopID);
                    cancelBroadcast = true;
                    break;
                case "showItemListB":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        this.splitPanel.fShow();
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "showItemListBNoBtns":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        forceO = {};
                        forceO.eventType = "previewButton1Update";
                        forceO.fData = {};
                        forceO.fData.sText = "";
                        forceP = {};
                        o.eventType = "showItemListB";
                        this.splitPanel.fShow();
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "equipItem":
                case "unequipItem":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        if ((((!(iSel == null)) && (this.rootClass.toggleItemEquip(iSel))) && (o.eventType == "equipItem")))
                        {
                            this.splitPanel.fHide();
                            this.previewPanel.fHide();
                        };
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "hideItem":
                    if (this.rootClass.world.coolDown("unwearItem"))
                    {
                        this.rootClass.sfc.sendXtMessage("zm", "unwearItem", [iSel.sES], "str", this.rootClass.world.curRoom);
                    };
                    this.splitPanel.fHide();
                    this.previewPanel.fHide();
                    break;
                case "showItem":
                    if (((iSel.bUpg == 1) && (!(this.rootClass.world.myAvatar.isUpgraded()))))
                    {
                        this.rootClass.showUpgradeWindow();
                    }
                    else
                    {
                        if (this.rootClass.world.coolDown("wearItem"))
                        {
                            this.rootClass.sfc.sendXtMessage("zm", "wearItem", [iSel.ItemID], "str", this.rootClass.world.curRoom);
                        };
                        this.splitPanel.fHide();
                        this.previewPanel.fHide();
                    };
                    break;
                case "enhanceItem":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        if (((!(iSel == null)) && (!(eSel == null))))
                        {
                            this.rootClass.tryEnhance(iSel, eSel, (sMode == "shopBuy"));
                        };
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "boostItem":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        if (((!(iSel == null)) && (!(eSel == null))))
                        {
                            this.rootClass.network.send("boostApply", [iSel.ItemID, eSel.ItemID]);
                        };
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
                case "buyItem":
                    if (iSel != null)
                    {
                        this.rootClass.world.sendBuyItemRequest(Item(iSel));
                    }
                    else
                    {
                        if (eSel != null)
                        {
                            this.rootClass.world.sendBuyItemRequest(Item(eSel));
                        };
                    };
                    break;
                case "useItem":
                    if (iSel != null)
                    {
                        if (iSel.iQty > 1)
                        {
                            MainController.modal((("Number of quantity of '" + iSel.sName) + "' to be used:"), this.onUseRequest, {"iSel":iSel}, "white,medium", "dual", true, {
                                "min":1,
                                "max":iSel.iQty
                            });
                        }
                        else
                        {
                            this.rootClass.world.sendUseItemRequest(iSel);
                        };
                    };
                    break;
                case "sellItem":
                    if (iSel != null)
                    {
                        sellSel = iSel;
                    }
                    else
                    {
                        if (eSel != null)
                        {
                            sellSel = eSel;
                        };
                    };
                    if (sellSel.bEquip)
                    {
                        this.rootClass.MsgBox.notify("Item is currently equipped!");
                    }
                    else
                    {
                        if (((sellSel.iQty > 1) && (!(sellSel.sES == "ar"))))
                        {
                            MainController.modal((("Number of quantity of '" + sellSel.sName) + "' to be sold:"), this.onSellRequest, {"iSel":sellSel}, "white,medium", "dual", true, {
                                "min":1,
                                "max":sellSel.iQty
                            });
                        }
                        else
                        {
                            MainController.modal((("Are you sure you want to sell '" + sellSel.sName) + "'?"), this.onSellRequest, {"iSel":sellSel}, "white,medium", "dual", true);
                        };
                    };
                    break;
                case "buyBagSlots":
                    cancelBroadcast = true;
                    this.rootClass.toggleBuySlotPanel();
                    this.fClose();
                    break;
                case "helpAC":
                    cancelBroadcast = true;
                    this.rootClass.world.loadMovieFront("interface/goldAC4.swf", "Inline Asset");
                    break;
            };
            this.updatePreviewButtons(forceO, forceP);
            iSelPrev = null;
            eSelPrev = null;
            if (!cancelBroadcast)
            {
                return (o);
            };
            return (null);
        }

        private function updatePreviewButtons(data1:Object=null, data2:Object=null):void
        {
            if (((!(data1 == null)) && (!(data2 == null))))
            {
                notifyByEventType(data1);
                notifyByEventType(data2);
                return;
            };
            var dataO:Object = {};
            dataO.eventType = "previewButton1Update";
            dataO.fData = {};
            dataO.fData.sText = "";
            dataO.sMode = "grey";
            dataO.r = {
                "x":46,
                "y":-40,
                "w":-1,
                "h":-1
            };
            dataO.buttonNewEventType = "";
            var dataP:Object = {};
            dataP.eventType = "previewButton2Update";
            dataP.fData = {};
            dataP.fData.sText = "";
            dataP.sMode = "grey";
            dataP.r = {
                "x":173,
                "y":-40,
                "w":-1,
                "h":-1
            };
            dataP.buttonNewEventType = "";
            switch (sMode)
            {
                case "temporary":
                case "inventory":
                    if (((iSel == null) && (eSel == null)))
                    {
                        dataO.fData.sText = "";
                        dataO.buttonNewEventType = "";
                        dataP.fData.sText = "";
                        dataP.buttonNewEventType = "";
                    }
                    else
                    {
                        if (((!(iSel == null)) && (!(eSel == null))))
                        {
                            if (eSel.sType.toLowerCase() == "boost")
                            {
                                dataO.fData.sText = "Boost!";
                                dataO.buttonNewEventType = "boostItem";
                                dataO.sMode = "red";
                            }
                            else
                            {
                                dataO.fData.sText = "Enhance!";
                                dataO.buttonNewEventType = "enhanceItem";
                                dataO.sMode = "red";
                            };
                            if (iSel.bEquip)
                            {
                                dataP.fData.sText = "Unequip";
                                dataP.buttonNewEventType = "unequipItem";
                            }
                            else
                            {
                                dataP.fData.sText = "Equip";
                                dataP.buttonNewEventType = "equipItem";
                                if (dataO.sMode != "red")
                                {
                                    dataP.sMode = "red";
                                };
                            };
                        }
                        else
                        {
                            if (((!(eSel == null)) && (!(sMode == "temporary"))))
                            {
                                dataO.fData.sText = "";
                                dataO.buttonNewEventType = "";
                                dataP.fData.sText = "Apply Now";
                                dataP.buttonNewEventType = "showItemListB";
                                dataP.sMode = "red";
                            }
                            else
                            {
                                if (iSel != null)
                                {
                                    if (["Weapon", "he", "ar", "ba", "mi"].indexOf(iSel.sES) > -1)
                                    {
                                        dataO.fData.sText = "Enhance!";
                                        dataO.buttonNewEventType = "showItemListB";
                                        if ((((Config.getBoolean("feature_wear")) && (!(iSel.sES == "ar"))) && (((iSel.bUpg == 1) && (this.rootClass.world.myAvatar.isUpgraded())) || (iSel.bUpg == 0))))
                                        {
                                            if (iSel.bWear)
                                            {
                                                dataO.sMode = "red";
                                                dataO.fData.sText = "Hide";
                                                dataO.buttonNewEventType = "hideItem";
                                            }
                                            else
                                            {
                                                dataO.sMode = "red";
                                                dataO.fData.sText = "Show";
                                                dataO.buttonNewEventType = "showItem";
                                            };
                                        };
                                        if (iSel.EnhLvl == -1)
                                        {
                                            dataO.sMode = "red";
                                        }
                                        else
                                        {
                                            dataP.sMode = "red";
                                        };
                                        if (iSel.bEquip)
                                        {
                                            dataP.fData.sText = "Unequip";
                                            dataP.buttonNewEventType = "unequipItem";
                                        }
                                        else
                                        {
                                            dataP.fData.sText = "Equip";
                                            dataP.buttonNewEventType = "equipItem";
                                        };
                                    }
                                    else
                                    {
                                        if (((((((iSel.sES == "mi") || (iSel.sType.toLowerCase() == "entity")) || (iSel.sType.toLowerCase() == "pet")) || ((((iSel.sType.toLowerCase() == "item") && (!(iSel.sLink == ""))) && (!(iSel.sLink == " "))) && (!(iSel.sLink.toLowerCase() == "none")))) || (iSel.sES == "co")) || (iSel.sES == "am")))
                                        {
                                            if ((((Config.getBoolean("feature_wear")) && (((iSel.bUpg == 1) && (this.rootClass.world.myAvatar.isUpgraded())) || (iSel.bUpg == 0))) && ((iSel.sES == "co") || (iSel.sES == "pe"))))
                                            {
                                                if (iSel.bWear)
                                                {
                                                    dataO.fData.sText = "Hide";
                                                    dataO.buttonNewEventType = "hideItem";
                                                }
                                                else
                                                {
                                                    dataO.fData.sText = "Show";
                                                    dataO.buttonNewEventType = "showItem";
                                                };
                                                dataO.sMode = "red";
                                            };
                                            dataP.sMode = "red";
                                            if (iSel.bEquip)
                                            {
                                                dataP.fData.sText = "Unequip";
                                                dataP.buttonNewEventType = "unequipItem";
                                            }
                                            else
                                            {
                                                dataP.fData.sText = "Equip";
                                                dataP.buttonNewEventType = "equipItem";
                                            };
                                        };
                                        switch (iSel.sType.toLowerCase())
                                        {
                                            case "serveruse":
                                            case "clientuse":
                                                dataP.sMode = "red";
                                                dataP.fData.sText = "Use";
                                                dataP.buttonNewEventType = "useItem";
                                                break;
                                            case "boost":
                                                dataP.fData.sText = "Apply Now";
                                                dataP.buttonNewEventType = "showItemListB";
                                                dataP.sMode = "red";
                                                break;
                                        };
                                    };
                                };
                            };
                        };
                    };
                    break;
                case "shopBuy":
                    if (((iSel == null) && (eSel == null)))
                    {
                        dataO.fData.sText = "";
                        dataO.buttonNewEventType = "";
                        dataP.fData.sText = "";
                        dataP.buttonNewEventType = "";
                    }
                    else
                    {
                        if (((!(iSel == null)) && (!(eSel == null))))
                        {
                            dataO.fData.sText = "";
                            dataO.buttonNewEventType = "";
                            dataP.fData.sText = "Enhance!";
                            dataP.buttonNewEventType = "enhanceItem";
                            dataP.sMode = "red";
                        }
                        else
                        {
                            if (eSel != null)
                            {
                                dataO.fData.sText = "Buy and Hold";
                                dataO.buttonNewEventType = "buyItem";
                                dataP.fData.sText = "Apply Now";
                                dataP.buttonNewEventType = "showItemListBNoBtns";
                                dataP.sMode = "red";
                            }
                            else
                            {
                                if (iSel != null)
                                {
                                    if (((this.shopinfo.bLimited) && (iSel.iQtyRemain <= 0)))
                                    {
                                        dataO.fData.sText = "";
                                        dataO.buttonNewEventType = "";
                                        dataP.fData.sText = "Sold Out!";
                                        dataP.buttonNewEventType = "none";
                                        dataP.sMode = "grey";
                                    }
                                    else
                                    {
                                        dataO.fData.sText = "";
                                        dataO.buttonNewEventType = "";
                                        dataP.fData.sText = "Buy";
                                        dataP.buttonNewEventType = "buyItem";
                                        dataP.sMode = "red";
                                    };
                                };
                            };
                        };
                    };
                    break;
                case "shopSell":
                    if (((iSel == null) && (eSel == null)))
                    {
                        dataO.fData.sText = "";
                        dataO.buttonNewEventType = "";
                        dataP.fData.sText = "";
                        dataP.buttonNewEventType = "";
                    }
                    else
                    {
                        dataO.fData.sText = "";
                        dataO.buttonNewEventType = "";
                        dataP.fData.sText = "Sell";
                        dataP.buttonNewEventType = "sellItem";
                        dataP.sMode = "red";
                    };
                    break;
            };
            notifyByEventType(dataO);
            notifyByEventType(dataP);
        }

        private function onSellRequest(event:Object):void
        {
            var quantity:int;
            if (event.accept)
            {
                quantity = 1;
                if (event.iQty != null)
                {
                    quantity = event.iQty;
                };
                this.rootClass.world.sendSellItemRequest(event.iSel, quantity);
            };
        }

        private function onUseRequest(event:Object):void
        {
            var quantity:int;
            if (event.accept)
            {
                quantity = 1;
                if (event.iQty != null)
                {
                    quantity = event.iQty;
                };
                this.rootClass.world.sendUseItemRequest(event.iSel, quantity);
            };
        }

        private function previewPanelEF(_arg1:Event):void
        {
            var _local2:Number = this.previewPanel.x;
            var _local3:Number = ((this.splitPanel.x - this.previewPanel.w) - this.previewPanel.xBuffer);
            var _local4:Number = (_local3 - _local2);
            if (((_local4 > 20) || (this.splitPanel.visible)))
            {
                this.previewPanel.x = ((this.splitPanel.x - this.previewPanel.w) - this.previewPanel.xBuffer);
            };
        }


    }
}//package Main.Aqw.LPF

