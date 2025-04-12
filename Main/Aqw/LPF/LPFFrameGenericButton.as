// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameGenericButton

package Main.Aqw.LPF
{
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class LPFFrameGenericButton extends LPFFrame 
    {

        public var t1:TextField;
        public var t2:TextField;
        public var btn1:SimpleButton;
        public var btn2:SimpleButton;
        protected var eventType:String = "";

        public function LPFFrameGenericButton():void
        {
            this.t1.mouseEnabled = false;
            this.t2.mouseEnabled = false;
            addEventListener(MouseEvent.CLICK, this.onBtnClick, false, 0, true);
        }

        override public function fOpen(_arg1:Object):void
        {
            positionBy(_arg1.r);
            sMode = "grey";
            if (_arg1.fData != undefined)
            {
                fData = _arg1.fData;
            };
            if (_arg1.buttonNewEventType != undefined)
            {
                this.eventType = _arg1.buttonNewEventType;
            };
            if (_arg1.sMode != undefined)
            {
                sMode = _arg1.sMode.toLowerCase();
            };
            if (_arg1.eventTypes != undefined)
            {
                eventTypes = _arg1.eventTypes;
            };
            this.fDraw();
            getLayout().registerForEvents(this, eventTypes);
        }

        override public function fClose():void
        {
            removeEventListener(MouseEvent.CLICK, this.onBtnClick);
            getLayout().unregisterFrame(this);
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override public function notify(_arg1:Object):void
        {
            if (_arg1.fData != undefined)
            {
                fData = _arg1.fData;
            };
            if (_arg1.buttonNewEventType != undefined)
            {
                this.eventType = _arg1.buttonNewEventType;
            };
            if (_arg1.sMode != undefined)
            {
                sMode = _arg1.sMode.toLowerCase();
            };
            if (_arg1.r != undefined)
            {
                positionBy(_arg1.r);
            };
            this.fDraw();
        }

        protected function fDraw():void
        {
            if (((!(fData == null)) && (!(fData.sText == ""))))
            {
                switch (sMode)
                {
                    case "red":
                        this.t1.text = "";
                        this.t2.text = fData.sText;
                        this.btn1.visible = false;
                        this.btn2.visible = true;
                        break;
                    default:
                        this.t1.text = fData.sText;
                        this.t2.text = "";
                        this.btn1.visible = true;
                        this.btn2.visible = false;
                };
                visible = true;
            }
            else
            {
                this.t1.text = "";
                this.t2.text = "";
                this.btn1.visible = false;
                this.btn2.visible = false;
                visible = false;
            };
        }

        private function onBtnClick(_arg1:MouseEvent):void
        {
            if (this.eventType != "none")
            {
                if (fData.sModeBroadcast != undefined)
                {
                    update({
                        "eventType":this.eventType,
                        "sModeBroadcast":fData.sModeBroadcast
                    });
                }
                else
                {
                    update({"eventType":this.eventType});
                };
            };
        }


    }
}//package Main.Aqw.LPF

