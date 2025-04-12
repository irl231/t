// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.OkButton

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;

    public class OkButton extends MovieClip 
    {

        public function OkButton()
        {
            addFrameScript(0, this.frame1);
            useHandCursor = false;
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onRollOver, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onRollOut, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onPress, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onRelease, false, 0, true);
        }

        private function onRollOver(_arg1:MouseEvent):void
        {
            this.gotoAndStop(1);
        }

        private function onRollOut(_arg1:MouseEvent):void
        {
            gotoAndStop(1);
        }

        internal function onPress(_arg1:MouseEvent):void
        {
            gotoAndStop(2);
        }

        internal function onRelease(_arg1:MouseEvent):void
        {
            gotoAndStop(1);
            MovieClip(parent).click(this);
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package org.sepy.ColorPicker

