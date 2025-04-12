// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.FaceColor

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;

    public class FaceColor extends MovieClip 
    {

        private var _color:Number;


        public function set color(_arg1:Number):*
        {
            this._color = _arg1;
        }

        public function get color():Number
        {
            return (this._color);
        }

        public function getRGB():String
        {
            return ("0x" + this._color.toString(16));
        }


    }
}//package org.sepy.ColorPicker

