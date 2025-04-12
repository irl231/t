// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildShop

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Aqw.LPF.*;
    import Main.Aqw.*;
    import Main.*;

    public class GuildShop extends MovieClip 
    {

        public var tabInv:MovieClip;
        public var btnPreview:SimpleButton;
        public var strGold:TextField;
        public var strCost:TextField;
        public var mcCoin:MovieClip;
        public var strInfo:TextField;
        public var mcUpgrade:MovieClip;
        public var txtTitle:TextField;
        public var txtAction:TextField;
        public var bg1:MovieClip;
        public var tabShop:MovieClip;
        public var bg2:MovieClip;
        public var btnAction:SimpleButton;
        public var strCoins:TextField;
        private var game:Game;
        private var Parent:GuildMenu;
        private var bitShop:Boolean = true;
        private var shopinfo:Object;
        private var mcShopList:ItemList;
        private var mcItemList:ItemList;
        private var mc:*;
        private var gInv:Vector.<Item>;
        private var needInit:Boolean = true;

        public function GuildShop(game:Game, guildMenu:GuildMenu, _arg3:Object, items:Vector.<Item>)
        {
            this.x = 588;
            this.game = game;
            this.Parent = guildMenu;
            this.shopinfo = _arg3;
            this.gInv = items;
            this.mcShopList = new ItemList();
            this.mcItemList = new ItemList();
            this.mc = this.addChild((this.mcShopList as MovieClip));
            this.mc.x = 27;
            this.mc.y = 82;
            this.mcShopList.inventorySlot = this.shopinfo.items.length;
            this.mcShopList.init(this.shopinfo.items);
            this.bg1.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.btnPreview.addEventListener(MouseEvent.CLICK, this.onPreviewClick, false, 0, true);
            this.btnAction.addEventListener(MouseEvent.CLICK, this.onActionClick, false, 0, true);
            this.tabShop.addEventListener(MouseEvent.CLICK, this.onClickShop, false, 0, true);
            this.tabInv.addEventListener(MouseEvent.CLICK, this.onClickInv, false, 0, true);
            this.txtAction.mouseEnabled = false;
            this.updateGoldCoin();
            this.onClickShop(null);
            this.game.ui.addChild(this);
        }

        public function get selectedItem():Object
        {
            return ((this.bitShop) ? this.mcShopList.selectedItem : this.mcItemList.selectedItem);
        }

        public function Destroy():void
        {
            this.game.ui.removeChild(this);
        }

        public function updateGoldCoin():void
        {
            this.strGold.text = this.game.world.myAvatar.objData.intGold;
            this.strCoins.text = this.game.world.myAvatar.objData.intCoins;
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

        public function reset(items:Vector.<Item>):void
        {
            this.mcItemList.inventorySlot = items.length;
            this.mcItemList.init(items);
            this.updateGoldCoin();
        }

        public function buyRequest(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.game.network.send("guild", ["buyItem", _arg1.item.ItemID, this.shopinfo.ShopID, _arg1.item.ShopItemID]);
            };
        }

        public function sellRequest(_arg1:*):void
        {
            if (_arg1.accept)
            {
                this.game.network.send("guild", ["sellItem", _arg1.item.ItemID, this.shopinfo.ShopID]);
            };
        }

        public function showItemDetail():void
        {
            var item:Item;
            var _local2:* = "#FF9900";
            if (this.bitShop)
            {
                item = this.mcShopList.selectedItem;
                this.strInfo.htmlText = this.game.getItemInfoString(item);
                if ((((item.bCoins == 0) && (item.iCost > this.game.world.myAvatar.objData.intGold)) || ((item.bCoins == 1) && (item.iCost > this.game.world.myAvatar.objData.intCoins))))
                {
                    _local2 = "#CC0000";
                };
                if (item.bCoins == 0)
                {
                    this.strCost.htmlText = (((("<font size='14' color='" + _local2) + "'><b>") + Number(item.iCost)) + " Gold</b></font>");
                }
                else
                {
                    this.strCost.htmlText = (((((("<font size='14' color='" + _local2) + "'><b>") + Number(item.iCost)) + " ") + Config.getString("coins_name_short")) + "</b></font>");
                };
                this.txtAction.text = "Buy";
                this.btnPreview.visible = true;
            }
            else
            {
                item = this.mcItemList.selectedItem;
                this.strInfo.htmlText = this.game.getItemInfoString(item);
                if (item.bCoins == 0)
                {
                    if (this.game.world.myAvatar.objData.intGold > 2000000)
                    {
                        this.strCost.htmlText = (("<font size='14' color='" + _local2) + "'><b>0 Gold</b></font>");
                    }
                    else
                    {
                        this.strCost.htmlText = (((("<font size='14' color='" + _local2) + "'><b>") + Math.ceil((item.iCost / 4))) + " Gold</b></font>");
                    };
                }
                else
                {
                    if (item.iHrs < 24)
                    {
                        this.strCost.htmlText = (((((("<font size='14' color='" + _local2) + "'><b>") + Math.ceil(((item.iCost * 9) / 10))) + " ") + Config.getString("coins_name_short")) + "</b></font>");
                    }
                    else
                    {
                        this.strCost.htmlText = (((((("<font size='14' color='" + _local2) + "'><b>") + Math.ceil((item.iCost / 4))) + " ") + Config.getString("coins_name_short")) + "</b></font>");
                    };
                };
                this.txtAction.text = "Sell";
                this.btnPreview.visible = false;
            };
            this.txtAction.visible = true;
            this.btnAction.visible = true;
            this.mcCoin.visible = (item.bCoins == 1);
            this.mcUpgrade.visible = (item.bUpg == 1);
        }

        public function onBuyClick():void
        {
            switch (true)
            {
                case (((this.shopinfo.bStaff == 1) || (this.mcShopList.selectedItem.bStaff == 1)) && (this.game.world.myAvatar.objData.intAccessLevel < 40)):
                    this.game.MsgBox.notify("Test Item.. cannot be purchased yet!");
                    break;
                case ((!(this.shopinfo.sField == "")) && (!(Achievement.getAchievement(this.shopinfo.sField, this.shopinfo.iIndex) == 1))):
                    this.game.MsgBox.notify("Item requires special requirement!");
                    break;
                case ((this.mcShopList.selectedItem.bUpg == 1) && (!(this.game.world.myAvatar.isUpgraded()))):
                    this.game.showUpgradeWindow();
                    break;
                case ((this.mcShopList.selectedItem.FactionID > 1) && (this.game.world.myAvatar.getRep(this.mcShopList.selectedItem.FactionID) < this.mcShopList.selectedItem.iReqRep)):
                    this.game.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                    break;
                case ((this.mcShopList.selectedItem.iClass > 0) && (this.game.world.myAvatar.getCPByID(this.mcShopList.selectedItem.iClass) < this.mcShopList.selectedItem.iReqCP)):
                    this.game.MsgBox.notify("Item Locked: Class Requirement not met.");
                    break;
                case this.Parent.isItemInInventory(this.mcShopList.selectedItem.ItemID):
                    this.game.MsgBox.notify("You already own this building.");
                    break;
                case (((this.game.world.myAvatar.isItemInInventory(this.mcShopList.selectedItem.ItemID)) || (this.game.world.myAvatar.isItemInBank(this.mcShopList.selectedItem.ItemID))) && (this.game.world.myAvatar.isItemStackMaxed(this.mcShopList.selectedItem.ItemID))):
                    this.game.MsgBox.notify((("You cannot have more than " + ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"][this.mcShopList.selectedItem.iStk]) + " of that item!"));
                    break;
                case (((this.mcShopList.selectedItem.bCoins == 0) && (this.mcShopList.selectedItem.iCost > this.game.world.myAvatar.objData.intGold)) || ((this.mcShopList.selectedItem.bCoins == 1) && (this.mcShopList.selectedItem.iCost > this.game.world.myAvatar.objData.intCoins))):
                    this.game.MsgBox.notify("Insufficient Funds!");
                    break;
                case (this.game.world.myAvatar.houseitems.length >= this.game.world.myAvatar.objData.iHouseSlots):
                    this.game.MsgBox.notify("House Inventory Full!");
                    break;
                default:
                    MainController.modal((('Are you sure you want to buy "' + this.mcShopList.selectedItem.sName) + '"?'), this.buyRequest, {"item":this.mcShopList.selectedItem}, "red,medium", "dual");
            };
        }

        public function onSellClick():void
        {
            var _local1:*;
            var _local2:*;
            if (this.mcItemList.selectedItem.bEquip)
            {
                this.game.MsgBox.notify("Item is currently equipped!");
            }
            else
            {
                if (this.mcItemList.selectedItem.bTemp == 0)
                {
                    _local1 = new ModalMC();
                    _local2 = {};
                    _local2.strBody = (('Are you sure you want to sell "' + this.mcItemList.selectedItem.sName) + '"?');
                    _local2.params = {};
                    _local2.params.item = this.mcItemList.selectedItem;
                    _local2.callback = this.sellRequest;
                    this.game.ui.ModalStack.addChild(_local1);
                    _local1.init(_local2);
                };
            };
        }

        public function onActionClick(_arg1:Event):*
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
            if ((((this.mcShopList.selectedItem.sType == "Floor Item") || (this.mcShopList.selectedItem.sType == "Wall Item")) || (this.mcShopList.selectedItem.sType == "House")))
            {
                LPFLayoutChatItemPreview.linkItem(this.mcShopList.selectedItem);
            };
        }

        private function onCloseClick(_arg1:Event):void
        {
            this.Parent.closeShop();
        }

        private function onClickShop(_arg1:Event):void
        {
            this.tabShop.select();
            this.tabInv.unselect();
            try
            {
                this.removeChild(this.mcItemList);
                this.mc = this.addChild(this.mcShopList);
                this.mc.x = 27;
                this.mc.y = 82;
            }
            catch(e:Error)
            {
            };
            this.txtTitle.text = "Shop";
            this.bitShop = true;
            this.refreshDetail();
        }

        private function onClickInv(_arg1:Event):void
        {
            this.tabShop.unselect();
            this.tabInv.select();
            try
            {
                this.removeChild(this.mcShopList);
                this.mc = this.addChild(this.mcItemList);
                this.mc.x = 27;
                this.mc.y = 82;
            }
            catch(e:Error)
            {
            };
            if (this.needInit)
            {
                this.mcItemList.inventorySlot = this.gInv.length;
                this.mcItemList.init(this.gInv);
                this.needInit = false;
            };
            this.txtTitle.text = "Inventory";
            this.bitShop = false;
            this.refreshDetail();
        }


    }
}//package 

