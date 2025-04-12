// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameBuySellButton

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class LPFFrameBuySellButton extends LPFFrame 
    {

        public var btn:MovieClip;
        public var ti:TextField;
        protected var eventType:String = "";

        public function LPFFrameBuySellButton():void
        {
            this.ti.mouseEnabled = false;
            this.btn.addEventListener(MouseEvent.CLICK, this.onBtnClick, false, 0, true);
        }

        override public function fOpen(_arg1:Object):void
        {
            positionBy(_arg1.r);
            if (_arg1.eventTypes != undefined)
            {
                eventTypes = _arg1.eventTypes;
            };
            if (_arg1.eventType != undefined)
            {
                this.eventType = _arg1.eventType;
            };
            if (_arg1.fData != undefined)
            {
                fData = _arg1.fData;
            };
            this.fDraw();
            getLayout().registerForEvents(this, eventTypes);
        }

        override public function fClose():void
        {
            this.btn.removeEventListener(MouseEvent.CLICK, this.onBtnClick);
            getLayout().unregisterFrame(this);
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override public function notify(_arg1:Object):void
        {
            if (_arg1.buttonNewEventType != undefined)
            {
                this.eventType = _arg1.buttonNewEventType;
            };
            if (_arg1.fData != undefined)
            {
                fData = _arg1.fData;
            };
            this.fDraw();
        }

        protected function fDraw():void
        {
            if (((!(fData == null)) && (!(fData.sText == ""))))
            {
                this.ti.text = fData.sText;
                visible = true;
            }
            else
            {
                this.ti.text = "";
                visible = false;
            };
        }

        private function onBtnClick(_arg1:MouseEvent):void
        {
            update({
                "eventType":this.eventType,
                "sModeBroadcast":fData.sModeBroadcast
            });
        }


    }
}//package Main.Aqw.LPF

