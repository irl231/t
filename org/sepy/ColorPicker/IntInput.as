// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.IntInput

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class IntInput extends MovieClip 
    {

        public var _value:Number;
        private var broadcastMessage:Function;
        private var input:TextField;
        private var tlabel:TextField;
        private var _label:String;
        private var _max:Number;

        public function IntInput(_arg1:String, _arg2:String)
        {
            var _local3:TextFormat;
            super();
            _local3 = new TextFormat();
            _local3.font = "_sans";
            _local3.size = 10;
            this.tlabel = new TextField();
            this.tlabel.width = 31;
            this.tlabel.height = 16;
            this.addChildAt(this.tlabel, 1);
            this.tlabel.x = 2;
            this.tlabel.y = 1;
            this.tlabel.defaultTextFormat = _local3;
            this.tlabel.text = _arg1;
            this.input = new TextField();
            this.input.height = 16;
            this.input.width = 31;
            this.input.name = "input";
            this.addChildAt(this.input, 2);
            this.input.x = 22;
            this.input.y = 1;
            this.input.type = _arg2;
            this.input.maxChars = 3;
            this.input.restrict = "[0-9]";
            this.input.defaultTextFormat = _local3;
            this.input.addEventListener(Event.CHANGE, this.onChanged, false, 0, true);
        }

        public function set value(_arg1:Number):*
        {
            this._value = _arg1;
            this.input.text = this._value.toString(10);
        }

        public function get value():Number
        {
            return (this._value);
        }

        private function onChanged(_arg1:Event):*
        {
            var _local2:Number = Number(this.input.text);
            if (isNaN(_local2))
            {
                this.input.text = "0";
            };
            if (_local2 > this._max)
            {
                this.input.text = this._max.toString();
            };
            this._value = Number(this.input.text);
            MovieClip(parent).changed(this, Number(this.input.text));
        }

        public function set label(_arg1:String):void
        {
            this._label = _arg1;
            this.tlabel.text = _arg1;
        }

        public function get label():String
        {
            return (this._label);
        }

        public function set max(_arg1:Number):*
        {
            this._max = _arg1;
        }

        public function get max():Number
        {
            return (this._max);
        }


    }
}//package org.sepy.ColorPicker

