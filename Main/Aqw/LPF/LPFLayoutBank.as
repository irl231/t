// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayoutBank

package Main.Aqw.LPF
{
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import Main.Model.*;

    public class LPFLayoutBank extends LPFLayout 
    {

        public var bSel:Object;
        public var itemsI:Vector.<Item>;
        public var itemsB:Vector.<Item>;
        public var bankPanel:LPFPanel;
        public var rootClass:Game;
        public var previewPanel:BankPreview;


        override public function fOpen(_arg1:Object):void
        {
            this.rootClass = Game.root;
            fData = _arg1.fData;
            sMode = _arg1.sMode;
            this.itemsI = fData.itemsI;
            this.itemsB = fData.itemsB;
            var r:Object = _arg1.r;
            x = r.x;
            y = r.y;
            w = r.w;
            h = r.h;
            var o:Object = {};
            o.panel = new LPFPanelBank();
            o.fData = {
                "itemsI":this.itemsI,
                "itemsB":this.itemsB,
                "avatar":this.rootClass.world.myAvatar,
                "objData":fData.objData
            };
            o.r = {
                "x":30,
                "y":80,
                "w":900,
                "h":400
            };
            o.isOpen = true;
            this.bankPanel = addPanel(o);
            o = {};
            o.panel = new BankPreview();
            o.fData = {"sName":"Preview"};
            o.r = {
                "x":361,
                "y":197,
                "w":249.05,
                "h":204.2
            };
            o.closeType = "hide";
            o.isOpen = false;
            this.previewPanel = BankPreview(addChild(o.panel));
            this.previewPanel.fOpen(o);
            this.previewPanel.visible = false;
        }

        override public function fClose():void
        {
            super.fClose();
            this.previewPanel.fClose();
        }

        override protected function handleUpdate(_arg1:Object):Object
        {
            var b:Boolean;
            var iSel2:Object = iSel;
            var bSel2:Object = this.bSel;
            switch (_arg1.eventType)
            {
                case "inventorySel":
                    iSel = _arg1.fData;
                    if (iSel2 == iSel)
                    {
                        iSel = null;
                    };
                    _arg1.fData = {"iSel":iSel};
                    this.previewPanel.show(Item(iSel));
                    break;
                case "bankSel":
                    this.bSel = _arg1.fData;
                    if (bSel2 == this.bSel)
                    {
                        this.bSel = null;
                    };
                    _arg1.fData = {"bSel":this.bSel};
                    this.previewPanel.show(Item(this.bSel));
                    break;
                case "categorySel":
                    this.bSel = null;
                    if (this.rootClass.world.bankHasRequested(_arg1.fData.types))
                    {
                        this.rootClass.world.sendLoadBankRequest(["All"]);
                    }
                    else
                    {
                        _arg1.fData.loadPending = true;
                        _arg1.fData.msg = "Loading...";
                        this.rootClass.world.sendLoadBankRequest(_arg1.fData.types);
                    };
                    break;
                case "refreshBank":
                    break;
                case "refreshInventory":
                    break;
                case "refreshItems":
                    break;
                case "sendBankFromInvRequest":
                    this.rootClass.world.sendBankFromInvRequest(iSel);
                    iSel = null;
                    break;
                case "sendBankToInvRequest":
                    this.rootClass.world.sendBankToInvRequest(this.bSel);
                    this.bSel = null;
                    break;
                case "sendBankSwapInvRequest":
                    this.rootClass.world.sendBankSwapInvRequest(this.bSel, iSel);
                    iSel = null;
                    this.bSel = null;
                    break;
                case "buyBagSlots":
                    b = true;
                    this.rootClass.toggleBuySlotPanel();
                    this.fClose();
                    break;
                case "helpAC":
                    b = true;
                    this.rootClass.world.loadMovieFront("interface/goldAC4.swf", "Inline Asset");
                    break;
            };
            this.updatePreviewButtons();
            return ((b) ? null : _arg1);
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
                if (((!(iSel == null)) && (this.bSel == null)))
                {
                    o.fData.sText = "< To Bank";
                    o.buttonNewEventType = "sendBankFromInvRequest";
                    o.sMode = "red";
                }
                else
                {
                    if (((iSel == null) && (!(this.bSel == null))))
                    {
                        o.fData.sText = "To Inventory >";
                        o.buttonNewEventType = "sendBankToInvRequest";
                        o.sMode = "red";
                    }
                    else
                    {
                        if (((!(iSel == null)) && (!(this.bSel == null))))
                        {
                            o.fData.sText = "< Swap >";
                            o.buttonNewEventType = "sendBankSwapInvRequest";
                            o.sMode = "red";
                        }
                        else
                        {
                            o.fData.sText = "";
                            o.buttonNewEventType = "";
                        };
                    };
                };
            };
            notifyByEventType(o);
        }


    }
}//package Main.Aqw.LPF

