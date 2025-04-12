// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayoutTrade

package Main.Aqw.LPF
{
    import Main.Model.Item;
    import __AS3__.vec.Vector;
    import flash.display.MovieClip;
    import flash.display.*;

    public class LPFLayoutTrade extends LPFLayout 
    {

        public var bSel:Item;
        public var cSel:Item;
        public var itemsI:Vector.<Item>;
        public var itemsB:Vector.<Item>;
        public var itemsC:Vector.<Item>;
        public var bankPanel:LPFPanel;
        public var rootClass:Game;
        public var notify:Boolean;
        public var previewPanel:MovieClip;


        override public function fOpen(_arg1:Object):void
        {
            this.notify = true;
            this.rootClass = Game.root;
            fData = _arg1.fData;
            sMode = _arg1.sMode;
            if (fData.itemsI != undefined)
            {
                this.itemsI = fData.itemsI;
            };
            if (fData.itemsB != undefined)
            {
                this.itemsB = fData.itemsB;
            };
            if (fData.itemsC != undefined)
            {
                this.itemsC = fData.itemsC;
            };
            x = _arg1.r.x;
            y = _arg1.r.y;
            w = _arg1.r.w;
            h = _arg1.r.h;
            this.bankPanel = addPanel({
                "panel":new LPFPanelTrade(),
                "fData":{
                    "itemsI":this.itemsI,
                    "itemsB":this.itemsB,
                    "itemsC":this.itemsC,
                    "avatar":this.rootClass.world.myAvatar,
                    "objData":fData.objData,
                    "tradeUser":fData.tradeUser
                },
                "r":{
                    "x":-15,
                    "y":80,
                    "w":900,
                    "h":400
                },
                "isOpen":true
            });
        }

        override public function fClose():void
        {
            var _local1:MovieClip;
            while (panels.length > 0)
            {
                panels[0].mc.fClose();
                panels.shift();
            };
            if (parent != null)
            {
                _local1 = MovieClip(parent);
                _local1.removeChild(this);
                _local1.onClose();
            };
            if (this.notify)
            {
                this.rootClass.network.send("tradeCancel", [fData.tradeId]);
            };
        }

        override protected function handleUpdate(_arg1:Object):Object
        {
            var _local2:Boolean;
            var _local6:Object;
            var uuuu:*;
            var aaaa:*;
            var eeee:*;
            var _local4:Object = iSel;
            var _local5:Object = this.bSel;
            switch (_arg1.eventType)
            {
                case "inventorySel":
                    iSel = _arg1.fData;
                    if (_local4 == iSel)
                    {
                        iSel = null;
                    };
                    _arg1.fData = {"iSel":iSel};
                    break;
                case "offerSel":
                    this.bSel = _arg1.fData;
                    if (_local5 == this.bSel)
                    {
                        this.bSel = null;
                    };
                    _arg1.fData = {"bSel":this.bSel};
                    break;
                case "otherSel":
                    this.cSel = _arg1.fData;
                    if (_local5 == this.cSel)
                    {
                        this.cSel = null;
                    };
                    _arg1.fData = {"cSel":this.cSel};
                    break;
                case "categorySelMyOffer":
                case "categorySelTheirOffer":
                    this.bSel = null;
                    if (this.rootClass.world.tradeHasRequested(_arg1.fData.types))
                    {
                        _arg1.eventType = "refreshBank";
                    }
                    else
                    {
                        _arg1.fData.loadPending = true;
                        _arg1.fData.msg = "Loading...";
                        this.rootClass.world.tradeController.sendLoadOfferRequest(_arg1.fData.types);
                    };
                    break;
                case "refreshBank":
                    break;
                case "refreshInventory":
                    break;
                case "clickPreview":
                    if (!this.rootClass.isGreedyModalInStack())
                    {
                        eSel = null;
                        iSel = null;
                        aSel = _arg1.fData.sType.toLowerCase();
                        this.bSel = "";
                        if (aSel == "fortification")
                        {
                            eSel = _arg1.fData;
                        }
                        else
                        {
                            iSel = _arg1.fData;
                        };
                        _arg1.tabStates = ((_arg1.fData.sType.toLowerCase() == "fortification") ? getTabStates(_arg1.fData) : (getTabStates({"sES":"enh"})));
                        _arg1.fData = {
                            "iSel":iSel,
                            "eSel":eSel,
                            "oSel":_arg1.fData
                        };
                        this.previewPanel.fShow(_arg1);
                    };
                    break;
                case "lockOffer":
                    this.rootClass.network.send("tradeLock", [fData.tradeId, this.rootClass.ctrlTrade.txtMyGold.text, this.rootClass.ctrlTrade.txtMyCoins.text]);
                    break;
                case "unlockOffer":
                    this.rootClass.network.send("tradeUnlock", [fData.tradeId]);
                    break;
                case "completeTrade":
                    this.rootClass.network.send("tradeDeal", [fData.tradeId]);
                    break;
                case "refreshItems":
                    break;
                case "sendTradeFromInvRequest":
                    eeee = iSel.iQty;
                    if (((eeee > 1) && (!(iSel.sES == "ar"))))
                    {
                        uuuu = new ModalMC();
                        aaaa = {};
                        aaaa.params = {};
                        aaaa.strBody = "Please specify item quantity you want to trade.";
                        aaaa.callback = this.qtyRequest;
                        if (eeee > 1)
                        {
                            aaaa.qtySel = {
                                "min":1,
                                "max":eeee
                            };
                        };
                        aaaa.glow = "white,medium";
                        aaaa.greedy = true;
                        this.rootClass.ui.ModalStack.addChild(uuuu);
                        uuuu.init(aaaa);
                    }
                    else
                    {
                        iSel.TradeID = fData.tradeId;
                        iSel.Quantity = eeee;
                        this.rootClass.world.sendTradeFromInvRequest(iSel);
                        iSel = null;
                    };
                    break;
                case "sendTradeToInvRequest":
                    this.bSel.TradeID = fData.tradeId;
                    this.rootClass.world.sendTradeToInvRequest(this.bSel);
                    this.bSel = null;
                    break;
                case "sendTradeSwapInvRequest":
                    this.bSel.TradeID = fData.tradeId;
                    this.rootClass.world.sendTradeSwapInvRequest(this.bSel, iSel);
                    iSel = null;
                    this.bSel = null;
                    break;
            };
            this.updatePreviewButtons(_local6);
            _local4 = null;
            _local5 = null;
            if (!_local2)
            {
                return (_arg1);
            };
            return (null);
        }

        public function qtyRequest(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                iSel.TradeID = fData.tradeId;
                iSel.Quantity = 1;
                if (_arg1.iQty != null)
                {
                    iSel.Quantity = _arg1.iQty;
                };
                this.rootClass.world.sendTradeFromInvRequest(iSel);
                iSel = null;
            };
        }

        private function updatePreviewButtons(_arg1:Object=null, _arg2:Object=null):void
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
                if (((!(iSel == null)) && (this.bSel == null)))
                {
                    _local3.fData.sText = "Add to Offer >";
                    _local3.buttonNewEventType = "sendTradeFromInvRequest";
                    _local3.sMode = "red";
                }
                else
                {
                    if (((iSel == null) && (!(this.bSel == null))))
                    {
                        _local3.fData.sText = "< To Inventory";
                        _local3.buttonNewEventType = "sendTradeToInvRequest";
                        _local3.sMode = "red";
                    }
                    else
                    {
                        _local3.fData.sText = "";
                        _local3.buttonNewEventType = "";
                    };
                };
            };
            notifyByEventType(_local3);
        }


    }
}//package Main.Aqw.LPF

