// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayoutMergeShop

package Main.Aqw.LPF
{
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import Main.Model.*;
    import Main.*;

    public class LPFLayoutMergeShop extends LPFLayout 
    {

        public var itemsInv:Vector.<Item>;
        public var itemsShop:Vector.<Item>;
        public var mergePanel:LPFPanel;
        public var rootClass:Game;
        private var aSel:String = "";
        private var bSel:String = "";


        override public function fOpen(_arg1:Object):void
        {
            var _local2:Object;
            var _local4:Object;
            this.rootClass = Game.root;
            fData = _arg1.fData;
            sMode = _arg1.sMode;
            if (("itemsInv" in fData))
            {
                this.itemsInv = fData.itemsInv;
            };
            if (("itemsShop" in fData))
            {
                this.itemsShop = fData.itemsShop;
            };
            _local2 = _arg1.r;
            var _local3:String = "";
            x = _local2.x;
            y = _local2.y;
            w = _local2.w;
            h = _local2.h;
            _local4 = {};
            _local4.panel = new LPFPanelMergeShop();
            _local3 = this.rootClass.world.shopinfo.sName;
            _local4.fData = {
                "items":this.itemsShop,
                "itemsInv":this.itemsInv,
                "sName":_local3,
                "objData":fData.objData
            };
            _local4.r = {
                "x":30,
                "y":80,
                "w":900,
                "h":400
            };
            _local4.isOpen = true;
            this.mergePanel = addPanel(_local4);
            this.updatePreviewButtons();
        }

        override protected function handleUpdate(_arg1:Object):Object
        {
            var sellSel:Object;
            var _local2:Boolean;
            var _local4:Object;
            var _local5:Object;
            _local4 = iSel;
            switch (_arg1.eventType)
            {
                case "sModeSet":
                    if (sMode != _arg1.sModeBroadcast)
                    {
                        sMode = _arg1.sModeBroadcast;
                        iSel = null;
                        eSel = null;
                        _arg1.iSel = iSel;
                        _arg1.fData = {"list":((sMode == "shopBuy") ? this.itemsShop : this.itemsInv)};
                    };
                    break;
                case "listItemASel":
                    iSel = null;
                    this.aSel = _arg1.fData.sType.toLowerCase();
                    iSel = _arg1.fData;
                    _arg1.fData = {
                        "iSel":iSel,
                        "oSel":_arg1.fData
                    };
                    if (_local4 == iSel)
                    {
                        _local2 = true;
                    };
                    break;
                case "refreshItems":
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
                case "sellItem":
                    if (iSel != null)
                    {
                        sellSel = iSel;
                    };
                    MainController.modal((("Are you sure you want to sell '" + sellSel.sName) + "'?"), this.onSellRequest, {"iSel":sellSel}, "white,medium", "dual", true);
                    break;
                case "buyBagSlots":
                    _local2 = true;
                    this.rootClass.toggleBuySlotPanel();
                    fClose();
                    break;
                case "helpAC":
                    _local2 = true;
                    this.rootClass.world.loadMovieFront("interface/goldAC4.swf", "Inline Asset");
                    break;
            };
            this.updatePreviewButtons(_local5);
            _local4 = null;
            if (!_local2)
            {
                return (_arg1);
            };
            return (null);
        }

        private function updatePreviewButtons(_arg1:Object=null, _arg2:Object=null):void
        {
            var o:Object = {};
            if (((!(_arg1 == null)) && (!(_arg2 == null))))
            {
                o = _arg2;
            }
            else
            {
                o.eventType = "previewButton1Update";
                o.fData = {};
                o.fData.sText = "";
                o.sMode = "grey";
                o.buttonNewEventType = "";
                switch (sMode)
                {
                    case "shopBuy":
                        if (iSel != null)
                        {
                            o.fData.sText = "Buy";
                            o.buttonNewEventType = "buyItem";
                            o.sMode = "red";
                        }
                        else
                        {
                            o.fData.sText = "";
                            o.buttonNewEventType = "";
                        };
                        break;
                    case "shopSell":
                        if (iSel != null)
                        {
                            o.fData.sText = "Sell";
                            o.buttonNewEventType = "sellItem";
                            o.sMode = "red";
                        }
                        else
                        {
                            o.fData.sText = "";
                            o.buttonNewEventType = "";
                        };
                        break;
                };
            };
            notifyByEventType(o);
        }

        private function onSellRequest(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.world.sendSellItemRequest(_arg1.iSel);
            };
        }


    }
}//package Main.Aqw.LPF

