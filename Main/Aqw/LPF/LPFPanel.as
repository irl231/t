// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanel

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import Main.Model.ShopModel;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;

    public class LPFPanel extends MovieClip 
    {

        public var frames:Array = [];
        public var w:int;
        public var h:int;
        public var xo:int;
        public var yo:int;
        public var xBuffer:int;
        public var yBuffer:int;
        public var frameID:int = 0;
        public var fParent:LPFLayout;
        public var bg:MovieClip;
        public var isOpen:Boolean = false;
        protected var fData:Object;
        protected var sMode:String;
        protected var closeType:String;
        protected var hideDir:String = "";
        protected var hidePad:int = 0;
        public var mcSearch:InventorySearch;


        public function notify(data:Object):void
        {
            var i:int;
            while (i < this.frames.length)
            {
                this.frames[i].mc.notify(data);
                i++;
            };
        }

        public function addFrame(data:Object):void
        {
            var lpfFrame:LPFFrame = (addChild(data.frame) as LPFFrame);
            lpfFrame.subscribeTo(this);
            this.frames.push({
                "mc":lpfFrame,
                "id":this.frameID++
            });
            lpfFrame.fOpen(data);
        }

        public function delFrame(_arg1:LPFFrame):void
        {
            var i:int;
            while (i < this.frames.length)
            {
                if (this.frames[i].mc == _arg1)
                {
                    this.frames[i].fClose();
                    this.frames.splice(i, 1);
                };
                i++;
            };
        }

        public function subscribeTo(lpfLayout:LPFLayout):void
        {
            this.fParent = lpfLayout;
        }

        public function fOpen(data:Object):void
        {
            var numChildren:int;
            this.fData = data.fData;
            this.x = data.r.x;
            if (data.r.y > -1)
            {
                this.y = data.r.y;
            }
            else
            {
                numChildren = this.fParent.numChildren;
                this.y = ((numChildren > 1) ? ((this.fParent.getChildAt((numChildren - 2)).y + this.fParent.getChildAt((numChildren - 2)).height) + 10) : 10);
            };
            this.w = data.r.w;
            this.h = data.r.h;
            this.xo = x;
            this.yo = y;
        }

        public function fClose():void
        {
            if (((!(this.bg == null)) && (!(this.bg.btnClose == null))))
            {
                this.bg.btnClose.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
            };
            while (this.frames.length > 0)
            {
                this.frames[0].mc.fClose();
                this.frames.shift();
            };
            if (this.mcSearch)
            {
                this.mcSearch.reset();
            };
            this.mcSearch = null;
            this.fParent.delPanel(this);
        }

        public function fHide():void
        {
            this.isOpen = false;
            visible = false;
            switch (this.hideDir.toLowerCase())
            {
                case "left":
                    x = ((this.xo - this.w) - this.hidePad);
                    return;
                case "right":
                    x = ((this.xo + this.w) + this.hidePad);
                    return;
                case "top":
                    y = ((this.yo - this.h) - this.hidePad);
                    return;
                case "bottom":
                    y = ((this.yo + this.h) + this.hidePad);
                    return;
                case "":
            };
        }

        public function fShow(_arg1:int=-1):void
        {
            this.isOpen = true;
            visible = true;
            x = ((_arg1 > -1) ? _arg1 : this.xo);
        }

        protected function drawBG(lpfPanel:Class=null):void
        {
            var shopData:ShopModel;
            if (lpfPanel == null)
            {
                this.bg = (addChildAt(new LPFPanelBg(), 0) as MovieClip);
                this.bg.frame.width = this.w;
                this.bg.frame.height = this.h;
                this.bg.bg.width = (this.w - (6 << 1));
                this.bg.bg.height = (this.h - (5 << 1));
                this.bg.btnClose.x = (this.w - 31);
                this.bg.dragonRight.x = (this.bg.frame.width + 21);
                this.bg.tTitle.x = int(((this.w >> 1) - (this.bg.tTitle.width >> 1)));
            }
            else
            {
                this.bg = MovieClip(addChildAt(new (lpfPanel)(), 0));
            };
            if (("sName" in this.fData))
            {
                this.bg.tTitle.text = this.fData.sName;
                this.bg.tTitle.textColor = 0xFFFFFF;
                shopData = Game.root.world.shopinfo;
                if (shopData)
                {
                    this.bg.tTitle.textColor = ((shopData.bUpgrd) ? 16566089 : 0xFFFFFF);
                    if (shopData.bStaff)
                    {
                        this.bg.tTitle.textColor = 0xFFFF00;
                    };
                };
            };
            if ((((!(this.fData.sName == undefined)) && (((Game.root.ui.mcPopup.currentLabel.indexOf("Bank") > -1) || (this.fData.sName.toLowerCase() == "inventory")) || (this.fData.sName.toLowerCase() == "house inventory"))) && (!(this.bg.getChildByName("mcInvSearch")))))
            {
                this.mcSearch = InventorySearch(this.bg.addChild(new InventorySearch()));
                this.mcSearch.name = "mcInvSearch";
                if (Game.root.ui.mcPopup.currentLabel.indexOf("Bank") == -1)
                {
                    this.mcSearch.x = 156;
                    this.mcSearch.y = 26;
                }
                else
                {
                    this.mcSearch.x = 737;
                    this.mcSearch.y = 24;
                };
                this.bg.tTitle.visible = false;
            };
        }

        protected function onCloseClick(_arg1:MouseEvent=null):void
        {
            switch (this.closeType)
            {
                case "hide":
                    this.fHide();
                    return;
                case "close":
                default:
                    this.mcSearch = null;
                    this.bg.btnClose.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
                    this.fParent.fClose();
            };
        }


    }
}//package Main.Aqw.LPF

