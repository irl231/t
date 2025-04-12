// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//fl.controls.ColorPicker

package fl.controls
{
    import fl.core.UIComponent;
    import fl.managers.IFocusManagerComponent;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import fl.core.InvalidationType;
    import fl.managers.IFocusManager;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Point;
    import flash.text.TextFieldType;
    import flash.ui.Keyboard;
    import fl.events.ColorPickerEvent;
    import flash.events.KeyboardEvent;
    import flash.display.Graphics;
    import flash.events.FocusEvent;

    public class ColorPicker extends UIComponent implements IFocusManagerComponent 
    {

        public static var defaultColors:Array;
        private static var defaultStyles:Object = {
            "upSkin":"ColorPicker_upSkin",
            "disabledSkin":"ColorPicker_disabledSkin",
            "overSkin":"ColorPicker_overSkin",
            "downSkin":"ColorPicker_downSkin",
            "colorWell":"ColorPicker_colorWell",
            "swatchSkin":"ColorPicker_swatchSkin",
            "swatchSelectedSkin":"ColorPicker_swatchSelectedSkin",
            "swatchWidth":10,
            "swatchHeight":10,
            "columnCount":18,
            "swatchPadding":1,
            "textFieldSkin":"ColorPicker_textFieldSkin",
            "textFieldWidth":null,
            "textFieldHeight":null,
            "textPadding":3,
            "background":"ColorPicker_backgroundSkin",
            "backgroundPadding":5,
            "textFormat":null,
            "focusRectSkin":null,
            "focusRectPadding":null,
            "embedFonts":false
        };
        protected static const POPUP_BUTTON_STYLES:Object = {
            "disabledSkin":"disabledSkin",
            "downSkin":"downSkin",
            "overSkin":"overSkin",
            "upSkin":"upSkin"
        };
        protected static const SWATCH_STYLES:Object = {
            "disabledSkin":"swatchSkin",
            "downSkin":"swatchSkin",
            "overSkin":"swatchSkin",
            "upSkin":"swatchSkin"
        };

        public var textField:TextField;
        protected var customColors:Array;
        protected var colorHash:Object;
        protected var paletteBG:DisplayObject;
        protected var selectedSwatch:Sprite;
        protected var _selectedColor:uint;
        protected var rollOverColor:int = -1;
        protected var _editable:Boolean = true;
        protected var _showTextField:Boolean = true;
        protected var isOpen:Boolean = false;
        protected var doOpen:Boolean = false;
        protected var swatchButton:BaseButton;
        protected var colorWell:DisplayObject;
        protected var swatchSelectedSkin:DisplayObject;
        protected var palette:Sprite;
        protected var textFieldBG:DisplayObject;
        protected var swatches:Sprite;
        protected var swatchMap:Array;
        protected var currRowIndex:int;
        protected var currColIndex:int;


        public static function getStyleDefinition():Object
        {
            return (defaultStyles);
        }


        public function get selectedColor():uint
        {
            if (this.colorWell == null)
            {
                return (0);
            };
            return (this.colorWell.transform.colorTransform.color);
        }

        public function set selectedColor(_arg_1:uint):void
        {
            if (!_enabled)
            {
                return;
            };
            this._selectedColor = _arg_1;
            this.rollOverColor = -1;
            this.currColIndex = (this.currRowIndex = 0);
            var _local_2:ColorTransform = new ColorTransform();
            _local_2.color = _arg_1;
            this.setColorWellColor(_local_2);
            invalidate(InvalidationType.DATA);
        }

        public function get hexValue():String
        {
            if (this.colorWell == null)
            {
                return (this.colorToString(0));
            };
            return (this.colorToString(this.colorWell.transform.colorTransform.color));
        }

        override public function get enabled():Boolean
        {
            return (super.enabled);
        }

        override public function set enabled(_arg_1:Boolean):void
        {
            super.enabled = _arg_1;
            if (!_arg_1)
            {
                this.close();
            };
            this.swatchButton.enabled = _arg_1;
        }

        public function get editable():Boolean
        {
            return (this._editable);
        }

        public function set editable(_arg_1:Boolean):void
        {
            this._editable = _arg_1;
            invalidate(InvalidationType.STATE);
        }

        public function get showTextField():Boolean
        {
            return (this._showTextField);
        }

        public function set showTextField(_arg_1:Boolean):void
        {
            invalidate(InvalidationType.STYLES);
            this._showTextField = _arg_1;
        }

        public function get colors():Array
        {
            return ((this.customColors != null) ? this.customColors : ColorPicker.defaultColors);
        }

        public function set colors(_arg_1:Array):void
        {
            this.customColors = _arg_1;
            invalidate(InvalidationType.DATA);
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        public function open():void
        {
            if (!_enabled)
            {
                return;
            };
            this.doOpen = true;
            var _local_1:IFocusManager = focusManager;
            if (_local_1)
            {
                _local_1.defaultButtonEnabled = false;
            };
            invalidate(InvalidationType.STATE);
        }

        public function close():void
        {
            if (this.isOpen)
            {
                focusManager.form.removeChild(this.palette);
                this.isOpen = false;
                dispatchEvent(new Event(Event.CLOSE));
            };
            var _local_1:IFocusManager = focusManager;
            if (_local_1)
            {
                _local_1.defaultButtonEnabled = true;
            };
            this.removeStageListener();
            this.cleanUpSelected();
        }

        private function addCloseListener(_arg_1:Event):*
        {
            removeEventListener(Event.ENTER_FRAME, this.addCloseListener);
            if (!this.isOpen)
            {
                return;
            };
            this.addStageListener();
        }

        protected function onStageClick(_arg_1:MouseEvent):void
        {
            if (((!(contains((_arg_1.target as DisplayObject)))) && (!(this.palette.contains((_arg_1.target as DisplayObject))))))
            {
                this.selectedColor = this._selectedColor;
                this.close();
            };
        }

        protected function setStyles():void
        {
            var _local_1:DisplayObject = this.colorWell;
            var _local_2:Object = getStyleValue("colorWell");
            if (_local_2 != null)
            {
                this.colorWell = (getDisplayObjectInstance(_local_2) as DisplayObject);
            };
            addChildAt(this.colorWell, getChildIndex(this.swatchButton));
            copyStylesToChild(this.swatchButton, POPUP_BUTTON_STYLES);
            this.swatchButton.drawNow();
            if ((((!(_local_1 == null)) && (contains(_local_1))) && (!(_local_1 == this.colorWell))))
            {
                removeChild(_local_1);
            };
        }

        protected function cleanUpSelected():void
        {
            if (((this.swatchSelectedSkin) && (this.palette.contains(this.swatchSelectedSkin))))
            {
                this.palette.removeChild(this.swatchSelectedSkin);
            };
        }

        protected function onPopupButtonClick(_arg_1:MouseEvent):void
        {
            if (this.isOpen)
            {
                this.close();
            }
            else
            {
                this.open();
            };
        }

        override protected function draw():void
        {
            if (isInvalid(InvalidationType.STYLES, InvalidationType.DATA))
            {
                this.setStyles();
                this.drawPalette();
                this.setEmbedFonts();
                invalidate(InvalidationType.DATA, false);
                invalidate(InvalidationType.STYLES, false);
            };
            if (isInvalid(InvalidationType.DATA))
            {
                this.drawSwatchHighlight();
                this.setColorDisplay();
            };
            if (isInvalid(InvalidationType.STATE))
            {
                this.setTextEditable();
                if (this.doOpen)
                {
                    this.doOpen = false;
                    this.showPalette();
                };
                this.colorWell.visible = this.enabled;
            };
            if (isInvalid(InvalidationType.SIZE, InvalidationType.STYLES))
            {
                this.swatchButton.setSize(width, height);
                this.swatchButton.drawNow();
                this.colorWell.width = width;
                this.colorWell.height = height;
            };
            super.draw();
        }

        protected function showPalette():void
        {
            if (this.isOpen)
            {
                this.positionPalette();
                return;
            };
            addEventListener(Event.ENTER_FRAME, this.addCloseListener, false, 0, true);
            focusManager.form.addChild(this.palette);
            this.isOpen = true;
            this.positionPalette();
            dispatchEvent(new Event(Event.OPEN));
            stage.focus = this.textField;
            var _local_1:Sprite = this.selectedSwatch;
            if (_local_1 == null)
            {
                _local_1 = this.findSwatch(this._selectedColor);
            };
            this.setSwatchHighlight(_local_1);
        }

        protected function setEmbedFonts():void
        {
            var _local_1:Object = getStyleValue("embedFonts");
            if (_local_1 != null)
            {
                this.textField.embedFonts = _local_1;
            };
        }

        protected function drawSwatchHighlight():void
        {
            this.cleanUpSelected();
            var _local_1:Object = getStyleValue("swatchSelectedSkin");
            var _local_2:Number = (getStyleValue("swatchPadding") as Number);
            if (_local_1 != null)
            {
                this.swatchSelectedSkin = getDisplayObjectInstance(_local_1);
                this.swatchSelectedSkin.x = 0;
                this.swatchSelectedSkin.y = 0;
                this.swatchSelectedSkin.width = ((getStyleValue("swatchWidth") as Number) + 2);
                this.swatchSelectedSkin.height = ((getStyleValue("swatchHeight") as Number) + 2);
            };
        }

        protected function drawPalette():void
        {
            if (this.isOpen)
            {
                focusManager.form.removeChild(this.palette);
            };
            this.palette = new Sprite();
            this.drawTextField();
            this.drawSwatches();
            this.drawBG();
        }

        protected function drawTextField():void
        {
            if (!this.showTextField)
            {
                return;
            };
            var _local_1:Number = (getStyleValue("backgroundPadding") as Number);
            var _local_2:Number = (getStyleValue("textPadding") as Number);
            this.textFieldBG = getDisplayObjectInstance(getStyleValue("textFieldSkin"));
            if (this.textFieldBG != null)
            {
                this.palette.addChild(this.textFieldBG);
                this.textFieldBG.x = (this.textFieldBG.y = _local_1);
            };
            var _local_3:Object = UIComponent.getStyleDefinition();
            var _local_4:TextFormat = ((this.enabled) ? (_local_3.defaultTextFormat as TextFormat) : (_local_3.defaultDisabledTextFormat as TextFormat));
            this.textField.setTextFormat(_local_4);
            var _local_5:TextFormat = (getStyleValue("textFormat") as TextFormat);
            if (_local_5 != null)
            {
                this.textField.setTextFormat(_local_5);
            }
            else
            {
                _local_5 = _local_4;
            };
            this.textField.defaultTextFormat = _local_5;
            this.setEmbedFonts();
            this.textField.restrict = "A-Fa-f0-9#";
            this.textField.maxChars = 6;
            this.palette.addChild(this.textField);
            this.textField.text = " #888888 ";
            this.textField.height = (this.textField.textHeight + 3);
            this.textField.width = (this.textField.textWidth + 3);
            this.textField.text = "";
            this.textField.x = (this.textField.y = (_local_1 + _local_2));
            this.textFieldBG.width = (this.textField.width + (_local_2 * 2));
            this.textFieldBG.height = (this.textField.height + (_local_2 * 2));
            this.setTextEditable();
        }

        protected function drawSwatches():void
        {
            var _local_10:Sprite;
            var _local_1:Number = (getStyleValue("backgroundPadding") as Number);
            var _local_2:Number = ((this.showTextField) ? ((this.textFieldBG.y + this.textFieldBG.height) + _local_1) : _local_1);
            this.swatches = new Sprite();
            this.palette.addChild(this.swatches);
            this.swatches.x = _local_1;
            this.swatches.y = _local_2;
            var _local_3:uint = (getStyleValue("columnCount") as uint);
            var _local_4:uint = (getStyleValue("swatchPadding") as uint);
            var _local_5:Number = (getStyleValue("swatchWidth") as Number);
            var _local_6:Number = (getStyleValue("swatchHeight") as Number);
            this.colorHash = {};
            this.swatchMap = [];
            var _local_7:uint = Math.min(0x0400, this.colors.length);
            var _local_8:int = -1;
            var _local_9:uint;
            while (_local_9 < _local_7)
            {
                _local_10 = this.createSwatch(this.colors[_local_9]);
                _local_10.x = ((_local_5 + _local_4) * (_local_9 % _local_3));
                if (_local_10.x == 0)
                {
                    this.swatchMap.push([_local_10]);
                    _local_8++;
                }
                else
                {
                    this.swatchMap[_local_8].push(_local_10);
                };
                this.colorHash[this.colors[_local_9]] = {
                    "swatch":_local_10,
                    "row":_local_8,
                    "col":(this.swatchMap[_local_8].length - 1)
                };
                _local_10.y = (Math.floor((_local_9 / _local_3)) * (_local_6 + _local_4));
                this.swatches.addChild(_local_10);
                _local_9++;
            };
        }

        protected function drawBG():void
        {
            var _local_1:Object = getStyleValue("background");
            if (_local_1 != null)
            {
                this.paletteBG = (getDisplayObjectInstance(_local_1) as Sprite);
            };
            if (this.paletteBG == null)
            {
                return;
            };
            var _local_2:Number = Number(getStyleValue("backgroundPadding"));
            this.paletteBG.width = (Math.max(((this.showTextField) ? this.textFieldBG.width : 0), this.swatches.width) + (_local_2 * 2));
            this.paletteBG.height = ((this.swatches.y + this.swatches.height) + _local_2);
            this.palette.addChildAt(this.paletteBG, 0);
        }

        protected function positionPalette():void
        {
            var myForm:DisplayObjectContainer;
            var theStageHeight:Number;
            var theStageWidth:Number;
            var p:Point = this.swatchButton.localToGlobal(new Point(0, 0));
            myForm = focusManager.form;
            p = myForm.globalToLocal(p);
            var padding:Number = (getStyleValue("backgroundPadding") as Number);
            try
            {
                theStageHeight = stage.stageHeight;
                theStageWidth = stage.stageWidth;
            }
            catch(se:SecurityError)
            {
                theStageHeight = myForm.height;
                theStageWidth = myForm.width;
            };
            if ((p.x + this.palette.width) > theStageWidth)
            {
                this.palette.x = ((p.x - this.palette.width) << 0);
            }
            else
            {
                this.palette.x = (((p.x + this.swatchButton.width) + padding) << 0);
            };
            this.palette.y = (Math.max(0, Math.min(p.y, (theStageHeight - this.palette.height))) << 0);
        }

        protected function setTextEditable():void
        {
            if (!this.showTextField)
            {
                return;
            };
            this.textField.type = ((this.editable) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
            this.textField.selectable = this.editable;
        }

        override protected function keyUpHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:uint;
            var _local_4:String;
            var _local_5:Sprite;
            if (!this.isOpen)
            {
                return;
            };
            var _local_3:ColorTransform = new ColorTransform();
            if (((this.editable) && (this.showTextField)))
            {
                _local_4 = this.textField.text;
                if (_local_4.indexOf("#") > -1)
                {
                    _local_4 = _local_4.replace(/^\s+|\s+$/g, "");
                    _local_4 = _local_4.replace(/#/g, "");
                };
                _local_2 = parseInt(_local_4, 16);
                _local_5 = this.findSwatch(_local_2);
                this.setSwatchHighlight(_local_5);
                _local_3.color = _local_2;
                this.setColorWellColor(_local_3);
            }
            else
            {
                _local_2 = this.rollOverColor;
                _local_3.color = _local_2;
            };
            if (_arg_1.keyCode != Keyboard.ENTER)
            {
                return;
            };
            dispatchEvent(new ColorPickerEvent(ColorPickerEvent.ENTER, _local_2));
            this._selectedColor = this.rollOverColor;
            this.setColorText(_local_3.color);
            this.rollOverColor = _local_3.color;
            dispatchEvent(new ColorPickerEvent(ColorPickerEvent.CHANGE, this.selectedColor));
            this.close();
        }

        protected function positionTextField():void
        {
            if (!this.showTextField)
            {
                return;
            };
            var _local_1:Number = (getStyleValue("backgroundPadding") as Number);
            var _local_2:Number = (getStyleValue("textPadding") as Number);
            this.textFieldBG.x = (this.paletteBG.x + _local_1);
            this.textFieldBG.y = (this.paletteBG.y + _local_1);
            this.textField.x = (this.textFieldBG.x + _local_2);
            this.textField.y = (this.textFieldBG.y + _local_2);
        }

        protected function setColorDisplay():void
        {
            if (!this.swatchMap.length)
            {
                return;
            };
            var _local_1:ColorTransform = new ColorTransform(0, 0, 0, 1, (this._selectedColor >> 16), ((this._selectedColor >> 8) & 0xFF), (this._selectedColor & 0xFF), 0);
            this.setColorWellColor(_local_1);
            this.setColorText(this._selectedColor);
            var _local_2:Sprite = this.findSwatch(this._selectedColor);
            this.setSwatchHighlight(_local_2);
            if (((this.swatchMap.length) && (this.colorHash[this._selectedColor] == undefined)))
            {
                this.cleanUpSelected();
            };
        }

        protected function setSwatchHighlight(_arg_1:Sprite):void
        {
            if (_arg_1 == null)
            {
                if (this.palette.contains(this.swatchSelectedSkin))
                {
                    this.palette.removeChild(this.swatchSelectedSkin);
                };
                return;
            };
            if (((!(this.palette.contains(this.swatchSelectedSkin))) && (this.colors.length > 0)))
            {
                this.palette.addChild(this.swatchSelectedSkin);
            }
            else
            {
                if (!this.colors.length)
                {
                    return;
                };
            };
            var _local_2:Number = (getStyleValue("swatchPadding") as Number);
            this.palette.setChildIndex(this.swatchSelectedSkin, (this.palette.numChildren - 1));
            this.swatchSelectedSkin.x = ((this.swatches.x + _arg_1.x) - 1);
            this.swatchSelectedSkin.y = ((this.swatches.y + _arg_1.y) - 1);
            var _local_3:* = _arg_1.getChildByName("color").transform.colorTransform.color;
            this.currColIndex = this.colorHash[_local_3].col;
            this.currRowIndex = this.colorHash[_local_3].row;
        }

        protected function findSwatch(_arg_1:uint):Sprite
        {
            if (!this.swatchMap.length)
            {
                return (null);
            };
            var _local_2:Object = this.colorHash[_arg_1];
            if (_local_2 != null)
            {
                return (_local_2.swatch);
            };
            return (null);
        }

        protected function onSwatchClick(_arg_1:MouseEvent):void
        {
            var _local_2:ColorTransform = _arg_1.target.getChildByName("color").transform.colorTransform;
            this._selectedColor = _local_2.color;
            dispatchEvent(new ColorPickerEvent(ColorPickerEvent.CHANGE, this.selectedColor));
            this.close();
        }

        protected function onSwatchOver(_arg_1:MouseEvent):void
        {
            var _local_2:BaseButton = (_arg_1.target.getChildByName("color") as BaseButton);
            var _local_3:ColorTransform = _local_2.transform.colorTransform;
            this.setColorWellColor(_local_3);
            this.setSwatchHighlight((_arg_1.target as Sprite));
            this.setColorText(_local_3.color);
            dispatchEvent(new ColorPickerEvent(ColorPickerEvent.ITEM_ROLL_OVER, _local_3.color));
        }

        protected function onSwatchOut(_arg_1:MouseEvent):void
        {
            var _local_2:ColorTransform = _arg_1.target.transform.colorTransform;
            dispatchEvent(new ColorPickerEvent(ColorPickerEvent.ITEM_ROLL_OUT, _local_2.color));
        }

        protected function setColorText(_arg_1:uint):void
        {
            if (this.textField == null)
            {
                return;
            };
            this.textField.text = ("#" + this.colorToString(_arg_1));
        }

        protected function colorToString(_arg_1:uint):String
        {
            var _local_2:String = _arg_1.toString(16);
            while (_local_2.length < 6)
            {
                _local_2 = ("0" + _local_2);
            };
            return (_local_2);
        }

        protected function setColorWellColor(_arg_1:ColorTransform):void
        {
            if (!this.colorWell)
            {
                return;
            };
            this.colorWell.transform.colorTransform = _arg_1;
        }

        protected function createSwatch(_arg_1:uint):Sprite
        {
            var _local_2:Sprite = new Sprite();
            var _local_3:BaseButton = new BaseButton();
            _local_3.focusEnabled = false;
            var _local_4:Number = (getStyleValue("swatchWidth") as Number);
            var _local_5:Number = (getStyleValue("swatchHeight") as Number);
            _local_3.setSize(_local_4, _local_5);
            _local_3.transform.colorTransform = new ColorTransform(0, 0, 0, 1, (_arg_1 >> 16), ((_arg_1 >> 8) & 0xFF), (_arg_1 & 0xFF), 0);
            copyStylesToChild(_local_3, SWATCH_STYLES);
            _local_3.mouseEnabled = false;
            _local_3.drawNow();
            _local_3.name = "color";
            _local_2.addChild(_local_3);
            var _local_6:Number = (getStyleValue("swatchPadding") as Number);
            var _local_7:Graphics = _local_2.graphics;
            _local_7.beginFill(0);
            _local_7.drawRect(-(_local_6), -(_local_6), (_local_4 + (_local_6 * 2)), (_local_5 + (_local_6 * 2)));
            _local_7.endFill();
            _local_2.addEventListener(MouseEvent.CLICK, this.onSwatchClick, false, 0, true);
            _local_2.addEventListener(MouseEvent.MOUSE_OVER, this.onSwatchOver, false, 0, true);
            _local_2.addEventListener(MouseEvent.MOUSE_OUT, this.onSwatchOut, false, 0, true);
            return (_local_2);
        }

        protected function addStageListener(_arg_1:Event=null):void
        {
            focusManager.form.addEventListener(MouseEvent.MOUSE_DOWN, this.onStageClick, false, 0, true);
        }

        protected function removeStageListener(_arg_1:Event=null):void
        {
            focusManager.form.removeEventListener(MouseEvent.MOUSE_DOWN, this.onStageClick, false);
        }

        override protected function focusInHandler(_arg_1:FocusEvent):void
        {
            super.focusInHandler(_arg_1);
            setIMEMode(true);
        }

        override protected function focusOutHandler(_arg_1:FocusEvent):void
        {
            if (_arg_1.relatedObject == this.textField)
            {
                setFocus();
                return;
            };
            if (this.isOpen)
            {
                this.close();
            };
            super.focusOutHandler(_arg_1);
            setIMEMode(false);
        }

        override protected function isOurFocus(_arg_1:DisplayObject):Boolean
        {
            return ((_arg_1 == this.textField) || (super.isOurFocus(_arg_1)));
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_3:Sprite;
            switch (_arg_1.keyCode)
            {
                case Keyboard.SHIFT:
                case Keyboard.CONTROL:
                    return;
            };
            if (_arg_1.ctrlKey)
            {
                switch (_arg_1.keyCode)
                {
                    case Keyboard.DOWN:
                        this.open();
                        return;
                    case Keyboard.UP:
                        this.close();
                        return;
                };
                return;
            };
            if (!this.isOpen)
            {
                switch (_arg_1.keyCode)
                {
                    case Keyboard.UP:
                    case Keyboard.DOWN:
                    case Keyboard.LEFT:
                    case Keyboard.RIGHT:
                    case Keyboard.SPACE:
                        this.open();
                        return;
                };
            };
            this.textField.maxChars = (((_arg_1.keyCode == "#".charCodeAt(0)) || (this.textField.text.indexOf("#") > -1)) ? 7 : 6);
            switch (_arg_1.keyCode)
            {
                case Keyboard.TAB:
                    _local_3 = this.findSwatch(this._selectedColor);
                    this.setSwatchHighlight(_local_3);
                    return;
                case Keyboard.HOME:
                    this.currColIndex = (this.currRowIndex = 0);
                    break;
                case Keyboard.END:
                    this.currColIndex = (this.swatchMap[(this.swatchMap.length - 1)].length - 1);
                    this.currRowIndex = (this.swatchMap.length - 1);
                    break;
                case Keyboard.PAGE_DOWN:
                    this.currRowIndex = (this.swatchMap.length - 1);
                    break;
                case Keyboard.PAGE_UP:
                    this.currRowIndex = 0;
                    break;
                case Keyboard.ESCAPE:
                    if (this.isOpen)
                    {
                        this.selectedColor = this._selectedColor;
                    };
                    this.close();
                    return;
                case Keyboard.ENTER:
                    return;
                case Keyboard.UP:
                    this.currRowIndex = Math.max(-1, (this.currRowIndex - 1));
                    if (this.currRowIndex == -1)
                    {
                        this.currRowIndex = (this.swatchMap.length - 1);
                    };
                    break;
                case Keyboard.DOWN:
                    this.currRowIndex = Math.min(this.swatchMap.length, (this.currRowIndex + 1));
                    if (this.currRowIndex == this.swatchMap.length)
                    {
                        this.currRowIndex = 0;
                    };
                    break;
                case Keyboard.RIGHT:
                    this.currColIndex = Math.min(this.swatchMap[this.currRowIndex].length, (this.currColIndex + 1));
                    if (this.currColIndex == this.swatchMap[this.currRowIndex].length)
                    {
                        this.currColIndex = 0;
                        this.currRowIndex = Math.min(this.swatchMap.length, (this.currRowIndex + 1));
                        if (this.currRowIndex == this.swatchMap.length)
                        {
                            this.currRowIndex = 0;
                        };
                    };
                    break;
                case Keyboard.LEFT:
                    this.currColIndex = Math.max(-1, (this.currColIndex - 1));
                    if (this.currColIndex == -1)
                    {
                        this.currColIndex = (this.swatchMap[this.currRowIndex].length - 1);
                        this.currRowIndex = Math.max(-1, (this.currRowIndex - 1));
                        if (this.currRowIndex == -1)
                        {
                            this.currRowIndex = (this.swatchMap.length - 1);
                        };
                    };
                    break;
                default:
                    return;
            };
            var _local_2:ColorTransform = this.swatchMap[this.currRowIndex][this.currColIndex].getChildByName("color").transform.colorTransform;
            this.rollOverColor = _local_2.color;
            this.setColorWellColor(_local_2);
            this.setSwatchHighlight(this.swatchMap[this.currRowIndex][this.currColIndex]);
            this.setColorText(_local_2.color);
        }

        override protected function configUI():void
        {
            var _local_1:uint;
            super.configUI();
            tabChildren = false;
            if (ColorPicker.defaultColors == null)
            {
                ColorPicker.defaultColors = [];
                _local_1 = 0;
                while (_local_1 < 216)
                {
                    ColorPicker.defaultColors.push(((((((((_local_1 / 6) % 3) << 0) + (((_local_1 / 108) << 0) * 3)) * 51) << 16) | (((_local_1 % 6) * 51) << 8)) | ((((_local_1 / 18) << 0) % 6) * 51)));
                    _local_1++;
                };
            };
            this.colorHash = {};
            this.swatchMap = [];
            this.textField = new TextField();
            this.textField.tabEnabled = false;
            this.swatchButton = new BaseButton();
            this.swatchButton.focusEnabled = false;
            this.swatchButton.useHandCursor = false;
            this.swatchButton.autoRepeat = false;
            this.swatchButton.setSize(25, 25);
            this.swatchButton.addEventListener(MouseEvent.CLICK, this.onPopupButtonClick, false, 0, true);
            addChild(this.swatchButton);
            this.palette = new Sprite();
            this.palette.tabChildren = false;
            this.palette.cacheAsBitmap = true;
        }


    }
}//package fl.controls

