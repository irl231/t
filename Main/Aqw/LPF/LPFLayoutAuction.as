// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayoutAuction

package Main.Aqw.LPF
{
    import Main.Model.Item;
    import __AS3__.vec.Vector;
    import flash.display.MovieClip;
    import Main.*;

    public class LPFLayoutAuction extends LPFLayout 
    {

        public var rSel:Item;
        public var itemsI:Vector.<Item>;
        public var itemsB:Vector.<Item>;
        public var itemsC:Vector.<Item>;
        public var bankPanel:LPFPanelAuction;
        public var rootClass:Game;
        public var notify:Boolean;
        public var previewPanel:MovieClip;
        public var tab:int;


        private static function onBuyRequest(event:Object):void
        {
            if (event.accept)
            {
                Game.root.world.sendBuyAuctionItemRequest(event.item);
            };
        }


        override public function fOpen(data:Object):void
        {
            this.tab = 1;
            this.notify = true;
            this.rootClass = Game.root;
            this.rootClass.auctionLayout = this;
            fData = data.fData;
            sMode = data.sMode;
            if (("itemsI" in fData))
            {
                this.itemsI = fData.itemsI;
            };
            if (("itemsB" in fData))
            {
                this.itemsB = fData.itemsB;
            };
            if (("itemsC" in fData))
            {
                this.itemsC = fData.itemsC;
            };
            this.x = data.r.x;
            this.y = data.r.y;
            w = data.r.w;
            h = data.r.h;
            this.bankPanel = LPFPanelAuction(addPanel({
                "panel":new LPFPanelAuction(),
                "fData":{
                    "itemsI":this.itemsI,
                    "itemsB":this.itemsB,
                    "itemsC":this.itemsC,
                    "avatar":this.rootClass.world.myAvatar,
                    "objData":fData.objData
                },
                "r":{
                    "x":30,
                    "y":80,
                    "w":900,
                    "h":400
                },
                "isOpen":true
            }));
        }

        override protected function handleUpdate(data:Object):Object
        {
            switch (data.eventType)
            {
                case "auctionSel":
                    iSel = data.fData;
                    this.tab = 1;
                    data.fData = {"iSel":iSel};
                    break;
                case "inventorySel":
                    iSel = data.fData;
                    this.tab = 2;
                    data.fData = {"iSel":iSel};
                    break;
                case "retrieveSel":
                    iSel = data.fData;
                    this.tab = 3;
                    data.fData = {"iSel":iSel};
                    break;
                case "categorySelAuction":
                    data.fData.loadPending = true;
                    data.fData.msg = "Loading...";
                    if (this.rootClass.world.tradeHasRequested(data.fData.types))
                    {
                        this.rootClass.world.marketController.sendLoadAuctionRequest(["All"], this.rootClass.vendingOwner);
                    }
                    else
                    {
                        this.rootClass.world.marketController.sendLoadAuctionRequest(data.fData.types, this.rootClass.vendingOwner);
                    };
                    break;
                case "categorySelRetrieve":
                    data.fData.loadPending = true;
                    data.fData.msg = "Loading...";
                    if (this.rootClass.world.marketController.retrieveHasRequested(data.fData.types))
                    {
                        this.rootClass.world.marketController.sendLoadRetrieveRequest(["All"], this.rootClass.vendingOwner);
                    }
                    else
                    {
                        this.rootClass.world.marketController.sendLoadRetrieveRequest(data.fData.types, this.rootClass.vendingOwner);
                    };
                    break;
                case "refreshBank":
                    break;
                case "refreshInventory":
                    break;
                case "refreshItems":
                    break;
                case "buyItem":
                    MainController.modal("Are you sure you want to buy this item from the market?", LPFLayoutAuction.onBuyRequest, {"item":iSel}, "red,medium", "dual");
                    break;
            };
            this.updatePreviewButtons();
            return (data);
        }

        public function updatePreviewButtons(_arg1:Object=null, _arg2:Object=null):void
        {
            var _local3:Object = {};
            if (((!(_arg1 == null)) && (!(_arg2 == null))))
            {
                _local3 = _arg2;
            }
            else
            {
                _local3.eventType = "previewButton1Update";
                _local3.fData = {};
                _local3.fData.sText = "";
                _local3.sMode = "grey";
                _local3.buttonNewEventType = "";
                if (((this.tab == 1) && (!(iSel == null))))
                {
                    _local3.fData.sText = "Buy";
                    _local3.buttonNewEventType = "buyItem";
                    _local3.sMode = "red";
                }
                else
                {
                    _local3.fData.sText = "";
                    _local3.buttonNewEventType = "";
                };
            };
            notifyByEventType(_local3);
        }


    }
}//package Main.Aqw.LPF

