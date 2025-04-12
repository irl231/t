// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelBg4

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.*;

    public dynamic class LPFPanelBg4 extends MovieClip 
    {

        public var rootClass:Game;
        public var bg:MovieClip;
        public var btnLock:SimpleButton;
        public var btnDeal:SimpleButton;
        public var btnClose:SimpleButton;
        public var tTitle:TextField;
        public var tPane1:TextField;
        public var tPane2:TextField;
        public var tPane3:TextField;
        public var txtMyGold:TextField;
        public var txtMyCoins:TextField;
        public var txtTargetGold:TextField;
        public var txtTargetCoins:TextField;
        public var txtLock:TextField;
        public var txtDeal:TextField;

        public function LPFPanelBg4()
        {
            addFrameScript(1, this.frame2);
            this.rootClass = Game.root;
            super();
        }

        private function frame2():void
        {
            this.tTitle.mouseEnabled = false;
            this.tPane1.mouseEnabled = false;
            this.tPane2.mouseEnabled = false;
            this.tPane3.mouseEnabled = false;
            this.txtLock.mouseEnabled = false;
            this.txtDeal.mouseEnabled = false;
            this.txtLock.text = "Lock";
            this.txtDeal.text = "Deal";
            this.txtMyGold.restrict = "0-9";
            this.txtMyCoins.restrict = "0-9";
            this.btnDeal.alpha = 0.5;
            this.btnDeal.mouseEnabled = false;
            this.btnLock.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnDeal.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.rootClass.ctrlTrade = this;
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnLock":
                    if (this.txtLock.text == "Lock")
                    {
                        if (this.txtMyCoins.length == 0)
                        {
                            this.txtMyCoins.text = "0";
                        };
                        if (this.txtMyGold.length == 0)
                        {
                            this.txtMyGold.text = "0";
                        };
                        LPFLayoutTrade(this.rootClass.ui.mcPopup.getChildByName("mcTrade")).update({"eventType":"lockOffer"});
                    }
                    else
                    {
                        LPFLayoutTrade(this.rootClass.ui.mcPopup.getChildByName("mcTrade")).update({"eventType":"unlockOffer"});
                    };
                    break;
                case "btnDeal":
                    LPFLayoutTrade(this.rootClass.ui.mcPopup.getChildByName("mcTrade")).update({"eventType":"completeTrade"});
                    break;
            };
        }


    }
}//package Main.Aqw.LPF

