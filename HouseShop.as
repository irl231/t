// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//HouseShop

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import Main.Model.Item;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Aqw.LPF.*;
    import Main.Aqw.*;
    import Main.*;

    public class HouseShop extends MovieClip 
    {

        public var tabInv:MovieClip;
        public var btnPreview:SimpleButton;
        public var strGold:TextField;
        public var strCost:TextField;
        public var mcItemList:ItemList;
        public var mcCoin:MovieClip;
        public var strInfo:TextField;
        public var mcUpgrade:MovieClip;
        public var txtTitle:TextField;
        public var txtAction:TextField;
        public var bg1:MovieClip;
        public var tabShop:MovieClip;
        public var bg2:MovieClip;
        public var btnAction:SimpleButton;
        public var mcShopList:ItemList;
        public var strCoins:TextField;
        private var rootClass:Game;
        private var bitShop:Boolean = true;

        public function HouseShop()
        {
            this.rootClass = Game(parent.parent.parent);
            super();
            this.bg1.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.btnPreview.addEventListener(MouseEvent.CLICK, this.onPreviewClick, false, 0, true);
            this.btnAction.addEventListener(MouseEvent.CLICK, this.onActionClick, false, 0, true);
            this.tabShop.addEventListener(MouseEvent.CLICK, this.onClickShop, false, 0, true);
            this.tabInv.addEventListener(MouseEvent.CLICK, this.onClickInv, false, 0, true);
            this.mcShopList.inventorySlot = this.rootClass.world.shopinfo.items.length;
            this.mcShopList.init(this.rootClass.world.shopinfo.items);
            this.mcItemList.inventorySlot = this.rootClass.world.myAvatar.houseitems.length;
            this.mcItemList.init(this.rootClass.world.myAvatar.houseitems);
            this.txtAction.mouseEnabled = false;
            this.updateGoldCoin();
            this.onClickShop(null);
        }

        public function get selectedItem():Item
        {
            return ((this.bitShop) ? this.mcShopList.selectedItem : this.mcItemList.selectedItem);
        }

        public function refreshDetail():void
        {
            if (this.selectedItem == null)
            {
                this.strInfo.htmlText = "Please select an item to view details.";
                this.txtAction.visible = false;
                this.btnAction.visible = false;
                this.btnPreview.visible = false;
                this.strCost.text = "";
                this.mcCoin.visible = (this.mcUpgrade.visible = false);
            }
            else
            {
                this.showItemDetail();
            };
        }

        public function showItemDetail():void
        {
            var item:Item;
            var _local2:* = "#cc9900";
            if (this.bitShop)
            {
                item = this.selectedItem;
                this.strInfo.htmlText = this.rootClass.getItemInfoString(item);
                if ((((item.bCoins == 0) && (item.iCost > this.rootClass.world.myAvatar.objData.intGold)) || ((item.bCoins == 1) && (item.iCost > this.rootClass.world.myAvatar.objData.intCoins))))
                {
                    _local2 = "#cc0000";
                };
                this.strCost.htmlText = ((item.bCoins == 0) ? (((("<font size='14' color='" + _local2) + "'><b>") + Number(item.iCost)) + " Gold</b></font>") : (((("<font size='14' color='" + _local2) + "'><b>") + Number(item.iCost)) + " ACs</b></font>"));
                this.txtAction.text = "Buy";
                this.btnPreview.visible = true;
            }
            else
            {
                item = this.selectedItem;
                this.strInfo.htmlText = this.rootClass.getItemInfoString(item);
                this.strCost.htmlText = ((item.bCoins == 0) ? ((this.rootClass.world.myAvatar.objData.intGold > 2000000) ? (("<font size='14' color='" + _local2) + "'><b>0 Gold</b></font>") : (((("<font size='14' color='" + _local2) + "'><b>") + Math.ceil((item.iCost / 4))) + " Gold</b></font>")) : ((item.iHrs < 24) ? (((("<font size='14' color='" + _local2) + "'><b>") + Math.ceil(((item.iCost * 9) / 10))) + " ACs</b></font>") : (((("<font size='14' color='" + _local2) + "'><b>") + Math.ceil((item.iCost / 4))) + " ACs</b></font>")));
                this.txtAction.text = "Sell";
                this.btnPreview.visible = false;
            };
            this.txtAction.visible = true;
            this.btnAction.visible = true;
            this.mcCoin.visible = (item.bCoins == 1);
            this.mcUpgrade.visible = (item.bUpg == 1);
        }

        public function updateGoldCoin():void
        {
            this.strGold.text = this.rootClass.world.myAvatar.objData.intGold;
            this.strCoins.text = this.rootClass.world.myAvatar.objData.intCoins;
        }

        public function onBuyClick():void
        {
            switch (true)
            {
                case (((this.rootClass.world.shopinfo.bStaff == 1) || (this.selectedItem.bStaff == 1)) && (this.rootClass.world.myAvatar.objData.intAccessLevel < 40)):
                    this.rootClass.MsgBox.notify("Test Item.. cannot be purchased yet!");
                    break;
                case ((!(this.rootClass.world.shopinfo.sField == "")) && (!(Achievement.getAchievement(this.rootClass.world.shopinfo.sField, this.rootClass.world.shopinfo.iIndex) == 1))):
                    this.rootClass.MsgBox.notify("Item requires special requirement!");
                    break;
                case ((this.selectedItem.bUpg == 1) && (!(this.rootClass.world.myAvatar.isUpgraded()))):
                    this.rootClass.showUpgradeWindow();
                    break;
                case ((this.selectedItem.FactionID > 1) && (this.rootClass.world.myAvatar.getRep(this.selectedItem.FactionID) < this.selectedItem.iReqRep)):
                    this.rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                    break;
                case ((this.selectedItem.iClass > 0) && (this.rootClass.world.myAvatar.getCPByID(this.selectedItem.iClass) < this.selectedItem.iReqCP)):
                    this.rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
                    break;
                case (((this.rootClass.world.myAvatar.isItemInInventory(this.selectedItem.ItemID)) || (this.rootClass.world.myAvatar.isItemInBank(this.selectedItem.ItemID))) && (this.rootClass.world.myAvatar.isItemStackMaxed(this.selectedItem.ItemID))):
                    this.rootClass.MsgBox.notify((("You cannot have more than " + ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"][this.selectedItem.iStk]) + " of that item!"));
                    break;
                case (((this.selectedItem.bCoins == 0) && (this.selectedItem.iCost > this.rootClass.world.myAvatar.objData.intGold)) || ((this.selectedItem.bCoins == 1) && (this.selectedItem.iCost > this.rootClass.world.myAvatar.objData.intCoins))):
                    this.rootClass.MsgBox.notify("Insufficient Funds!");
                    break;
                case (this.rootClass.world.myAvatar.houseitems.length >= this.rootClass.world.myAvatar.objData.iHouseSlots):
                    this.rootClass.MsgBox.notify("House Inventory Full!");
                    break;
                default:
                    MainController.modal((('Are you sure you want to buy "' + this.selectedItem.sName) + '"?'), this.buyRequest, {"item":this.selectedItem}, "red,medium", "dual");
            };
        }

        public function buyRequest(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.world.sendBuyItemRequest(obj.item);
            };
        }

        public function onSellClick():void
        {
            if (this.selectedItem.bEquip)
            {
                this.rootClass.MsgBox.notify("Item is currently equipped!");
            }
            else
            {
                if (this.selectedItem.bTemp == 0)
                {
                    MainController.modal((('Are you sure you want to sell "' + this.selectedItem.sName) + '"?'), this.sellRequest, {"item":this.selectedItem}, null, null);
                };
            };
        }

        public function sellRequest(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.world.sendSellItemRequest(obj.item);
            };
        }

        public function reset():void
        {
            this.mcItemList.inventorySlot = this.rootClass.world.myAvatar.houseitems.length;
            this.mcItemList.init(this.rootClass.world.myAvatar.houseitems);
            this.updateGoldCoin();
        }

        public function onActionClick(_arg1:Event):void
        {
            if (this.bitShop)
            {
                this.onBuyClick();
            }
            else
            {
                this.onSellClick();
            };
        }

        public function onPreviewClick(mouseEvent:MouseEvent):void
        {
            switch (this.selectedItem.sType)
            {
                case "Floor Item":
                case "Wall Item":
                case "House":
                    LPFLayoutChatItemPreview.linkItem(this.selectedItem);
                    break;
            };
        }

        private function onCloseClick(_arg1:Event):void
        {
            MovieClip(parent).onClose();
        }

        private function onClickShop(_arg1:Event):void
        {
            this.tabShop.select();
            this.tabInv.unselect();
            this.mcShopList.visible = true;
            this.mcItemList.visible = false;
            this.txtTitle.text = "Shop";
            this.bitShop = true;
            this.refreshDetail();
        }

        private function onClickInv(_arg1:Event):void
        {
            this.tabShop.unselect();
            this.tabInv.select();
            this.mcShopList.visible = false;
            this.mcItemList.visible = true;
            this.txtTitle.text = "Inventory";
            this.bitShop = false;
            this.refreshDetail();
        }


    }
}//package 

