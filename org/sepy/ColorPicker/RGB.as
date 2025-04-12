// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.RGB

package org.sepy.ColorPicker
{
    public class RGB 
    {

        private var _r:Number;
        private var _g:Number;
        private var _b:Number;

        public function RGB(_arg1:Number, _arg2:Number, _arg3:Number)
        {
            this._r = _arg1;
            this._g = _arg2;
            this._b = _arg3;
        }

        public function set r(_arg1:Number):void
        {
            this._r = _arg1;
        }

        public function get r():Number
        {
            return (this._r);
        }

        public function set g(_arg1:Number):void
        {
            this._g = _arg1;
        }

        public function get g():Number
        {
            return (this._g);
        }

        public function set b(_arg1:Number):void
        {
            this._b = _arg1;
        }

        public function get b():Number
        {
            return (this._b);
        }

        public function getRGB():Number
        {
            return (((this.r << 16) | (this.g << 8)) | this.b);
        }

        public function toString():String
        {
            return (((((("[R:" + this.r) + ", G:") + this.g) + ", B:") + this.b) + "]");
        }


    }
}//package org.sepy.ColorPicker

