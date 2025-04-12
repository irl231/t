// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//dotDisplay

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public class dotDisplay extends MovieClip 
    {

        public var t:MovieClip;
        public var hpDisplay:int;
        public var randNum:Number = Math.random();

        public function dotDisplay():void
        {
            addFrameScript(0, this.frame1, 2, this.frame3, 18, this.frame19, 19, this.frame20, 41, this.frame42, 42, this.frame43, 61, this.frame62, 62, this.frame63, 83, this.frame84, 84, this.frame85, 110, this.frame111, 111, this.frame112, 132, this.frame133, 133, this.frame134, 162, this.frame163, 163, this.frame164, 184, this.frame185, 185, this.frame186, 211, this.frame212, 212, this.frame213, 233, this.frame234);
        }

        public function init():void
        {
            if (this.randNum <= 0.1)
            {
                gotoAndPlay("dot1");
            }
            else
            {
                if (((this.randNum <= 0.2) && (this.randNum > 0.1)))
                {
                    gotoAndPlay("dot2");
                }
                else
                {
                    if (((this.randNum <= 0.3) && (this.randNum > 0.2)))
                    {
                        gotoAndPlay("dot3");
                    }
                    else
                    {
                        if (((this.randNum <= 0.4) && (this.randNum > 0.3)))
                        {
                            gotoAndPlay("dot4");
                        }
                        else
                        {
                            if (((this.randNum <= 0.5) && (this.randNum > 0.4)))
                            {
                                gotoAndPlay("dot5");
                            }
                            else
                            {
                                if (((this.randNum <= 0.6) && (this.randNum > 0.5)))
                                {
                                    gotoAndPlay("dot6");
                                }
                                else
                                {
                                    if (((this.randNum <= 0.7) && (this.randNum > 0.6)))
                                    {
                                        gotoAndPlay("dot7");
                                    }
                                    else
                                    {
                                        if (((this.randNum <= 0.8) && (this.randNum > 0.7)))
                                        {
                                            gotoAndPlay("dot8");
                                        }
                                        else
                                        {
                                            if (((this.randNum <= 0.9) && (this.randNum > 0.8)))
                                            {
                                                gotoAndPlay("dot9");
                                            }
                                            else
                                            {
                                                if (((this.randNum <= 1) && (this.randNum > 0.9)))
                                                {
                                                    gotoAndPlay("dot10");
                                                }
                                                else
                                                {
                                                    gotoAndPlay("dot1");
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function setText():void
        {
            if (this.hpDisplay > 0)
            {
                this.t.ti.textColor = 0xEE9900;
            };
            this.t.ti.text = Math.abs(this.hpDisplay);
            if (!Game.root.userPreference.data.enableRenderCombatTextAsBitmap)
            {
                Game.spriteToBitmap(this.t);
            };
        }

        private function frame1():void
        {
            this.randNum = -1;
            stop();
        }

        private function frame3():void
        {
            this.setText();
        }

        private function frame19():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame20():void
        {
            this.setText();
        }

        private function frame42():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame43():void
        {
            this.setText();
        }

        private function frame62():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame63():void
        {
            this.setText();
        }

        private function frame84():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame85():void
        {
            this.setText();
        }

        private function frame111():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame112():void
        {
            this.setText();
        }

        private function frame133():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame134():void
        {
            this.setText();
        }

        private function frame163():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame164():void
        {
            this.setText();
        }

        private function frame185():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame186():void
        {
            this.setText();
        }

        private function frame212():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function frame213():void
        {
            this.setText();
        }

        private function frame234():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }


    }
}//package 

