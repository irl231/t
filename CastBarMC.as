// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//CastBarMC

package 
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;

    public class CastBarMC extends MovieClip 
    {

        public var cnt:MovieClip;
        public var o:Object = null;
        public var isOpen:Boolean = false;
        public var isLoop:Boolean = false;
        public var callback:Object = null;
        public var state:int = -1;
        public var dur:int = 1000;
        private var world:World;
        private var rootClass:Game;
        private var mc:MovieClip;
        private var run:int;
        private var ts:Number;
        private var date:Date;

        public function CastBarMC():void
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 5, this.frame6, 9, this.frame10);
        }

        public function init():void
        {
            this.rootClass = Game.root;
            this.mc = MovieClip(this);
        }

        public function fOpenWith(_arg1:*):void
        {
            var _local2:*;
            var _local3:*;
            this.o = _arg1;
            this.isOpen = true;
            switch (this.o.typ)
            {
                case "sia":
                    this.state = this.o.args.ID;
                case "generic":
                    this.mc.cnt.t1.text = this.o.txt;
                    _local2 = this.mc.cnt.fill;
                    this.isLoop = this.o.loop;
                    _local3 = this.mc.cnt.fillMask;
                    _local3.x = int((_local2.x - _local3.width));
                    this.run = int((_local2.x - _local3.x));
                    this.date = new Date();
                    this.ts = Number(this.date.getTime());
                    this.dur = int((1000 * this.o.dur));
                    _local3.removeEventListener(Event.ENTER_FRAME, this.slide);
                    _local3.addEventListener(Event.ENTER_FRAME, this.slide);
                    this.mc.cnt.tip.removeEventListener(Event.ENTER_FRAME, this.tipFollow);
                    this.mc.cnt.tip.addEventListener(Event.ENTER_FRAME, this.tipFollow);
                    this.mc.gotoAndPlay("in");
                    return;
            };
        }

        public function fClose():void
        {
            var _local1:*;
            if (this.isOpen)
            {
                this.o = null;
                this.state = -1;
                this.isOpen = false;
                _local1 = this.mc.cnt.fillMask;
                _local1.removeEventListener(Event.ENTER_FRAME, this.slide);
                this.mc.cnt.tip.removeEventListener(Event.ENTER_FRAME, this.tipFollow);
                this.mc.gotoAndPlay("out");
                this.rootClass.world.myAvatar.pMC.endAction();
            };
        }

        private function slide(_arg1:Event):void
        {
            var _local2:* = MovieClip(_arg1.currentTarget);
            this.date = new Date();
            var _local3:* = (this.date.getTime() - this.ts);
            var _local4:* = (_local3 / this.dur);
            if (_local4 >= 1)
            {
                this.mc.gotoAndPlay("out");
                _local2.removeEventListener(Event.ENTER_FRAME, this.slide);
                this.mc.cnt.tip.removeEventListener(Event.ENTER_FRAME, this.tipFollow);
                this.fCallback();
                if (!this.isLoop)
                {
                    this.fClose();
                };
            }
            else
            {
                _local2.x = ((this.mc.cnt.fill.x - this.mc.cnt.fillMask.width) + (this.run * _local4));
            };
        }

        private function tipFollow(_arg1:Event):void
        {
            var _local2:* = this.mc.cnt.tip;
            var _local3:* = this.mc.cnt.fillMask;
            _local2.x = ((_local3.x + _local3.width) - _local2.width);
        }

        private function fCallback():void
        {
            if (this.o.msg != null)
            {
                this.rootClass.chatF.pushMsg("event", this.o.msg, "SERVER", "", 0);
            };
            if (this.o.callback != null)
            {
                if (this.o.args != null)
                {
                    this.o.callback(this.o.args);
                }
                else
                {
                    this.o.callback();
                };
            };
            if (this.o.xtObj != null)
            {
                this.rootClass.network.send(this.o.xtObj.cmd, this.o.xtObj.args);
            };
        }

        internal function frame1():*
        {
            this.cnt.visible = false;
            this.init();
            stop();
        }

        internal function frame5():*
        {
            this.cnt.visible = true;
            this.cnt.tip.visible = true;
        }

        internal function frame6():*
        {
            stop();
        }

        internal function frame10():*
        {
            this.cnt.tip.visible = false;
        }


    }
}//package 

