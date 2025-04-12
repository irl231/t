// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameCheapBuySell

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;

    public class LPFFrameCheapBuySell extends LPFFrame 
    {

        public var btnBuy:MovieClip;
        public var btnSell:MovieClip;
        private var eventType:String = "";

        public function LPFFrameCheapBuySell():void
        {
            this.btnBuy.addEventListener(MouseEvent.CLICK, this.onBtnBuyClick, false, 0, true);
            this.btnBuy.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
            this.btnBuy.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
            this.btnSell.addEventListener(MouseEvent.CLICK, this.onBtnSellClick, false, 0, true);
            this.btnSell.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
            this.btnSell.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
            this.btnBuy.buttonMode = true;
            this.btnSell.buttonMode = true;
            this.btnBuy.sel = (this.btnBuy.bg2.visible = (this.btnBuy.bg3.visible = false));
            this.btnSell.sel = (this.btnSell.bg2.visible = (this.btnSell.bg3.visible = false));
        }

        private static function onMouseOver(event:MouseEvent):void
        {
            var movieClip:MovieClip = MovieClip(event.currentTarget);
            if (!movieClip.sel)
            {
                movieClip.bg2.visible = true;
            };
        }

        private static function onMouseOut(event:MouseEvent):void
        {
            var movieClip:MovieClip = MovieClip(event.currentTarget);
            if (!movieClip.sel)
            {
                movieClip.bg2.visible = false;
            };
        }


        override public function fOpen(data:Object):void
        {
            if (data.eventType != undefined)
            {
                this.eventType = data.eventType;
            };
            super.fOpen(data);
            this.btnBuy.tText.text = this.fData.textLeft;
            this.btnSell.tText.text = this.fData.textRight;
            if (data.openOn != undefined)
            {
                switch (data.openOn)
                {
                    case "shopBuy":
                        this.select(this.btnBuy);
                        break;
                    case "shopSell":
                        this.select(this.btnSell);
                        break;
                };
            };
        }

        override public function fClose():void
        {
            super.fClose();
            this.btnBuy.removeEventListener(MouseEvent.CLICK, this.onBtnBuyClick);
            this.btnBuy.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            this.btnBuy.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            this.btnSell.removeEventListener(MouseEvent.CLICK, this.onBtnSellClick);
            this.btnSell.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            this.btnSell.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
        }

        private function select(mc:MovieClip):void
        {
            mc.sel = true;
            mc.bg2.visible = false;
            mc.bg3.visible = true;
            setChildIndex(mc, 1);
        }

        private function unselect(mc:MovieClip):void
        {
            mc.sel = false;
            mc.bg2.visible = false;
            mc.bg3.visible = false;
            setChildIndex(mc, 0);
        }

        private function onBtnSellClick(_arg1:MouseEvent):void
        {
            if (!this.btnSell.sel)
            {
                this.unselect(this.btnBuy);
                this.select(this.btnSell);
                update({
                    "eventType":this.eventType,
                    "sModeBroadcast":this.fData.sMode1
                });
            };
        }

        private function onBtnBuyClick(_arg1:MouseEvent):void
        {
            if (!this.btnBuy.sel)
            {
                this.unselect(this.btnSell);
                this.select(this.btnBuy);
                update({
                    "eventType":this.eventType,
                    "sModeBroadcast":this.fData.sMode2
                });
            };
        }


    }
}//package Main.Aqw.LPF

