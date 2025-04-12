// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.ColorMap

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ColorMap extends MovieClip 
    {

        private var mc:Sprite;
        private var cross_Mc:MovieClip;
        private var cross_Mask:MovieClip;
        public var newMC:*;
        private var b:Bitmap;
        private var bmp:BitmapData;
        private var _color:Number;
        private var down:Boolean = false;
        public var m_fillType:String = "linear";
        public var m_colors:Array;
        public var m_alphas:Array;
        public var m_ratios:Array;
        public var m_matrix:Matrix;

        public function ColorMap()
        {
            this.m_colors = [0xFF0000, 0xFFFF00, 0xFF00, 0xFFFF, 0xFF, 0xFF00FF, 0xFF0000];
            this.m_alphas = [100, 100, 100, 100, 100, 100, 100];
            this.m_ratios = [0, 42, 64, 127, 184, 215, 0xFF];
            this.m_matrix = new Matrix();
            super();
            addFrameScript(0, this.frame1);
            this.mc = new Sprite();
            this.mc.name = "mc";
            this.addChild(this.mc);
            this.mc.x = 1;
            this.mc.y = 1;
            this.cross_Mc = (new cross_mc() as MovieClip);
            this.cross_Mc.name = "cross_mc";
            this.addChild(this.cross_Mc);
            this.cross_Mask = (new cross_mask() as MovieClip);
            this.cross_Mask.name = "cross_mask";
            this.addChild(this.cross_Mask);
            this.cross_Mc.mask = this.cross_Mask;
            this.init();
        }

        private function init():void
        {
            var _local1:* = "linear";
            var _local2:Array = [0xFFFFFF, 0, 0];
            var _local3:Array = [0, 0, 100];
            var _local4:Array = [0, 127, 0xFF];
            var _local5:Matrix = new Matrix();
            _local5.createGradientBox(175, 187, ((90 * Math.PI) / 180));
            this.m_matrix.createGradientBox(175, 187);
            this.mc.graphics.beginGradientFill(this.m_fillType, this.m_colors, this.m_alphas, this.m_ratios, (this.m_matrix as Matrix));
            this.mc.graphics.moveTo(0, 0);
            this.mc.graphics.lineTo(175, 0);
            this.mc.graphics.lineTo(175, 187);
            this.mc.graphics.lineTo(0, 187);
            this.mc.graphics.lineTo(0, 0);
            this.mc.graphics.endFill();
            this.newMC = new MovieClip();
            this.newMC.name = "upper";
            this.mc.addChild(this.newMC);
            this.newMC.graphics.beginGradientFill(_local1, _local2, _local3, _local4, (_local5 as Matrix));
            this.newMC.graphics.moveTo(0, 0);
            this.newMC.graphics.lineTo(175, 0);
            this.newMC.graphics.lineTo(175, 187);
            this.newMC.graphics.lineTo(0, 187);
            this.newMC.graphics.lineTo(0, 0);
            this.newMC.graphics.endFill();
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onDown, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onUp, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_MOVE, this.onMove, false, 0, true);
            this.draw();
        }

        private function onDown(_arg1:MouseEvent):void
        {
            this.down = true;
            this.onMove(_arg1);
        }

        private function onUp(_arg1:MouseEvent):void
        {
            this.down = false;
        }

        private function onMove(_arg1:MouseEvent):void
        {
            var _local2:Number;
            if (this.down)
            {
                _local2 = this.bmp.getPixel(((mouseX - this.mc.x) - 1), (mouseY - this.mc.y));
                this.cross_Mc.x = mouseX;
                this.cross_Mc.y = mouseY;
                MovieClip(parent).change(this, _local2);
            };
        }

        private function draw():void
        {
            this.bmp = new BitmapData(this.mc.width, this.mc.height);
            this.bmp.draw(this.mc);
        }

        private function change(_arg1:MovieClip, _arg2:Number):*
        {
            this._color = _arg2;
        }

        public function set color(_arg1:Number):void
        {
            this._color = _arg1;
        }

        public function get color():Number
        {
            return (this._color);
        }

        public function findTheColor(_arg1:Number):Boolean
        {
            var _local2:Rectangle = this.bmp.getColorBoundsRect(0xFFFFFFFF, (0xFF000000 + _arg1), true);
            this.cross_Mc.x = ((_local2.x + (_local2.width / 2)) + 2);
            this.cross_Mc.y = ((_local2.y + (_local2.height / 2)) + 2);
            return (!((((_local2.x == 0) && (_local2.y == 0)) && (_local2.width == this.bmp.width)) && (_local2.width == this.bmp.height)));
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package org.sepy.ColorPicker

