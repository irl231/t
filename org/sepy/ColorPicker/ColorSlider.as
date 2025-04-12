// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.ColorSlider

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.display.BitmapData;
    import flash.events.MouseEvent;
    import flash.geom.Matrix;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ColorSlider extends MovieClip 
    {

        private var mc:MovieClip;
        private var slider:MovieClip;
        private var _color:Number;
        private var bmp:BitmapData;
        private var down:Boolean = false;

        public function ColorSlider()
        {
            addFrameScript(0, this.frame1);
            this.mc = new MovieClip();
            this.mc.name = "mc";
            this.addChildAt(this.mc, 1);
            this.mc.x = 1;
            this.mc.y = 1;
            this.mc.useHandCursor = false;
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onPressDown, false, 0, true);
            this.slider = new slider_mc();
            this.slider.name = "slider";
            this.addChildAt(this.slider, 2);
            this.slider.x = 15;
            this.slider.y = 98;
        }

        private function onPressDown(_arg1:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onUp, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMove, false, 0, true);
            this.changing(mouseY);
        }

        private function onUp(_arg1:MouseEvent):void
        {
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUp, false);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMove, false);
        }

        private function onMove(_arg1:MouseEvent):void
        {
            if (((mouseY >= 0) && (mouseY <= this.mc.height)))
            {
                this.changing(mouseY);
            };
        }

        private function changing(_arg1:Number):*
        {
            this.slider.y = _arg1;
            var _local2:Number = this.bmp.getPixel(5, this.slider.y);
            MovieClip(parent).changing(_local2);
        }

        public function getCurrentColor():Number
        {
            return (this.bmp.getPixel(5, this.slider.y));
        }

        public function set color(_arg1:Number):void
        {
            this._color = _arg1;
            this.draw();
        }

        public function get color():Number
        {
            return (this._color);
        }

        private function draw():void
        {
            this.mc.graphics.clear();
            var _local1:Array = [0, this.color, 0xFFFFFF];
            var _local2:Array = [100, 100, 100];
            var _local3:Array = [0, 127, 0xFF];
            var _local4:Matrix = new Matrix();
            _local4.createGradientBox(187, 187, ((270 * Math.PI) / 180));
            this.mc.graphics.clear();
            this.mc.graphics.beginGradientFill("linear", _local1, _local2, _local3, (_local4 as Matrix), "reflect", "linear");
            this.mc.graphics.moveTo(0, 0);
            this.mc.graphics.lineTo(12, 0);
            this.mc.graphics.lineTo(12, 187);
            this.mc.graphics.lineTo(0, 187);
            this.mc.graphics.lineTo(0, 0);
            this.mc.graphics.endFill();
            this.bmp = new BitmapData(this.mc.width, this.mc.height, false);
            this.bmp.draw(this.mc);
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package org.sepy.ColorPicker

