// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.AdvColorPanel

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.display.*;
    import flash.geom.*;

    public class AdvColorPanel extends MovieClip 
    {

        private var _color:Object;
        private var color_map:MovieClip;
        private var color_slider:MovieClip;
        private var color_display:MovieClip;
        private var ok_btn:MovieClip;
        private var close_btn:MovieClip;
        private var _hue:Number;
        private var _saturation:Number;
        private var _luminosity:Number;
        private var _red:Number;
        private var _green:Number;
        private var _blue:Number;
        private var _hue_mc:MovieClip;
        private var _saturation_mc:MovieClip;
        private var _luminosity_mc:MovieClip;
        private var _red_mc:MovieClip;
        private var _green_mc:MovieClip;
        private var _blue_mc:MovieClip;
        private var _hlsrgb:HLSRGB;

        public function AdvColorPanel(_arg1:Object)
        {
            addFrameScript(0, this.frame1);
            this._hlsrgb = new HLSRGB();
            this.color_map = (new ColorMap() as MovieClip);
            this.color_map.name = "color_map";
            this.addChild(this.color_map);
            this.color_map.x = 10;
            this.color_map.y = 8;
            this.color_slider = (new ColorSlider() as MovieClip);
            this.color_slider.name = "color_slider";
            this.addChildAt(this.color_slider, 1);
            this.color_slider.x = ((this.color_map.x + this.color_map.width) + 10);
            this.color_slider.y = this.color_map.y;
            this.color_display = (new ColorDisplay() as MovieClip);
            this.color_display.name = "color_display";
            this.addChildAt(this.color_display, 2);
            this.color_display.x = this.color_map.x;
            this.color_display.y = (this.color_map.y + this.color_map.height);
            this._hue_mc = (new IntInput("H", "dynamic") as MovieClip);
            this._hue_mc.name = "_hue_mc";
            this.addChildAt(this._hue_mc, 3);
            this._hue_mc.x = 125;
            this._hue_mc.y = (this.color_map.y + this.color_map.height);
            this._saturation_mc = (new IntInput("S", "dynamic") as MovieClip);
            this._saturation_mc.name = "_saturation_mc";
            this.addChildAt(this._saturation_mc, 4);
            this._saturation_mc.x = this._hue_mc.x;
            this._saturation_mc.y = ((this._hue_mc.y + this._hue_mc.height) + 2);
            this._luminosity_mc = (new IntInput("L", "dynamic") as MovieClip);
            this._luminosity_mc.name = "_luminosity_mc";
            this.addChildAt(this._luminosity_mc, 5);
            this._luminosity_mc.x = this._hue_mc.x;
            this._luminosity_mc.y = ((this._saturation_mc.y + this._saturation_mc.height) + 2);
            this._red_mc = (new IntInput("R", "input") as MovieClip);
            this._red_mc.name = "_red_mc";
            this.addChildAt(this._red_mc, 6);
            this._red_mc.x = 175;
            this._red_mc.y = this._hue_mc.y;
            this._green_mc = (new IntInput("G", "input") as MovieClip);
            this._green_mc.name = "_green_mc";
            this.addChildAt(this._green_mc, 7);
            this._green_mc.x = 175;
            this._green_mc.y = this._saturation_mc.y;
            this._blue_mc = (new IntInput("B", "input") as MovieClip);
            this._blue_mc.name = "_blue_mc";
            this.addChildAt(this._blue_mc, 8);
            this._blue_mc.x = 175;
            this._blue_mc.y = this._luminosity_mc.y;
            this.ok_btn = (new OkButton() as MovieClip);
            this.ok_btn.name = "ok_btn";
            this.addChildAt(this.ok_btn, 9);
            this.ok_btn.x = this.color_map.x;
            this.ok_btn.y = this._blue_mc.y;
            this.close_btn = (new CancelButton() as MovieClip);
            this.close_btn.name = "close_btn";
            this.addChildAt(this.close_btn, 10);
            this.close_btn.x = (this.ok_btn.x + this.ok_btn.width);
            this.close_btn.y = this._blue_mc.y;
            this.color = _arg1;
            this.init();
        }

        public static function ColorToRGB(_arg1:Number):Object
        {
            var _local2:Object = new Object();
            _local2.red = ((_arg1 >> 16) & 0xFF);
            _local2.green = ((_arg1 >> 8) & 0xFF);
            _local2.blue = (_arg1 & 0xFF);
            return (_local2);
        }


        internal function init():*
        {
            this._hue_mc.max = 360;
            this._saturation_mc.max = 240;
            this._luminosity_mc.max = 240;
            this._red_mc.max = 0xFF;
            this._green_mc.max = 0xFF;
            this._blue_mc.max = 0xFF;
            this.color_slider.color = this.color;
            if (this.color_map.findTheColor(this.RGBtoColor(this.color)))
            {
            };
            this.change(this, this.RGBtoColor(this.color));
            this.updateHLS(this.color_slider.getCurrentColor(), true);
        }

        public function changed(_arg1:MovieClip, _arg2:Number):void
        {
            this._hlsrgb.color = new RGB(this._red_mc.value, this._green_mc.value, this._blue_mc.value);
            var _local3:Number = this._hlsrgb.getRGB();
            this.color_map.findTheColor(_local3);
            this.change(this, _local3);
        }

        private function RGBtoColor(_arg1:Object):int
        {
            var _local2:int;
            _local2 = (_local2 + (_arg1.red << 16));
            _local2 = (_local2 + (_arg1.green << 8));
            _local2 = (_local2 + _arg1.blue);
            return (_local2);
        }

        public function change(_arg1:MovieClip, _arg2:Number):void
        {
            var _local3:Object = ColorToRGB(_arg2);
            if (_arg1 == this.color_map)
            {
                this.color = _local3;
                this.color_slider.color = _arg2;
                this.color_display.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _local3.red, _local3.green, _local3.blue, 0);
                this.updateHLS(this.color_slider.getCurrentColor(), true);
            }
            else
            {
                if (_arg1 == this)
                {
                    this.color = _local3;
                    this.color_slider.color = _arg2;
                    this.color_display.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _local3.red, _local3.green, _local3.blue, 0);
                    this.updateHLS(this.color_slider.getCurrentColor(), false);
                };
            };
        }

        public function changing(_arg1:Number):void
        {
            var _local2:Object = ColorToRGB(_arg1);
            this.color_display.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _local2.red, _local2.green, _local2.blue, 0);
            this.color = _local2;
            this.updateHLS(this.color_slider.getCurrentColor(), true);
        }

        private function updateHLS(_arg1:Number, _arg2:Boolean):*
        {
            var _local3:Object;
            if (_arg2)
            {
                _local3 = ColorPicker2.ColorToRGB(_arg1);
                this._hlsrgb.hue = (this._hlsrgb.saturation = (this._hlsrgb.luminance = 0));
                this._hlsrgb.red = _local3.red;
                this._hlsrgb.green = _local3.green;
                this._hlsrgb.blue = _local3.blue;
            };
            this.red = Math.round(this._hlsrgb.red);
            this.green = Math.round(this._hlsrgb.green);
            this.blue = Math.round(this._hlsrgb.blue);
            this.hue = this._hlsrgb.hue;
            this.saturation = this._hlsrgb.saturation;
            this.luminosity = this._hlsrgb.luminance;
        }

        public function click(_arg1:MovieClip):*
        {
            if (_arg1 == this.ok_btn)
            {
                MovieClip(parent).click(this);
            }
            else
            {
                if (_arg1 == this.close_btn)
                {
                    MovieClip(parent)._opened = false;
                    MovieClip(parent).advancedColorPanel = null;
                    MovieClip(parent).removeChild(this);
                };
            };
        }

        public function set color(_arg1:Object):*
        {
            this._color = _arg1;
        }

        public function get color():Object
        {
            return (this._color);
        }

        public function set hue(_arg1:Number):*
        {
            _arg1 = Math.round(_arg1);
            this._hue = _arg1;
            this._hue_mc.value = _arg1;
        }

        public function set saturation(_arg1:Number):*
        {
            _arg1 = Math.round((_arg1 * 240));
            this._saturation = _arg1;
            this._saturation_mc.value = _arg1;
        }

        public function set luminosity(_arg1:Number):*
        {
            _arg1 = Math.round((_arg1 * 240));
            this._luminosity = _arg1;
            this._luminosity_mc.value = _arg1;
        }

        public function set red(_arg1:Number):*
        {
            this._red = _arg1;
            this._red_mc.value = _arg1;
        }

        public function set green(_arg1:Number):*
        {
            this._green = _arg1;
            this._green_mc.value = _arg1;
        }

        public function set blue(_arg1:Number):*
        {
            this._blue = _arg1;
            this._blue_mc.value = _arg1;
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package org.sepy.ColorPicker

