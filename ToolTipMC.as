// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//ToolTipMC

package 
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.geom.ColorTransform;
    import flash.events.TextEvent;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import flash.net.*;

    public class ToolTipMC extends MovieClip 
    {

        public var cnt:MovieClip;
        public var tOpen:Timer;
        public var tClose:Timer;
        private var mc:MovieClip;
        private var rootClass:Game;
        private var data:Object;
        private var tWidth:int;
        private var neutralCT:ColorTransform;
        private var blackCT:ColorTransform;

        public function ToolTipMC()
        {
            this.rootClass = Game.root;
            this.neutralCT = new ColorTransform();
            this.blackCT = new ColorTransform(0, 0, 0);
            this.tOpen = new Timer(200, 1);
            this.tClose = new Timer(10000, 1);
            super();
            addFrameScript(0, this.frame1, 9, this.frame10);
            this.mc = MovieClip(this);
            this.mc.cnt.visible = false;
            this.mc.cnt.ti.autoSize = "left";
            this.tWidth = this.mc.cnt.ti.width;
            this.mc.mouseEnabled = false;
            this.mc.mouseChildren = false;
            this.tOpen.addEventListener(TimerEvent.TIMER_COMPLETE, this.open, false, 0, true);
            this.tClose.addEventListener(TimerEvent.TIMER_COMPLETE, this.close, false, 0, true);
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOver, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseOut, false, 0, true);
            this.mc.cnt.ti.addEventListener(TextEvent.LINK, onTextLink, false, 0, true);
        }

        private static function onTextLink(_arg1:TextEvent):void
        {
            var _local2:String = String(_arg1.text.split("::")[0]).toLowerCase();
            if (_local2 == "link")
            {
                navigateToURL(new URLRequest(_arg1.text.split("::")[1]), "_blank");
            };
        }


        public function openWith(_arg1:Object):void
        {
            this.data = _arg1;
            this.tOpen.reset();
            this.tOpen.start();
            if (("closein" in this.data))
            {
                this.tClose.reset();
                this.tClose.delay = int(this.data.closein);
                this.tClose.start();
            };
        }

        public function hide():void
        {
            this.mc.cnt.visible = false;
            this.mc.x = 1050;
            this.mc.y = 0;
        }

        private function frame1():void
        {
            this.hide();
            stop();
        }

        private function frame10():void
        {
            stop();
        }

        public function open(_arg1:TimerEvent):void
        {
            this.mc.cnt.visible = true;
            this.mc.cnt.ti.width = this.tWidth;
            this.mc.cnt.ti.htmlText = this.data.str;
            this.mc.cnt.ti.width = (int(this.mc.cnt.ti.textWidth) + 6);
            this.mc.cnt.bg.width = (int(this.mc.cnt.ti.width) + 10);
            this.mc.cnt.bg.height = ((int(this.mc.cnt.ti.height) == 20) ? 20 : (int(this.mc.cnt.ti.height) + 2));
            if ((("invert" in this.data) && (this.data.invert)))
            {
                this.mc.cnt.bg.transform.colorTransform = this.blackCT;
            }
            else
            {
                this.mc.cnt.bg.transform.colorTransform = this.neutralCT;
            };
            if (("lowerright" in this.data))
            {
                this.mc.x = ((960 - this.mc.cnt.bg.width) - 4);
                this.mc.y = ((480 - this.mc.cnt.bg.height) - 4);
            }
            else
            {
                this.mc.x = ((this.rootClass.mouseX - (this.mc.width >> 1)) - this.rootClass.ui.x);
                this.mc.y = ((this.rootClass.mouseY - this.mc.height) - 15);
                if ((this.mc.x + this.mc.cnt.bg.width) > 960)
                {
                    this.mc.x = ((960 - this.mc.cnt.bg.width) - 10);
                };
                if (this.mc.x < 1)
                {
                    this.mc.x = 1;
                };
                if (this.mc.y < 1)
                {
                    this.mc.y = (this.rootClass.mouseY + 10);
                };
            };
            if (this.data.str.indexOf("href") > -1)
            {
                this.mc.mouseEnabled = false;
                this.mc.mouseChildren = true;
            }
            else
            {
                this.mc.mouseEnabled = false;
                this.mc.mouseChildren = false;
            };
            if ((("frommap" in this.data) && (this.data.frommap)))
            {
                this.mc.x = this.data.x;
                this.mc.y = this.data.y;
            }
            else
            {
                this.mc.x = int(this.mc.x);
                this.mc.y = int(this.mc.y);
            };
            this.mc.gotoAndPlay("in");
        }

        public function close(_arg1:Event=null):void
        {
            this.tOpen.reset();
            this.tClose.reset();
            this.mc.gotoAndPlay("out");
        }

        private function onMouseOut(_arg1:MouseEvent):void
        {
            if (this.tOpen.running)
            {
                this.tOpen.stop();
            };
            if (this.tClose.running)
            {
                this.tClose.stop();
            };
            this.close();
        }

        private function onMouseOver(_arg1:MouseEvent):void
        {
            this.tClose.reset();
        }


    }
}//package 

