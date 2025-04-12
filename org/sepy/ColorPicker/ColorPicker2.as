// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//org.sepy.ColorPicker.ColorPicker2

package org.sepy.ColorPicker
{
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ColorPicker2 extends MovieClip 
    {

        private static var ADV_PANEL_DEPTH:Number = 5;
        public static var version:String = "2.2";
        public static var DOWN_LEFT:String = "DL";
        public static var DOWN_RIGHT:String = "DR";
        public static var UP_LEFT:String = "UL";
        public static var UP_RIGHT:String = "UR";
        private static var MIN_WIDTH:Number = 130;

        public var cpicker:MovieClip;
        private var _colors:Array;
        private var _opening_color:Number;
        private var _color:Number;
        private var _direction:String;
        private var _columns:Number = 21;
        private var panel:MovieClip;
        private var _baseColors:Array;
        private var selectedColorMC:MovieClip;
        public var _opened:Boolean;
        private var _allowUserColor:Boolean;
        private var keyListener:Object;
        private var advancedColor:MovieClip;
        private var noColor:MovieClip;
        public var advancedColorPanel:MovieClip;
        private var _useAdvColors:Boolean;
        private var _useNoColor:Boolean;
        private var newMC:MovieClip;
        private var newClass:*;
        private var hover:Boolean = false;
        private var hoverColor:uint;
        public var m_fillType:String = "linear";
        public var m_colors:Array;
        public var m_alphas:Array;
        public var m_ratios:Array;
        public var m_matrix:Object;

        public function ColorPicker2()
        {
            this._colors = new Array();
            this.m_colors = [0xFF0000, 0xFFFF00, 0xFF00, 0xFFFF, 0xFF, 0xFF00FF, 0xFF0000];
            this.m_alphas = [100, 100, 100, 100, 100, 100, 100];
            this.m_ratios = [0, 42, 64, 127, 184, 215, 0xFF];
            this.m_matrix = {
                "matrixType":"box",
                "x":0,
                "y":0,
                "w":175,
                "h":187,
                "r":0
            };
            super();
            addFrameScript(0, this.frame1);
            this._color = 0;
            this._allowUserColor = true;
            this._baseColors = [0xFF00FF, 0xFFFF, 0xFFFF00, 0xFF, 0xFF00, 0xFF0000, 0xFFFFFF, 0xCCCCCC, 0x999999, 0x666666, 0x333333, 0];
            this._colors = this.getStandardColors();
            this.initComponent();
        }

        public static function ColorToString(_arg1:Number):String
        {
            var _local2:String = Math.abs(_arg1).toString(16);
            while (_local2.length < 6)
            {
                _local2 = ("0" + _local2);
            };
            return (_local2.toUpperCase());
        }

        public static function StringToColor(_arg1:String):Number
        {
            return (parseInt(_arg1, 16));
        }

        public static function ColorToRGB(_arg1:Number):Object
        {
            var _local2:Object = new Object();
            _local2.red = ((_arg1 >> 16) & 0xFF);
            _local2.green = ((_arg1 >> 8) & 0xFF);
            _local2.blue = (_arg1 & 0xFF);
            return (_local2);
        }


        private function initComponent():void
        {
            this.useHandCursor = false;
            this.cpicker.nocolor_face.visible = false;
            this.cpicker.addEventListener(MouseEvent.CLICK, this.openMC, false, 0, true);
        }

        public function setIsOpened(_arg1:Boolean):void
        {
            if (((_arg1) && (!(this._opened))))
            {
                this._opening_color = this._color;
                this.attachPanel();
                this._opened = true;
            }
            else
            {
                if (this.panel != null)
                {
                    this.removeChild(this.panel);
                    this.panel = null;
                    stage.removeEventListener(MouseEvent.CLICK, this.onClickOutside, false);
                };
                if (this.advancedColorPanel != null)
                {
                    this.removeChild(this.advancedColorPanel);
                    this.advancedColorPanel = null;
                };
                this._opened = false;
            };
        }

        public function getIsOpened():Boolean
        {
            return ((this._opened) || (!(this.advancedColorPanel == null)));
        }

        private function colorMC(_arg1:MovieClip, _arg2:uint):void
        {
            var _local3:* = ColorToRGB(_arg2);
            _arg1.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _local3.red, _local3.green, _local3.blue, 0);
        }

        private function attachPanel():void
        {
            this.panel = new MovieClip();
            this.panel.name = "panel";
            this.newMC = new MovieClip();
            this.newMC.name = "backgrounds";
            this.panel.addChild(this.newMC);
            this.newMC = new MovieClip();
            this.newMC.name = "colors";
            this.panel.colors = this.panel.addChild(this.newMC);
            this.newMC.x = 3;
            this.newMC.y = 26;
            this.newMC.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutColors, false, 0, true);
            this.populateColorPanel();
            var _local1:Number = ((((this.newMC.width < ColorPicker2.MIN_WIDTH) ? ColorPicker2.MIN_WIDTH : this.newMC.width) + 6) + this.newMC.x);
            var _local2:Number = ((this.newMC.height + 6) + this.newMC.y);
            var _local3:MovieClip = (this.panel.getChildByName("backgrounds") as MovieClip);
            _local3.graphics.lineStyle(1, 0xFFFFFF, 100);
            _local3.graphics.beginFill(13947080, 100);
            _local3.graphics.moveTo(0, 0);
            _local3.graphics.lineTo(_local1, 0);
            _local3.graphics.lineStyle(1, 0x808080, 100);
            _local3.graphics.lineTo(_local1, _local2);
            _local3.graphics.lineTo(0, _local2);
            _local3.graphics.lineStyle(1, 0xFFFFFF, 100);
            _local3.graphics.lineTo(0, 0);
            _local3.graphics.endFill();
            _local3.graphics.lineStyle(1, 0, 100);
            _local3.graphics.moveTo((_local1 + 1), 0);
            _local3.graphics.lineTo((_local1 + 1), (_local2 + 1));
            _local3.graphics.lineTo(0, (_local2 + 1));
            this.newMC = (new ColorDisplay() as MovieClip);
            this.newMC.name = "color_display";
            this.panel.addChild(this.newMC);
            this.newMC.color = this.selectedColor;
            this.colorMC(this.newMC, this.selectedColor);
            this.newMC.x = 3;
            this.newMC.y = 3;
            this.newMC.addEventListener(MouseEvent.CLICK, this.onClicks, false, 0, true);
            this.newMC = new ColorInput();
            this.newMC.name = "color_input";
            this.panel.addChildAt(this.newMC, 1);
            this.newMC.color = this.selectedColor;
            this.newMC.x = 48;
            this.newMC.y = 3;
            var _local4:MovieClip = (this.panel.getChildByName("colors") as MovieClip);
            this.newMC = new face_borders();
            this.newMC.name = "face_borders";
            var _local5:ColorTransform = this.newMC.transform.colorTransform;
            _local5.color = 0xFFFFFF;
            this.newMC.transform.colorTransform = _local5;
            _local4.face_borders = _local4.addChild(this.newMC);
            if (this.selectedColorMC == null)
            {
                this.newMC.visible = false;
            }
            else
            {
                this.newMC.x = this.selectedColorMC.x;
                this.newMC.y = this.selectedColorMC.y;
            };
            switch (this.direction)
            {
                case ColorPicker2.DOWN_LEFT:
                    this.panel.x = ((this.cpicker.x - this.panel.width) + this.cpicker.width);
                    this.panel.y = ((this.cpicker.y + this.cpicker.height) + 5);
                    break;
                case ColorPicker2.UP_LEFT:
                    this.panel.x = ((this.cpicker.x - this.panel.width) + this.cpicker.width);
                    this.panel.y = ((this.cpicker.y - this.panel.height) - 5);
                    break;
                case ColorPicker2.UP_RIGHT:
                    this.panel.x = this.cpicker.x;
                    this.panel.y = ((this.cpicker.y - this.panel.height) - 5);
                    break;
                default:
                    this.panel.x = this.cpicker.x;
                    this.panel.y = ((this.cpicker.y + this.cpicker.height) + 5);
            };
            if (this.useNoColorSelector)
            {
                this.noColor = (new NoColorButton() as MovieClip);
                this.noColor.name = "NoColorButton";
                this.panel.addChild(this.noColor);
                this.noColor.x = ((this.panel.width - this.noColor.width) - 7);
                this.noColor.y = 3;
            };
            if (this.useAdvancedColorSelector)
            {
                this.advancedColor = (new AdvancedColorButton() as MovieClip);
                this.advancedColor.name = "advancedColor";
                this.panel.addChild(this.advancedColor);
                this.advancedColor.x = ((this.panel.width - this.advancedColor.width) - 7);
                this.advancedColor.y = 3;
                if (this.useNoColorSelector)
                {
                    this.noColor.x = ((this.advancedColor.x - this.noColor.width) - 4);
                };
            };
            this.addChild(this.panel);
            stage.addEventListener(MouseEvent.CLICK, this.onClickOutside, false, 0, true);
        }

        public function onRollOutColors(_arg1:MouseEvent):void
        {
            if (this.panel != null)
            {
                this.panel.colors.face_borders.visible = false;
            };
            this.updateColors(this.selectedColor, true);
        }

        public function onClickOutside(_arg1:MouseEvent):void
        {
            if (this.advancedColorPanel == null)
            {
                if (!((this.panel.contains(DisplayObject(_arg1.target))) || (this.cpicker.contains(DisplayObject(_arg1.target)))))
                {
                    this.setIsOpened(false);
                };
            };
        }

        private function onClicks(_arg1:MouseEvent):void
        {
            this.click((_arg1.currentTarget as MovieClip));
        }

        private function populateColorPanel():*
        {
            var _local2:Number;
            var _local3:MovieClip;
            var _local8:Object;
            var _local1:Array = this._colors.slice();
            var _local4:Number = 0;
            var _local5:Number = 0;
            var _local6:Number = 0;
            var _local7:MovieClip = (this.panel.getChildByName("colors") as MovieClip);
            while (_local1.length)
            {
                _local2 = Number(_local1.shift());
                _local8 = ColorToRGB(_local2);
                _local3 = (new ColorBox(_local8) as MovieClip);
                _local3.name = ("single_" + _local6);
                _local7.addChild(_local3);
                _local3.addEventListener(MouseEvent.ROLL_OVER, this.over, false, 0, true);
                _local3.addEventListener(MouseEvent.ROLL_OUT, this.out, false, 0, true);
                _local3.addEventListener(MouseEvent.CLICK, this.onClicks, false, 0, true);
                if (_local2 == this.selectedColor)
                {
                    this.selectedColorMC = _local3;
                };
                if ((((_local6 % this._columns) == 0) && (_local6 > 0)))
                {
                    _local5 = (_local5 + _local3.height);
                    _local4 = 0;
                };
                _local3.x = _local4;
                _local3.y = _local5;
                _local4 = (_local4 + _local3.width);
                _local6++;
            };
        }

        public function getStandardColors():Array
        {
            var _local11:*;
            var _local1:Array = new Array();
            var _local2:Number = 0xFFFFFF;
            var _local3:Number = 0x3300;
            var _local4:Number = 0x320100;
            var _local5:Number = 0x9900FF;
            var _local6:Number = 51;
            var _local7:Number = 10026753;
            var _local8:Number = _local2;
            var _local9:Number = _local2;
            var _local10:* = 0;
            while (_local10 < 12)
            {
                _local11 = 0;
                while (_local11 < 21)
                {
                    if (_local11 > 0)
                    {
                        if (_local11 == 18)
                        {
                            _local8 = 0;
                        }
                        else
                        {
                            if (_local11 == 19)
                            {
                                _local8 = this._baseColors[_local10];
                            }
                            else
                            {
                                if (_local11 == 20)
                                {
                                    _local8 = 0;
                                }
                                else
                                {
                                    if ((((_local11 % 6) == 0) && (_local11 > 0)))
                                    {
                                        _local8 = (_local8 - _local4);
                                    }
                                    else
                                    {
                                        _local8 = (_local8 - _local3);
                                    };
                                };
                            };
                        };
                    };
                    _local1.push(_local8);
                    _local11++;
                };
                if (_local10 == 5)
                {
                    _local9 = (_local9 - _local7);
                }
                else
                {
                    _local9 = (_local9 - _local6);
                };
                _local8 = _local9;
                _local10++;
            };
            _local1.reverse();
            return (_local1);
        }

        public function set selectedColor(_arg1:Number):void
        {
            this._color = _arg1;
            this.updateColors(_arg1, true);
            this.updateface();
        }

        public function get selectedColor():Number
        {
            if (this.hover)
            {
                return (this.hoverColor);
            };
            return (this._color);
        }

        public function set direction(_arg1:String):*
        {
            this._direction = _arg1;
        }

        public function get direction():String
        {
            return (this._direction);
        }

        public function set columns(_arg1:Number):void
        {
            this._columns = _arg1;
        }

        public function get columns():Number
        {
            return (this._columns);
        }

        public function set allowUserColor(_arg1:Boolean):*
        {
            this._allowUserColor = _arg1;
        }

        public function get allowUserColor():Boolean
        {
            return (this._allowUserColor);
        }

        public function set colors(_arg1:Array):*
        {
            this._colors = _arg1;
        }

        public function get colors():Array
        {
            return (this._colors);
        }

        public function get useAdvancedColorSelector():Boolean
        {
            return (this._useAdvColors);
        }

        public function set useAdvancedColorSelector(_arg1:Boolean):void
        {
            this._useAdvColors = _arg1;
        }

        public function get useNoColorSelector():Boolean
        {
            return (this._useNoColor);
        }

        public function set useNoColorSelector(_arg1:Boolean):void
        {
            this._useNoColor = _arg1;
        }

        public function setAdvancedColorsMatrix(_arg1:String, _arg2:Array, _arg3:Array, _arg4:Array):void
        {
            this.m_fillType = _arg1;
            this.m_colors = _arg2;
            this.m_alphas = _arg3;
            this.m_ratios = _arg4;
        }

        public function getRGB():String
        {
            return (ColorPicker2.ColorToString(this.selectedColor));
        }

        private function RGBtoColor(_arg1:Object):int
        {
            var _local2:int;
            _local2 = ((_local2 | _arg1.red) << 16);
            _local2 = (_local2 | (_arg1.green << 8));
            _local2 = (_local2 | _arg1.blue);
            return (_local2);
        }

        private function updateColors(_arg1:Number, _arg2:Boolean):*
        {
            var _local4:MovieClip;
            if (_arg1 < 0)
            {
                this.cpicker.nocolor_face.visible = true;
            }
            else
            {
                this.cpicker.nocolor_face.visible = false;
            };
            var _local3:* = ColorToRGB(_arg1);
            if (this.panel != null)
            {
                _local4 = MovieClip(this.panel.getChildByName("color_display"));
                _local4.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _local3.red, _local3.green, _local3.blue, 0);
                if (_arg2)
                {
                    _local4 = MovieClip(this.panel.getChildByName("color_input"));
                    _local4.color = _arg1;
                };
            };
        }

        private function updateface():void
        {
            var _local1:* = ColorToRGB(this.selectedColor);
            this.cpicker.face.transform.colorTransform = new ColorTransform(1, 1, 1, 1, _local1.red, _local1.green, _local1.blue, 0);
        }

        private function over(_arg1:MouseEvent):*
        {
            var _local2:* = (_arg1.currentTarget as MovieClip);
            var _local3:* = _local2.color;
            this.hover = true;
            this.hoverColor = this.RGBtoColor(_local3);
            this.updateColors(this.hoverColor, true);
            _local2 = MovieClip(this.panel.getChildByName("colors")).getChildByName("face_borders");
            _local2.x = MovieClip(_arg1.currentTarget).x;
            _local2.y = MovieClip(_arg1.currentTarget).y;
            _local2.visible = true;
            this.dispatchEvent(new Event("ROLL_OVER"));
        }

        private function out(_arg1:MouseEvent):*
        {
            this.hover = false;
            this.dispatchEvent(new Event("ROLL_OUT"));
        }

        public function click(_arg1:MovieClip):*
        {
            var _local2:*;
            if (_arg1 == this.advancedColor)
            {
                this.setIsOpened(false);
                this.createAdvancedColorPanel(this.selectedColor);
                this.selectedColor = this._opening_color;
            }
            else
            {
                _local2 = _arg1.color;
                this.selectedColor = this.RGBtoColor(_local2);
                try
                {
                    this.setIsOpened(false);
                }
                catch(e)
                {
                };
                this.dispatchEvent(new Event("CHANGE"));
            };
        }

        private function createAdvancedColorPanel(_arg1:Number):void
        {
            this.advancedColorPanel = (new AdvColorPanel(ColorToRGB(_arg1)) as MovieClip);
            this.advancedColorPanel.name = "advancedColorPanel";
            this.addChild(this.advancedColorPanel);
            switch (this.direction)
            {
                case ColorPicker2.DOWN_LEFT:
                    this.advancedColorPanel.x = ((this.cpicker.x - this.advancedColorPanel.width) + this.cpicker.width);
                    this.advancedColorPanel.y = ((this.cpicker.y + this.cpicker.height) + 5);
                    return;
                case ColorPicker2.UP_LEFT:
                    this.panel.x = ((this.cpicker.x + this.cpicker.width) - this.advancedColorPanel.width);
                    this.panel.y = ((this.cpicker.y - this.advancedColorPanel.height) - 5);
                    return;
                case ColorPicker2.UP_RIGHT:
                    this.panel.x = this.cpicker.x;
                    this.panel.y = ((this.cpicker.y - this.advancedColorPanel.height) - 5);
                    return;
                case ColorPicker2.DOWN_RIGHT:
                default:
                    this.advancedColorPanel.x = this.cpicker.x;
                    this.advancedColorPanel.y = ((this.cpicker.y + this.cpicker.height) + 5);
            };
        }

        public function unload(_arg1:MovieClip):*
        {
            this.removeChild(this.advancedColorPanel);
        }

        public function changed(_arg1:String):*
        {
            if (_arg1.charAt(0) == "#")
            {
                _arg1 = _arg1.substr(1);
            };
            this._color = ColorPicker2.StringToColor(_arg1);
            this.updateColors(this._color, false);
        }

        public function openMC(_arg1:MouseEvent):void
        {
            this.setIsOpened((!(this.getIsOpened())));
        }

        internal function frame1():*
        {
            stop();
        }


    }
}//package org.sepy.ColorPicker

