// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.ColorInput

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ColorInput extends MovieClip 
    {

        public var _color:Number;
        private var input:TextField;

        public function ColorInput()
        {
            var _local1:TextFormat;
            super();
            _local1 = new TextFormat();
            _local1.font = "_sans";
            _local1.size = 10;
            this.input = new TextField();
            this.input.name = "input";
            this.input.width = 57;
            this.input.height = 16;
            this.addChildAt(this.input, 1);
            this.input.x = 2;
            this.input.y = 1;
            this.input.type = "input";
            this.input.maxChars = 7;
            this.input.defaultTextFormat = _local1;
            this.input.addEventListener(Event.CHANGE, this.onInput, false, 0, true);
        }

        public function set color(_arg1:Number):*
        {
            this._color = _arg1;
            this.input.text = ("#" + ColorPicker2.ColorToString(_arg1));
        }

        public function get color():Number
        {
            return (this._color);
        }

        private function onInput(_arg1:Event):void
        {
            MovieClip(parent.parent).changed(TextField(_arg1.currentTarget).text);
        }


    }
}//package org.sepy.ColorPicker

