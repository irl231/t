// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelBg5

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import fl.motion.AdjustColor;
    import flash.filters.ColorMatrixFilter;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import fl.motion.*;
    import flash.filters.*;
    import Main.*;

    public dynamic class LPFPanelBg5 extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var bg:MovieClip;
        public var mcVending:MovieClip;
        public var btnClose:SimpleButton;
        public var btnPurchase:SimpleButton;
        public var btnSell:SimpleButton;
        public var btnCheckout:SimpleButton;
        public var btnVend:SimpleButton;
        public var btnSellHP:SimpleButton;
        public var btnCheckoutHP:SimpleButton;
        public var btnCheckoutAll:SimpleButton;
        public var tTitle:TextField;
        public var tPane1:TextField;
        public var tPane2:TextField;
        public var tPane3:TextField;
        public var tPane4:TextField;
        public var tButton1:TextField;
        public var tButton2:TextField;
        public var tButton3:TextField;
        public var txtSellGold:TextField;
        public var txtSellCoins:TextField;
        private var ButtonColor:AdjustColor = new AdjustColor();
        private var Filter:ColorMatrixFilter;

        public function LPFPanelBg5()
        {
            addFrameScript(1, this.purchase, 2, this.sell, 3, this.retrieve);
        }

        public function sendSellAuctionItemRequest(evt:Object):void
        {
            if (evt.bEquip == 1)
            {
                MainController.modal("You must unequip the item before offering it!", null, {}, "red,medium", "mono");
                this.rootClass.auctionItem2.alpha = 1;
                this.rootClass.auctionItem2.mouseEnabled = true;
                return;
            };
            MainController.modal(((this.rootClass.vendingOwner == "") ? (("Are you sure you want to list '" + evt.sName) + "' on Market?") : (("Are you sure you want to list '" + evt.sName) + "' on Vending Shop?")), this.sellConfirm, {"item":evt}, "white,medium", "dual");
            this.rootClass.auctionItem2.alpha = 0.5;
            this.rootClass.auctionItem2.mouseEnabled = false;
        }

        private function purchase():void
        {
            this.initButtons();
            this.rootClass.auctionLabels = 1;
            this.tTitle.mouseEnabled = false;
            this.tPane1.mouseEnabled = false;
            this.tPane2.mouseEnabled = false;
            this.tPane3.mouseEnabled = false;
            this.tPane4.mouseEnabled = false;
            this.rootClass.world.marketController.sendLoadAuctionRequest(["All", this.rootClass.vendingOwner]);
            this.rootClass.auctionItem1.visible = true;
            this.rootClass.auctionItem2.visible = false;
            this.rootClass.auctionItem3.visible = false;
            this.rootClass.auctionLayout.iSel = null;
            this.rootClass.auctionLayout.updatePreviewButtons();
            this.rootClass.auctionItem1.mouseEnabled = true;
            this.rootClass.auctionItem2.mouseEnabled = true;
            this.rootClass.auctionItem3.mouseEnabled = true;
            stop();
        }

        private function sell():void
        {
            this.initButtons();
            this.rootClass.auctionLabels = 2;
            this.txtSellGold.restrict = "0-9";
            this.txtSellCoins.restrict = "0-9";
            this.tButton1.text = "Sell";
            this.tButton1.mouseEnabled = false;
            this.btnSellHP.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            stop();
        }

        private function retrieve():void
        {
            this.initButtons();
            this.rootClass.auctionLabels = 3;
            this.tButton1.text = "Checkout";
            this.tButton2.text = "Checkout All";
            this.tButton1.mouseEnabled = false;
            this.tButton2.mouseEnabled = false;
            this.btnCheckoutHP.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnCheckoutAll.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            stop();
        }

        private function qtyRequest(evt:Object):void
        {
            if (evt.accept)
            {
                this.rootClass.auctionLayout.iSel.Quantity = 1;
                if (evt.iQty != null)
                {
                    this.rootClass.auctionLayout.iSel.Quantity = evt.iQty;
                };
                this.sendSellAuctionItemRequest(this.rootClass.auctionLayout.iSel);
                this.rootClass.auctionLayout.iSel = null;
            }
            else
            {
                this.btnSellHP.alpha = 1;
                this.btnSellHP.mouseEnabled = true;
                this.rootClass.auctionItem2.alpha = 1;
                this.rootClass.auctionItem2.mouseEnabled = true;
            };
        }

        private function vendRequest(evt:Object):void
        {
            var uoLeaf:Object;
            if (evt.accept)
            {
                uoLeaf = this.rootClass.world.uoTree[this.rootClass.world.myAvatar.objData.strUsername.toLowerCase()];
                if (!uoLeaf.vend)
                {
                    this.rootClass.world.vendingStart();
                    this.tButton3.text = "Stop Vending";
                }
                else
                {
                    this.rootClass.world.vendingPostpone();
                    this.tButton3.text = "Activate Vending";
                };
            };
        }

        private function sellConfirm(evt:Object):void
        {
            if (evt.accept)
            {
                this.rootClass.network.send("sellAuctionItem", [evt.item.ItemID, evt.item.CharItemID, evt.item.Quantity, this.txtSellCoins.text, this.txtSellGold.text, this.rootClass.vendingOwner]);
            };
            this.btnSellHP.alpha = 1;
            this.btnSellHP.mouseEnabled = true;
            this.txtSellCoins.text = "";
            this.txtSellGold.text = "";
            this.rootClass.auctionItem2.alpha = 1;
            this.rootClass.auctionItem2.mouseEnabled = true;
        }

        private function initButtons():void
        {
            var uoLeaf:Object;
            this.btnVend.visible = false;
            this.tButton3.visible = false;
            this.btnPurchase.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnSell.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnCheckout.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            if (this.rootClass.vendingOwner != this.rootClass.world.myAvatar.objData.strUsername)
            {
                this.ButtonColor.brightness = 0;
                this.ButtonColor.contrast = 0;
                this.ButtonColor.saturation = 0;
                this.ButtonColor.hue = 0;
                this.Filter = new ColorMatrixFilter(this.ButtonColor.CalculateFinalFlatArray());
                this.btnSell.filters = [this.Filter];
                this.btnCheckout.filters = [this.Filter];
            }
            else
            {
                if (this.rootClass.vendingOwner == this.rootClass.world.myAvatar.objData.strUsername)
                {
                    uoLeaf = this.rootClass.world.uoTree[this.rootClass.world.myAvatar.objData.strUsername.toLowerCase()];
                    this.tButton3.text = ((uoLeaf.vend) ? "Stop Vending" : "Activate Vending");
                    this.btnVend.visible = true;
                    this.tButton3.visible = true;
                    this.tButton3.mouseEnabled = false;
                    this.btnVend.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
                };
            };
        }

        private function checkOutConfirm(evt:Object):void
        {
            if (evt.accept)
            {
                this.rootClass.network.send("retrieveAuctionItem", [evt.item.AuctionID, this.rootClass.vendingOwner]);
            };
            this.rootClass.auctionItem3.alpha = 1;
            this.rootClass.auctionItem3.mouseEnabled = true;
        }

        private function auctionConfirm(evt:Object):void
        {
            if (evt.accept)
            {
                this.rootClass.network.send("retrieveAuctionItems", [this.rootClass.vendingOwner]);
            };
            this.btnCheckoutAll.alpha = 1;
            this.btnCheckoutAll.mouseEnabled = true;
        }

        private function onClick(event:MouseEvent):void
        {
            var isQty:int;
            var uoLeaf:Object;
            switch (event.currentTarget.name)
            {
                case "btnPurchase":
                    this.rootClass.world.marketController.reset();
                    this.rootClass.auctionItem1.visible = true;
                    this.rootClass.auctionItem2.visible = false;
                    this.rootClass.auctionItem3.visible = false;
                    this.rootClass.auctionLayout.iSel = null;
                    this.rootClass.auctionLayout.tab = 1;
                    this.rootClass.auctionLayout.updatePreviewButtons();
                    if (this.rootClass.ui.mcPopup.currentLabel == "AuctionPanel")
                    {
                        LPFLayoutAuction(this.rootClass.ui.mcPopup.getChildByName("mcAuction")).update({"eventType":"refreshItems"});
                        this.rootClass.auctionTabs.mcSeller.Param1.text = "SELLER";
                    }
                    else
                    {
                        LPFLayoutAuction(this.rootClass.ui.mcPopup.getChildByName("mcVending")).update({"eventType":"refreshItems"});
                    };
                    gotoAndPlay("Purchase");
                    break;
                case "btnSell":
                    if (((!(this.rootClass.vendingOwner == "")) && (!(this.rootClass.vendingOwner == this.rootClass.world.myAvatar.objData.strUsername))))
                    {
                        this.rootClass.MsgBox.notify((("You are not allowed to access a restricted area of " + this.rootClass.vendingOwner) + "'s Vending Shop."));
                    }
                    else
                    {
                        this.rootClass.auctionItem1.visible = false;
                        this.rootClass.auctionItem2.visible = true;
                        this.rootClass.auctionItem3.visible = false;
                        this.rootClass.auctionLayout.iSel = null;
                        this.rootClass.auctionLayout.tab = 2;
                        this.rootClass.auctionLayout.updatePreviewButtons();
                        if (this.rootClass.ui.mcPopup.currentLabel == "AuctionPanel")
                        {
                            MovieClip(this.rootClass.ui.mcPopup.getChildByName("mcAuction")).update({"eventType":"refreshItems"});
                        }
                        else
                        {
                            MovieClip(this.rootClass.ui.mcPopup.getChildByName("mcVending")).update({"eventType":"refreshItems"});
                        };
                        gotoAndPlay("Sell");
                    };
                    break;
                case "btnCheckout":
                    if (((!(this.rootClass.vendingOwner == "")) && (!(this.rootClass.vendingOwner == this.rootClass.world.myAvatar.objData.strUsername))))
                    {
                        this.rootClass.MsgBox.notify((("You are not allowed to access a restricted area of " + this.rootClass.vendingOwner) + "'s Vending Shop."));
                    }
                    else
                    {
                        this.rootClass.auctionItem1.visible = false;
                        this.rootClass.auctionItem2.visible = false;
                        this.rootClass.auctionItem3.visible = true;
                        this.rootClass.auctionLayout.iSel = null;
                        this.rootClass.auctionLayout.tab = 3;
                        this.rootClass.auctionLayout.updatePreviewButtons();
                        this.rootClass.world.marketController.retrieveReset();
                        this.rootClass.world.marketController.sendLoadRetrieveRequest(["All", this.rootClass.vendingOwner]);
                        this.rootClass.auctionTabs.mcSeller.Param1.text = "STATUS";
                        LPFLayoutAuction(this.rootClass.ui.mcPopup.getChildByName("mcAuction")).update({"eventType":"refreshItems"});
                        if (this.rootClass.vendingOwner != "")
                        {
                            this.rootClass.auctionTabs.mcDuration.visible = true;
                            this.rootClass.auctionTabs.mcDuration.tText.text = "STATUS";
                        };
                        gotoAndPlay("Retrieve");
                    };
                    break;
                case "btnSellHP":
                    isQty = this.rootClass.auctionLayout.iSel.iQty;
                    this.rootClass.auctionLayout.iSel.auctionGold = int(this.txtSellGold.text);
                    this.rootClass.auctionLayout.iSel.auctionCoins = int(this.txtSellCoins.text);
                    this.btnSellHP.alpha = 0.5;
                    this.btnSellHP.mouseEnabled = false;
                    if (this.txtSellCoins.length == 0)
                    {
                        this.txtSellCoins.text = "0";
                    };
                    if (this.txtSellGold.length == 0)
                    {
                        this.txtSellGold.text = "0";
                    };
                    if (((isQty > 1) && (!(this.rootClass.auctionLayout.iSel.sES == "ar"))))
                    {
                        MainController.modal("Please specify item quantity you want to sell.", this.qtyRequest, {}, "white,medium", "dual", true, ((isQty > 1) ? ({
"min":1,
"max":isQty
}) : (null)));
                    }
                    else
                    {
                        this.rootClass.auctionLayout.iSel.Quantity = isQty;
                        this.sendSellAuctionItemRequest(this.rootClass.auctionLayout.iSel);
                    };
                    break;
                case "btnVend":
                    uoLeaf = this.rootClass.world.uoTree[this.rootClass.world.myAvatar.objData.strUsername.toLowerCase()];
                    MainController.modal(((uoLeaf.vend) ? "Would you like to stop Vending?" : "Are you sure you want to Vend the current items along with their price?"), this.vendRequest, {}, "red,medium", "dual", true);
                    break;
                case "btnCheckoutHP":
                    this.rootClass.auctionItem3.alpha = 0.5;
                    this.rootClass.auctionItem3.mouseEnabled = false;
                    MainController.modal((("Are you sure you want to check out " + this.rootClass.auctionLayout.iSel.sName) + "?"), this.checkOutConfirm, {"item":this.rootClass.auctionLayout.iSel}, "white,medium", "dual", true);
                    break;
                case "btnCheckoutAll":
                    this.btnCheckoutAll.alpha = 0.5;
                    this.btnCheckoutAll.mouseEnabled = false;
                    MainController.modal(((this.rootClass.ui.mcPopup.currentLabel == "AuctionPanel") ? "Are you sure you want to check out all items? These will include your items that are still listed in Market." : "Are you sure you want to check out all items? These will include your items that are still listed in Vending Shop."), this.auctionConfirm, {"item":""}, "white,medium", "dual");
                    break;
            };
        }


    }
}//package Main.Aqw.LPF

