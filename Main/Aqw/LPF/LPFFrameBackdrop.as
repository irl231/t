// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameBackdrop

package Main.Aqw.LPF
{
    import flash.display.MovieClip;

    public class LPFFrameBackdrop extends LPFFrame 
    {

        public var bg:MovieClip;

        public function LPFFrameBackdrop():void
        {
            x = 0;
            y = 0;
            fData = {};
        }

        override public function fOpen(_arg1:Object):void
        {
            fData = _arg1.fData;
            this.positionBy(_arg1.r);
            if (("eventTypes" in _arg1))
            {
                eventTypes = _arg1.eventTypes;
            };
            this.fDraw();
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
            this.fDraw();
        }

        override protected function positionBy(r:Object):void
        {
            w = r.w;
            h = r.h;
            this.bg.width = w;
            this.bg.height = h;
            x = ((r.x > -1) ? r.x : int(((fParent.w >> 1) - (width >> 1))));
            this.positionByFinal(r);
        }

        private function fDraw():void
        {
        }


    }
}//package Main.Aqw.LPF

