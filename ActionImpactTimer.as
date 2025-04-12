// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//ActionImpactTimer

package 
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.*;
    import flash.utils.*;

    public class ActionImpactTimer extends EventDispatcher 
    {

        public var actID:int;
        public var actionResult:Object;
        public var aTimer:Timer;


        public function showImpact(time:int):void
        {
            this.aTimer = new Timer(time, 1);
            this.aTimer.addEventListener(TimerEvent.TIMER, this.triggerResult, false, 0, true);
            this.aTimer.start();
        }

        public function kill():void
        {
            if (((!(this.aTimer == null)) && (this.aTimer.running)))
            {
                this.aTimer.stop();
            };
            this.aTimer.removeEventListener(TimerEvent.TIMER, this.triggerResult);
            this.aTimer = null;
            this.actionResult = null;
        }

        public function triggerResult(timerEvent:TimerEvent):void
        {
            if (Game.root.world != null)
            {
                Game.root.world.showActionImpact(this.actionResult);
            };
            this.kill();
        }


    }
}//package 

