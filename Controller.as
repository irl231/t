// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Controller

package 
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.events.*;
    import flash.utils.*;

    public class Controller extends MovieClip 
    {

        public var ring:MovieClip;
        public var joystick:MovieClip;
        public var myAvatar:MovieClip;
        public var angle:int = 0;
        public var radius:int = 100;
        public var rootClass:Game;
        public var onMoveCounter:int = 1;
        public var defaultPositionX:int = 0;
        public var defaultPositionY:int = 0;
        public var newPositionY:int = 0;
        public var newPositionX:int = 0;
        public var firstMove:Boolean = false;
        public var onDrag:Boolean = false;
        private var positionX:Number;
        private var positionY:Number;

        public function Controller()
        {
            this.rootClass = Game.root;
            addFrameScript(0, this.frame1);
        }

        public function resetController():*
        {
            if (this.myAvatar != null)
            {
                this.myAvatar.stopWalking();
            };
            this.joystick.knob.x = this.defaultPositionX;
            this.joystick.knob.y = this.defaultPositionY;
            this.onDrag = false;
        }

        protected function onControllerMove(event:*):void
        {
            var oldPositionX:Number;
            var oldPositionY:Number;
            if (this.onDrag)
            {
                this.angle = (Math.atan2((mouseY - this.positionY), (mouseX - this.positionX)) / (Math.PI / 180));
                if (this.rootClass.world.strFrame != this.rootClass.world.map.currentLabel)
                {
                    this.resetController();
                    return;
                };
                this.joystick.rotation = this.angle;
                this.joystick.knob.rotation = -(this.angle);
                this.joystick.knob.x = this.joystick.mouseX;
                if (this.joystick.knob.x > this.radius)
                {
                    this.joystick.knob.x = this.radius;
                };
                if (this.myAvatar.y < 0)
                {
                    this.myAvatar.y = 0;
                };
                if (this.myAvatar.y > this.rootClass.stage.stageHeight)
                {
                    this.myAvatar.y = this.rootClass.stage.stageHeight;
                };
                if (this.myAvatar.x < 0)
                {
                    this.myAvatar.x = 0;
                };
                if (this.myAvatar.x > this.rootClass.stage.stageWidth)
                {
                    this.myAvatar.x = this.rootClass.stage.stageWidth;
                };
                oldPositionX = this.myAvatar.x;
                oldPositionY = this.myAvatar.y;
                this.newPositionY = (this.myAvatar.y + (Math.sin((this.angle * (Math.PI / 180))) * (this.joystick.knob.x / 8)));
                this.newPositionX = (this.myAvatar.x + (Math.cos((this.angle * (Math.PI / 180))) * (this.joystick.knob.x / 8)));
                this.newPositionX = (this.newPositionX + ((this.newPositionX < oldPositionX) ? -10 : 10));
                this.newPositionY = (this.newPositionY + ((this.newPositionY < oldPositionY) ? -10 : 10));
                if (!this.firstMove)
                {
                    this.firstMove = true;
                    this.rootClass.world.uoTreeLeafSet(this.rootClass.network.myUserName, {
                        "tx":this.newPositionX,
                        "ty":this.newPositionY,
                        "sp":this.rootClass.world.WALKSPEED
                    });
                    this.myAvatar.walkTo(this.newPositionX, this.newPositionY, this.rootClass.world.WALKSPEED);
                };
                if (this.myAvatar.mcChar.currentLabel != "Walk")
                {
                    this.myAvatar.mcChar.gotoAndPlay("Walk");
                };
            };
        }

        internal function frame1():*
        {
            this.positionX = this.joystick.x;
            this.positionY = this.joystick.y;
            this.defaultPositionX = this.joystick.knob.x;
            this.defaultPositionY = this.joystick.knob.y;
            this.joystick.addEventListener(MouseEvent.MOUSE_DOWN, this.onControllerDown);
            this.rootClass.stage.addEventListener(MouseEvent.MOUSE_UP, this.onControllerUp);
            var updateEveryone:Timer = new Timer(5000);
            updateEveryone.start();
            updateEveryone.addEventListener(TimerEvent.TIMER, this.walkEveryone);
            var updateYou:Timer = new Timer(100);
            updateYou.start();
            updateYou.addEventListener(TimerEvent.TIMER, this.walkYou);
        }

        public function onControllerDown(event:MouseEvent):void
        {
            this.myAvatar = this.rootClass.world.myAvatar.pMC;
            this.onDrag = true;
            if (!this.rootClass.stage.hasEventListener(Event.ENTER_FRAME))
            {
                this.rootClass.stage.addEventListener(Event.ENTER_FRAME, this.onControllerMove);
            };
        }

        protected function onControllerUp(event:MouseEvent):void
        {
            if (this.myAvatar == null)
            {
                return;
            };
            if (this.rootClass.stage.hasEventListener(Event.ENTER_FRAME))
            {
                this.rootClass.stage.removeEventListener(Event.ENTER_FRAME, this.onControllerMove);
            };
            this.myAvatar.stopWalking();
            this.joystick.knob.x = this.defaultPositionX;
            this.joystick.knob.y = this.defaultPositionY;
            this.firstMove = false;
        }

        internal function walkEveryone(event:TimerEvent):void
        {
            if (this.myAvatar == null)
            {
                return;
            };
            if (((this.joystick.knob.x == this.defaultPositionX) && (this.joystick.knob.y == this.defaultPositionY)))
            {
            };
        }

        internal function walkYou(event:TimerEvent):void
        {
            if (this.myAvatar == null)
            {
                return;
            };
            if (((this.joystick.knob.x == this.defaultPositionX) && (this.joystick.knob.y == this.defaultPositionY)))
            {
                if (this.onDrag)
                {
                    this.onDrag = false;
                    this.myAvatar.stopWalking();
                };
            }
            else
            {
                this.rootClass.world.uoTreeLeafSet(this.rootClass.network.myUserName, {
                    "tx":this.newPositionX,
                    "ty":this.newPositionY,
                    "sp":this.rootClass.world.WALKSPEED
                });
                this.myAvatar.walkTo(this.newPositionX, this.newPositionY, this.rootClass.world.WALKSPEED);
            };
        }


    }
}//package 

