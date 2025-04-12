// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//ConnDetailMC

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.utils.*;
    import Main.*;

    public class ConnDetailMC extends MovieClip 
    {

        public var mcPct:TextField;
        public var txtBack:TextField;
        public var txtDetail:TextField;
        public var btnBack:SimpleButton;
        public var mcTitle:MovieClip;
        public var txtTip:TextField;
        public var toHide:Boolean = false;
        private var timerConnDetail:Timer;
        private var minutes:int;
        private var countDownTimer:Timer;
        private var firstJoin:Boolean = false;

        public function ConnDetailMC()
        {
            this.timerConnDetail = new Timer(10000, 1);
            this.txtBack.mouseEnabled = false;
            this.mcPct.visible = false;
            this.btnBack.addEventListener(MouseEvent.CLICK, this.onBackClick, false, 0, true);
            this.timerConnDetail.removeEventListener(TimerEvent.TIMER, this.showBackButton);
            this.timerConnDetail.addEventListener(TimerEvent.TIMER, this.showBackButton, false, 0, true);
        }

        public function showConn(message:String, firstJoin:Boolean=false):void
        {
            this.btnBack.visible = false;
            this.txtBack.visible = false;
            this.txtBack.text = "Cancel";
            this.txtDetail.text = message;
            this.firstJoin = firstJoin;
            if (stage == null)
            {
                Game.root.addChild(this);
                this.txtTip.text = MainController.tips[Math.floor((Math.random() * MainController.tips.length))];
            };
            if (!this.timerConnDetail.running)
            {
                this.timerConnDetail.reset();
                this.timerConnDetail.start();
            };
        }

        public function showDisconnect(_arg1:String):void
        {
            this.btnBack.visible = true;
            this.txtBack.visible = true;
            this.txtBack.text = "Back";
            this.txtDetail.text = _arg1;
            this.mcPct.visible = false;
            if (stage == null)
            {
                Game.root.addChild(this);
                this.txtTip.text = MainController.tips[Math.floor((Math.random() * MainController.tips.length))];
            };
            if (this.timerConnDetail.running)
            {
                this.timerConnDetail.stop();
            };
        }

        public function showError(message:String):void
        {
            if (stage == null)
            {
                Game.root.addChild(this);
                this.txtTip.text = MainController.tips[Math.floor((Math.random() * MainController.tips.length))];
            };
            this.txtDetail.htmlText = message;
            this.txtBack.text = ((this.firstJoin) ? "Try Again" : "Back");
            this.showBackButton();
        }

        public function hideConn():void
        {
            if (stage != null)
            {
                Game.root.removeChild(this);
            };
        }

        public function showBackButton(_arg1:TimerEvent=null):void
        {
            this.btnBack.visible = true;
            this.txtBack.visible = true;
        }

        private function onBackClick(_arg1:MouseEvent=null):void
        {
            Game.root.logout();
            this.hideConn();
        }


    }
}//package 

