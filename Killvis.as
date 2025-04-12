// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Killvis

package 
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.display.MovieClip;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Killvis extends EventDispatcher 
    {

        private var vobj:Object;
        private var vTimer:Timer;

        public function Killvis()
        {
            this.vTimer = new Timer(1000, 1);
            this.vTimer.addEventListener(TimerEvent.TIMER, this.noVis, false, 0, true);
            super();
        }

        public function kill(target:Object, delay:int):void
        {
            this.vobj = target;
            this.vTimer.delay = delay;
            this.vTimer.reset();
            this.vTimer.start();
        }

        public function stopkill():void
        {
            if (((this.vTimer) && (this.vTimer.running)))
            {
                this.vTimer.stop();
            };
        }

        public function resetkill():void
        {
            if (((this.vTimer) && (this.vTimer.running)))
            {
                this.vTimer.reset();
                this.vTimer.start();
            };
        }

        private function noVis(event:TimerEvent):void
        {
            var parentClip:MovieClip;
            if (this.vobj)
            {
                this.vobj.visible = false;
                parentClip = MovieClip(MovieClip(this.vobj).parent);
                if (parentClip)
                {
                    parentClip.kv = null;
                };
            };
        }


    }
}//package 

