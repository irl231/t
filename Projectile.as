// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Projectile

package 
{
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Projectile extends MovieClip 
    {

        private const velocity:Number = 1500;

        private var rootClass:Game;
        private var interPoint:Point;
        private var pointStart:Point;
        private var mc:MovieClip;
        private var startTime:Number = 0;
        private var curTime:Number;
        private var timeTotal:Number;
        private var mcParent:MovieClip;
        private var xPos:Number;
        private var yPos:Number;
        private var tempPoint:Point;

        public function Projectile(_arg1:Point, _arg2:Point, _arg3:MovieClip, _arg4:MovieClip)
        {
            this.interPoint = new Point();
            super();
            this.rootClass = _arg4;
            this.pointStart = _arg1;
            this.interPoint.x = (_arg2.x - _arg1.x);
            this.interPoint.y = (_arg2.y - _arg1.y);
            this.mc = _arg3;
            this.mc.scaleX = ((this.interPoint.x < 0) ? (this.mc.scaleX * -1) : this.mc.scaleX);
            this.mcParent = MovieClip(this.mc.parent);
            var _local5:Number = (_arg2.x - _arg1.x);
            var _local6:Number = (_arg2.y - _arg1.y);
            var _local7:Number = Math.sqrt(((_local5 * _local5) + (_local6 * _local6)));
            this.timeTotal = (1000 * (_local7 / this.velocity));
            this.startTime = getTimer();
            this.addEventListener(Event.ENTER_FRAME, this.onEnter, false, 0, true);
        }

        private function onEnter(_arg1:Event):void
        {
            this.curTime = (getTimer() - this.startTime);
            this.curTime = ((this.curTime >= this.timeTotal) ? this.timeTotal : this.curTime);
            this.xPos = (this.pointStart.x + (this.interPoint.x * (this.curTime / this.timeTotal)));
            this.yPos = (this.pointStart.y + (this.interPoint.y * (this.curTime / this.timeTotal)));
            this.mc.x = (this.pointStart.x + (this.interPoint.x * (this.curTime / this.timeTotal)));
            this.mc.y = (this.pointStart.y + (this.interPoint.y * (this.curTime / this.timeTotal)));
            if (this.curTime >= this.timeTotal)
            {
                this.mc.visible = false;
                this.mcParent.removeChild(this.mc);
                this.removeEventListener(Event.ENTER_FRAME, this.onEnter);
                return;
            };
        }


    }
}//package 

