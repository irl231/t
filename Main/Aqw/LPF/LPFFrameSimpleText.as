// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameSimpleText

package Main.Aqw.LPF
{
    import flash.text.TextField;

    public class LPFFrameSimpleText extends LPFFrame 
    {

        public var ti:TextField;

        public function LPFFrameSimpleText():void
        {
            x = 0;
            y = 0;
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            fData = _arg1.fData;
            if (_arg1.eventTypes != undefined)
            {
                eventTypes = _arg1.eventTypes;
            };
            positionBy(_arg1.r);
            this.fDraw();
            positionBy(_arg1.r);
            getLayout().registerForEvents(this, eventTypes);
        }

        override public function fClose():void
        {
            fData = {};
            getLayout().unregisterFrame(this);
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override public function notify(_arg1:Object):void
        {
            if (((!(_arg1.fData == undefined)) && (!(_arg1.fData.msg == undefined))))
            {
                fData = _arg1.fData;
            };
            if (_arg1.r != undefined)
            {
                positionBy(_arg1.r);
            };
            if (_arg1.eventType == "listItemASel")
            {
                this.fDraw((!(_arg1.fData.iSel == null)));
            };
        }

        private function fDraw(_arg1:Boolean=true):void
        {
            if (_arg1)
            {
                this.ti.width = w;
                this.ti.autoSize = "left";
                this.ti.wordWrap = true;
                this.ti.htmlText = fData.msg;
            }
            else
            {
                visible = false;
            };
        }


    }
}//package Main.Aqw.LPF

