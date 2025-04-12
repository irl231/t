// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameGoldDisplay

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.*;

    public class LPFFrameGoldDisplay extends LPFFrame 
    {

        public var btnHelp:MovieClip;
        public var btnConvert:MovieClip;
        public var mcCoins:MovieClip;
        public var mcGold:MovieClip;


        override public function fOpen(data:Object):void
        {
            if (data.eventTypes != undefined)
            {
                eventTypes = data.eventTypes;
            };
            super.fOpen(data);
            this.fDraw();
            this.mcCoins.addEventListener(MouseEvent.MOUSE_OVER, this.onCoinsTTOver, false, 0, true);
            this.mcCoins.addEventListener(MouseEvent.MOUSE_OUT, this.onTTOut, false, 0, true);
            this.mcGold.addEventListener(MouseEvent.MOUSE_OVER, this.onGoldTTOver, false, 0, true);
            this.mcGold.addEventListener(MouseEvent.MOUSE_OUT, this.onTTOut, false, 0, true);
            this.btnHelp.addEventListener(MouseEvent.CLICK, this.onHelpClick, false, 0, true);
            this.btnHelp.addEventListener(MouseEvent.MOUSE_OVER, this.onHelpTTOver, false, 0, true);
            this.btnHelp.addEventListener(MouseEvent.MOUSE_OUT, this.onTTOut, false, 0, true);
            this.btnConvert.addEventListener(MouseEvent.CLICK, this.onConvertClick, false, 0, true);
            this.btnConvert.addEventListener(MouseEvent.MOUSE_OVER, this.onConvertTTOver, false, 0, true);
            this.btnConvert.addEventListener(MouseEvent.MOUSE_OUT, this.onTTOut, false, 0, true);
        }

        override public function fClose():void
        {
            super.fClose();
            this.mcCoins.removeEventListener(MouseEvent.MOUSE_OVER, this.onCoinsTTOver);
            this.mcCoins.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTOut);
            this.mcGold.removeEventListener(MouseEvent.MOUSE_OVER, this.onGoldTTOver);
            this.mcGold.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTOut);
            this.btnHelp.removeEventListener(MouseEvent.CLICK, this.onHelpClick);
            this.btnHelp.removeEventListener(MouseEvent.MOUSE_OVER, this.onHelpTTOver);
            this.btnHelp.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTOut);
            this.btnConvert.removeEventListener(MouseEvent.CLICK, this.onConvertClick);
            this.btnConvert.removeEventListener(MouseEvent.MOUSE_OVER, this.onConvertTTOver);
            this.btnConvert.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTOut);
        }

        override public function notify(data:Object):void
        {
            if (data.eventType == "refreshCoins")
            {
                this.fDraw();
            };
        }

        private function fDraw():void
        {
            this.mcGold.ti.htmlText = (("<font color='#FFFFFF'>" + MainController.formatNumber(fData.intGold)) + "</font><font color='#E0B300'>g</font>");
            this.mcCoins.ti.text = MainController.formatNumber(fData.intCoins);
            this.mcGold.hit.alpha = 0;
            this.mcCoins.hit.alpha = 0;
        }

        private function onHelpClick(_arg1:MouseEvent):void
        {
            this.onTTOut();
            update({"eventType":"helpAC"});
        }

        private function onHelpTTOver(_arg1:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":(("How do I get " + Config.getString("coins_name")) + "?")});
        }

        private function onCoinsTTOver(_arg1:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":Config.getString("coins_name")});
        }

        private function onGoldTTOver(_arg1:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":"Gold"});
        }

        private function onTTOut(_arg1:MouseEvent=null):void
        {
            ToolTipMC(Game.root.ui.ToolTip).close();
        }

        private function onConvertTTOver(_arg1:MouseEvent):void
        {
            ToolTipMC(Game.root.ui.ToolTip).openWith({"str":("Grind for " + Config.getString("coins_name"))});
        }

        private function onConvertClick(_arg1:MouseEvent):void
        {
            this.onTTOut();
            rootClass.world.gotoTown(Config.getString("join_coin"), "Enter", "Spawn");
        }


    }
}//package Main.Aqw.LPF

