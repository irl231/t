// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.HLSRGB

package org.sepy.ColorPicker
{
    import org.sepy.ColorPicker.RGB;
    import org.sepy.ColorPicker.*;

    internal class HLSRGB 
    {

        private var _red:Number = 0;
        private var _green:Number = 0;
        private var _blue:Number = 0;
        private var _hue:Number = 0;
        private var _luminance:Number = 0;
        private var _saturation:Number = 0;


        public function get red():Number
        {
            return (this._red);
        }

        public function set red(_arg1:Number):void
        {
            this._red = _arg1;
            this.ToHLS();
        }

        public function get green():Number
        {
            return (this._green);
        }

        public function set green(_arg1:Number):void
        {
            this._green = _arg1;
            this.ToHLS();
        }

        public function get blue():Number
        {
            return (this._blue);
        }

        public function set blue(_arg1:Number):void
        {
            this._blue = _arg1;
            this.ToHLS();
        }

        public function get luminance():Number
        {
            return (this._luminance);
        }

        public function set luminance(_arg1:Number):void
        {
            if (!((_arg1 < 0) || (_arg1 > 1)))
            {
                this._luminance = _arg1;
                this.ToRGB();
            };
        }

        public function get hue():Number
        {
            return (this._hue);
        }

        public function set hue(_arg1:Number):void
        {
            if (!((_arg1 < 0) || (_arg1 > 360)))
            {
                this._hue = _arg1;
                this.ToRGB();
            };
        }

        public function get saturation():Number
        {
            return (this._saturation);
        }

        public function set saturation(_arg1:Number):void
        {
            if (!((_arg1 < 0) || (_arg1 > 1)))
            {
                this._saturation = _arg1;
                this.ToRGB();
            };
        }

        public function get color():RGB
        {
            var _local1:* = new RGB(this._red, this._green, this._blue);
            return (_local1);
        }

        public function getRGB():Number
        {
            return (((this._red << 16) | (this._green << 8)) | this._blue);
        }

        public function set color(_arg1:RGB):void
        {
            this._red = _arg1.r;
            this._green = _arg1.g;
            this._blue = _arg1.b;
            this.ToHLS();
        }

        public function lightenBy(_arg1:Number):void
        {
            this._luminance = (this._luminance * (1 + _arg1));
            if (this._luminance > 1)
            {
                this._luminance = 1;
            };
            this.ToRGB();
        }

        public function darkenBy(_arg1:Number):void
        {
            this._luminance = (this._luminance * _arg1);
            this.ToRGB();
        }

        private function ToHLS():void
        {
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            var _local1:Number = Math.min(this._red, Math.min(this._green, this._blue));
            var _local2:Number = Math.max(this._red, Math.max(this._green, this._blue));
            var _local3:Number = (_local2 - _local1);
            var _local4:Number = (_local2 + _local1);
            this._luminance = (_local4 / 510);
            if (_local2 == _local1)
            {
                this._saturation = 0;
                this._hue = 0;
            }
            else
            {
                _local5 = ((_local2 - this._red) / _local3);
                _local6 = ((_local2 - this._green) / _local3);
                _local7 = ((_local2 - this._blue) / _local3);
                this._saturation = ((this._luminance <= 0.5) ? (_local3 / _local4) : (_local3 / (510 - _local4)));
                if (this._red == _local2)
                {
                    this._hue = (60 * ((6 + _local7) - _local6));
                }
                else
                {
                    if (this._green == _local2)
                    {
                        this._hue = (60 * ((2 + _local5) - _local7));
                    }
                    else
                    {
                        if (this._blue == _local2)
                        {
                            this._hue = (60 * ((4 + _local6) - _local5));
                        };
                    };
                };
                this._hue = (this._hue % 360);
            };
        }

        private function ToRGB():void
        {
            var _local1:Number;
            var _local2:Number;
            if (this._saturation == 0)
            {
                this._red = (this._green = (this._blue = (this._luminance * 0xFF)));
            }
            else
            {
                if (this._luminance <= 0.5)
                {
                    _local2 = (this._luminance + (this._luminance * this._saturation));
                }
                else
                {
                    _local2 = ((this._luminance + this._saturation) - (this._luminance * this._saturation));
                };
                _local1 = ((2 * this._luminance) - _local2);
                this._red = this.ToRGB1(_local1, _local2, (this._hue + 120));
                this._green = this.ToRGB1(_local1, _local2, this._hue);
                this._blue = this.ToRGB1(_local1, _local2, (this._hue - 120));
            };
        }

        private function ToRGB1(_arg1:Number, _arg2:Number, _arg3:Number):Number
        {
            if (_arg3 > 360)
            {
                _arg3 = (_arg3 - 360);
            }
            else
            {
                if (_arg3 < 0)
                {
                    _arg3 = (_arg3 + 360);
                };
            };
            if (_arg3 < 60)
            {
                _arg1 = (_arg1 + (((_arg2 - _arg1) * _arg3) / 60));
            }
            else
            {
                if (_arg3 < 180)
                {
                    _arg1 = _arg2;
                }
                else
                {
                    if (_arg3 < 240)
                    {
                        _arg1 = (_arg1 + (((_arg2 - _arg1) * (240 - _arg3)) / 60));
                    };
                };
            };
            return (_arg1 * 0xFF);
        }

        public function toString():String
        {
            return (((((((((((("[R:" + this.red) + ", G:") + this.green) + ", B:") + this.blue) + ", H:") + this.hue) + ", S:") + this.saturation) + ", L:") + this.luminance) + "]");
        }


    }
}//package org.sepy.ColorPicker

