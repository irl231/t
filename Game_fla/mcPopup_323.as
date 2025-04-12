// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcPopup_323

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import Main.Party.PartyPanel;
    import Main.Bot.BotPanel;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import Main.Aqw.LPF.LPFLayoutInvShopEnh;
    import Main.Aqw.LPF.LPFLayoutMergeShop;
    import Main.Aqw.LPF.LPFLayoutBank;
    import Main.Aqw.LPF.LPFLayoutTrade;
    import Main.Aqw.LPF.LPFLayoutAuction;
    import Main.Aqw.LPF.LPFLayoutChatItemPreview;
    import flash.display.*;
    import Main.Aqw.LPF.*;
    import Main.Controller.*;

    public dynamic class mcPopup_323 extends MovieClip 
    {

        public var CoreStatPanelMC:MovieClip;
        public var RelationshipPanelMC:MovieClip;
        public var StaffPanelMC:MovieClip;
        public var CouplePanelMC:MovieClip;
        public var CharacterPageMC:MovieClip;
        public var ChatWindowMC:MovieClip;
        public var tradeId:int;
        public var tradeUser:String;
        public var mcCharpanel:CharpanelMC;
        public var mcGuildList:GuildPanelList;
        public var mcBag:SimpleButton;
        public var mcHouseShop:HouseShop;
        public var mcCustomize:MovieClip;
        public var mcCooking:MovieClip;
        public var mcPVPPanel:PVPPanelMC;
        public var mcHouseItemHandle:HouseItemHandleMC;
        public var mcPartyPanel:PartyPanel;
        public var GuildRewrite:MovieClip;
        public var reportMC:MovieClip;
        public var mcHouseOptions:MovieClip;
        public var mcBook:MovieClip;
        public var cnt:FactionsMC;
        public var mcHouseMenu:HouseMenu;
        public var mcCustomizeArmor:MovieClip;
        public var mcNews:MovieClip;
        public var botPanel:BotPanel;
        public var DuelMC:BetPanelMC;
        public var mcOptionPanel:MovieClip;
        public var fData:Object;

        public function mcPopup_323()
        {
            addFrameScript(0, this.Blank, 1, this.Init, 2, this.Inventory, 4, this.Shop, 5, this.MergeShop, 7, this.Bank, 11, this.Options, 22, this.TradePanel, 23, this.AuctionPanel, 24, this.ItemPreview, 31, this.CookingPanel);
        }

        override public function gotoAndStop(frame:Object, scene:String=null):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
            super.gotoAndStop(frame, scene);
        }

        public function fOpen(where:String, data:Object=null):void
        {
            Game.root.gameMenu.close();
            if (currentLabel == where)
            {
                return;
            };
            this.fClose();
            if (data != null)
            {
                this.fData = data;
            };
            this.gotoAndStop(where);
            visible = true;
        }

        public function fClose():void
        {
            var dio:DisplayObject;
            this.fData = null;
            var i:int;
            while (i < numChildren)
            {
                dio = getChildAt(i);
                if ((dio is LPFLayout))
                {
                    LPFLayout(dio).fClose();
                };
                i++;
            };
        }

        public function onClose(_arg1:Event=null):void
        {
            if (((!(currentLabel == "Init")) && (!(currentFrame == 1))))
            {
                this.fClose();
                if ((((Game.root.world.isMyHouse()) && (!(Game.root.world.mapLoadInProgress))) && (!(currentLabel == "House"))))
                {
                    this.gotoAndStop("House");
                }
                else
                {
                    gotoAndPlay("Init");
                };
            };
        }

        public function loadCooking(file:String):void
        {
            Game.root.mcConnDetail.showConn("Loading Cook Book...");
            this.mcCooking.removeChildAt(0);
            LoadController.singleton.addLoadJunk(file, "cooking_junk", function (event:Event):void
            {
                mcCooking.addChild(MovieClip(event.target.content));
                Game.root.network.send("cookList", []);
            });
        }

        private function Blank():void
        {
            this.fData = {};
            visible = false;
            stop();
        }

        private function Init():void
        {
            this.fData = {};
            visible = false;
            if (((!(Game.root.mcO == null)) && (Game.root.contains(Game.root.mcO))))
            {
                this.removeChild(Game.root.mcO);
            };
            stop();
        }

        private function Inventory():void
        {
            var lpfLayoutInvShopEnh:LPFLayoutInvShopEnh = LPFLayoutInvShopEnh(addChild(new LPFLayoutInvShopEnh()));
            lpfLayoutInvShopEnh.name = "mcInventory";
            lpfLayoutInvShopEnh.fOpen({
                "fData":{
                    "itemsInv":Game.root.world.myAvatar.items,
                    "itemsTemp":Game.root.world.myAvatar.tempitems,
                    "objData":Game.root.world.myAvatar.objData
                },
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"inventory"
            });
            stop();
        }

        private function Shop():void
        {
            var lpfLayoutInvShopEnh:LPFLayoutInvShopEnh = LPFLayoutInvShopEnh(addChild(new LPFLayoutInvShopEnh()));
            lpfLayoutInvShopEnh.name = "mcShop";
            lpfLayoutInvShopEnh.fOpen({
                "fData":{
                    "itemsShop":Game.root.world.shopinfo.items,
                    "itemsInv":Game.root.world.myAvatar.items,
                    "objData":Game.root.world.myAvatar.objData,
                    "shopinfo":Game.root.world.shopinfo
                },
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"shopBuy"
            });
            stop();
        }

        private function MergeShop():void
        {
            var lpfLayoutMergeShop:LPFLayoutMergeShop = LPFLayoutMergeShop(addChild(new LPFLayoutMergeShop()));
            lpfLayoutMergeShop.name = "mcShop";
            lpfLayoutMergeShop.fOpen({
                "fData":{
                    "itemsShop":Game.root.world.shopinfo.items,
                    "itemsInv":Game.root.world.myAvatar.items,
                    "objData":Game.root.world.myAvatar.objData
                },
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"shopBuy"
            });
            stop();
        }

        private function Bank():void
        {
            var lpfLayoutBank:LPFLayoutBank = LPFLayoutBank(addChild(new LPFLayoutBank()));
            lpfLayoutBank.name = "mcBank";
            lpfLayoutBank.fOpen({
                "fData":{
                    "itemsB":Game.root.world.bankinfo.items,
                    "itemsI":Game.root.world.myAvatar.items,
                    "objData":Game.root.world.myAvatar.objData
                },
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"bank"
            });
            Game.root.drawBankFilters();
            stop();
        }

        private function Options():void
        {
            Game.root.mcO = ((Game.root.mcO == null) ? new mcOption2() : Game.root.mcO);
            this.addChild(Game.root.mcO);
            Game.root.mcO.x = 600;
            Game.root.mcO.y = 100;
            Game.root.mcO.Init();
            stop();
        }

        private function House():void
        {
            stop();
        }

        private function TradePanel():void
        {
            var lpfLayoutTrade:LPFLayoutTrade = LPFLayoutTrade(addChild(new LPFLayoutTrade()));
            lpfLayoutTrade.name = "mcTrade";
            lpfLayoutTrade.fOpen({
                "fData":{
                    "objData":Game.root.world.myAvatar.objData,
                    "tradeId":this.tradeId,
                    "tradeUser":this.tradeUser,
                    "itemsI":Game.root.world.myAvatar.items,
                    "itemsB":Game.root.world.tradeInfo.itemsA,
                    "itemsC":Game.root.world.tradeInfo.itemsB
                },
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"trade"
            });
            stop();
        }

        private function AuctionPanel():void
        {
            var lpfLayoutAuction:LPFLayoutAuction = LPFLayoutAuction(addChild(new LPFLayoutAuction()));
            lpfLayoutAuction.name = "mcAuction";
            lpfLayoutAuction.fOpen({
                "fData":{
                    "itemsI":Game.root.world.auctioninfo.items,
                    "itemsB":Game.root.world.myAvatar.items,
                    "itemsC":Game.root.world.retrieveinfo.items,
                    "objData":Game.root.world.myAvatar.objData
                },
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"auction"
            });
            stop();
        }

        private function ItemPreview():void
        {
            var lpfLayoutChatItemPreview:LPFLayoutChatItemPreview = LPFLayoutChatItemPreview(addChild(new LPFLayoutChatItemPreview()));
            lpfLayoutChatItemPreview.name = "mcChatPreview";
            lpfLayoutChatItemPreview.fOpen({
                "fData":this.fData,
                "r":{
                    "x":0,
                    "y":0,
                    "w":Game.root.stage.stageWidth,
                    "h":Game.root.stage.stageHeight
                },
                "sMode":"preview"
            });
            stop();
        }

        private function CookingPanel():void
        {
            this.loadCooking(Game.root.version.setting.file_cooking);
            stop();
        }


    }
}//package Game_fla

