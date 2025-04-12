// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.ColorBox

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.display.*;
    import flash.geom.*;

    public class ColorBox extends MovieClip 
    {

        private var faceMC:MovieClip;
        private var face_border:MovieClip;
        private var colorObj:Object;

        public function ColorBox(_arg1:Object)
        {
            this.colorObj = _arg1;
            this.useHandCursor = false;
            this.faceMC = (new FaceColor() as MovieClip);
            this.faceMC.name = "face";
            this.addChild(this.faceMC);
            this.faceMC.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _arg1.red, _arg1.green, _arg1.blue, 0);
            this.face_border = (new face_borders() as MovieClip);
            this.face_border.name = "face_border";
            this.addChild(this.face_border);
        }

        public function get color():Object
        {
            return (this.colorObj);
        }

        public function getRGB():String
        {
            return ("0x" + this.faceMC.color.toString(16));
        }


    }
}//package org.sepy.ColorPicker

