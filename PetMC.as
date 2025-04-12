// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//PetMC

package 
{
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.geom.ColorTransform;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class PetMC extends MovieClip 
    {

        public var defaultmc:MovieClip;
        public var pname:MovieClip;
        public var shadow:MovieClip;
        public var spFX:Object;
        public var pAV:Avatar;
        public var mcChar:MovieClip;
        public var ldr:Loader;
        public var game:Game;
        private var xDep:Number;
        private var yDep:Number;
        private var xTar:Number;
        private var yTar:Number;
        internal var ox:*;
        internal var oy:*;
        internal var px:*;
        internal var py:*;
        internal var tx:*;
        internal var ty:Number;
        internal var nDuration:*;
        internal var nXStep:*;
        internal var nYStep:Number;
        internal var cbx:*;
        internal var cby:Number;
        internal var defaultCT:ColorTransform;
        internal var iniTimer:Timer;

        public function PetMC()
        {
            this.ldr = new Loader();
            this.defaultCT = transform.colorTransform;
            this.spFX = {};
            super();
            this.pname.visible = false;
            this.pname.ti.text = "";
        }

        public function init():void
        {
        }

        public function walkTo(xNew:Number, yNew:Number, speedNew:Number):void
        {
            this.xDep = this.x;
            this.yDep = this.y;
            this.xTar = xNew;
            this.yTar = yNew;
            this.nDuration = Math.round((Math.sqrt((Math.pow((this.xTar - this.x), 2) + Math.pow((this.yTar - this.y), 2))) / speedNew));
            if (this.nDuration)
            {
                this.nXStep = 0;
                this.nYStep = 0;
                if ((this.xDep - this.xTar) < 0)
                {
                    this.turn("right");
                }
                else
                {
                    this.turn("left");
                };
                if (!this.mcChar.onMove)
                {
                    this.mcChar.onMove = true;
                    try
                    {
                        this.mcChar.gotoAndPlay("Walk");
                    }
                    catch(e:Error)
                    {
                    };
                };
                this.addEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk, false, 0, true);
            };
        }

        public function stopWalking():void
        {
            if (((!(this.mcChar == null)) && (this.mcChar.onMove)))
            {
                this.mcChar.onMove = false;
                try
                {
                    this.mcChar.gotoAndPlay("Idle");
                }
                catch(e:Error)
                {
                };
                this.removeEventListener(Event.ENTER_FRAME, this.onEnterFrameWalk);
            };
        }

        public function turn(_arg1:String):void
        {
            if ((((_arg1 == "right") && (this.mcChar.scaleX < 0)) || ((_arg1 == "left") && (this.mcChar.scaleX > 0))))
            {
                this.mcChar.scaleX = (this.mcChar.scaleX * -1);
            };
        }

        public function scale(scaleY:Number):void
        {
            if (this.mcChar != null)
            {
                this.mcChar.scaleX = ((this.mcChar.scaleX >= 0) ? scaleY : -(scaleY));
                this.mcChar.scaleY = scaleY;
                this.shadow.scaleX = (this.shadow.scaleY = scaleY);
                this.pname.y = (-(this.mcChar.height) - 10);
            };
        }

        private function onEnterFrameWalk(_arg1:Event):void
        {
            var xOld:Number;
            var yOld:Number;
            var shadowHit:Boolean;
            var i:int;
            var y2:Number;
            var ii:*;
            var iii:*;
            if (this.game.world == null)
            {
                return;
            };
            if (((this.nXStep <= this.nDuration) || ((this.nYStep <= this.nDuration) && (this.mcChar.onMove))))
            {
                xOld = this.x;
                yOld = this.y;
                this.x = MainController.linearTween(this.nXStep, this.xDep, (this.xTar - this.xDep), this.nDuration);
                this.y = MainController.linearTween(this.nYStep, this.yDep, (this.yTar - this.yDep), this.nDuration);
                shadowHit = false;
                i = 0;
                while (i < this.game.world.arrSolid.length)
                {
                    if (this.shadow.hitTestObject(this.game.world.arrSolid[i].shadow))
                    {
                        shadowHit = true;
                        i = this.game.world.arrSolid.length;
                    };
                    i++;
                };
                if (shadowHit)
                {
                    y2 = this.y;
                    this.y = yOld;
                    shadowHit = false;
                    ii = 0;
                    while (ii < this.game.world.arrSolid.length)
                    {
                        if (this.shadow.hitTestObject(this.game.world.arrSolid[ii].shadow))
                        {
                            this.y = y2;
                            shadowHit = true;
                            break;
                        };
                        ii++;
                    };
                    if (shadowHit)
                    {
                        this.x = xOld;
                        shadowHit = false;
                        iii = 0;
                        while (iii < this.game.world.arrSolid.length)
                        {
                            if (this.shadow.hitTestObject(this.game.world.arrSolid[iii].shadow))
                            {
                                shadowHit = true;
                                break;
                            };
                            iii++;
                        };
                        if (shadowHit)
                        {
                            this.x = xOld;
                            this.y = yOld;
                            this.stopWalking();
                        }
                        else
                        {
                            if (this.nYStep <= this.nDuration)
                            {
                                this.nYStep++;
                            };
                        };
                    }
                    else
                    {
                        if (this.nXStep <= this.nDuration)
                        {
                            this.nXStep++;
                        };
                    };
                }
                else
                {
                    if (this.nXStep <= this.nDuration)
                    {
                        this.nXStep++;
                    };
                    if (this.nYStep <= this.nDuration)
                    {
                        this.nYStep++;
                    };
                };
                if ((((Math.round(xOld) == Math.round(this.x)) && (Math.round(yOld) == Math.round(this.y))) && ((this.nXStep > 1) || (this.nYStep > 1))))
                {
                    this.stopWalking();
                };
            }
            else
            {
                this.stopWalking();
            };
        }


    }
}//package 

