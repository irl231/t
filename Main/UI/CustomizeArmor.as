// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.CustomizeArmor

package Main.UI
{
    import flash.display.MovieClip;
    import org.sepy.ColorPicker.ColorPicker2;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import fl.motion.Color;
    import flash.display.BitmapData;
    import flash.display.*;
    import flash.events.*;
    import fl.motion.*;

    public dynamic class CustomizeArmor extends MovieClip 
    {

        public var cpTrim:ColorPicker2;
        public var cpAccessory:ColorPicker2;
        public var cpBase:ColorPicker2;
        public var cpTrimPicker:SimpleButton;
        public var cpAccessoryPicker:SimpleButton;
        public var cpBasePicker:SimpleButton;
        public var submit:SimpleButton;
        public var btnClose:SimpleButton;
        public var bg:MovieClip;
        private var avatar:Avatar;
        private var backData:Object;

        public function CustomizeArmor()
        {
            addFrameScript(0, this.frame1, 19, this.frame20, 35, this.frame36);
            setPropertiesForColorPicker(this.cpAccessory);
            setPropertiesForColorPicker(this.cpTrim);
            setPropertiesForColorPicker(this.cpBase);
        }

        private static function setPropertiesForColorPicker(colorPicker:ColorPicker2):void
        {
            colorPicker.allowUserColor = true;
            colorPicker.selectedColor = 0;
            colorPicker.columns = 21;
            colorPicker.direction = "DL";
            colorPicker.useAdvancedColorSelector = true;
            colorPicker.useNoColorSelector = false;
        }


        private function onCloseClick(event:Event):void
        {
            if ((((!(this.backData.intColorBase == this.avatar.objData.intColorBase)) || (!(this.backData.intColorTrim == this.avatar.objData.intColorTrim))) || (!(this.backData.intColorAccessory == this.avatar.objData.intColorAccessory))))
            {
                this.avatar.objData.intColorBase = this.backData.intColorBase;
                this.avatar.objData.intColorTrim = this.backData.intColorTrim;
                this.avatar.objData.intColorAccessory = this.backData.intColorAccessory;
                AvatarMC(this.avatar.pMC).updateColor();
            };
            this.btnClose.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
            this.submit.removeEventListener(MouseEvent.CLICK, this.onSaveClick);
            this.cpBase.removeEventListener("CHANGE", this.onColorSelect);
            this.cpBase.removeEventListener("ROLL_OVER", this.onItemRollOver);
            this.cpBase.removeEventListener("ROLL_OUT", this.onItemRollOut);
            this.cpTrim.removeEventListener("CHANGE", this.onColorSelect);
            this.cpTrim.removeEventListener("ROLL_OVER", this.onItemRollOver);
            this.cpTrim.removeEventListener("ROLL_OUT", this.onItemRollOut);
            this.cpAccessory.removeEventListener("CHANGE", this.onColorSelect);
            this.cpAccessory.removeEventListener("ROLL_OVER", this.onItemRollOver);
            this.cpAccessory.removeEventListener("ROLL_OUT", this.onItemRollOut);
            this.cpTrimPicker.removeEventListener(MouseEvent.CLICK, this.onColorPickerTrim);
            this.cpAccessoryPicker.removeEventListener(MouseEvent.CLICK, this.onColorPickerAccessory);
            this.cpBasePicker.removeEventListener(MouseEvent.CLICK, this.onColorPickerBase);
            stage.removeEventListener(MouseEvent.CLICK, this.onClickColorTrim);
            stage.removeEventListener(MouseEvent.CLICK, this.onClickColorAccessory);
            stage.removeEventListener(MouseEvent.CLICK, this.onClickColorBase);
            gotoAndPlay("out");
        }

        private function onSaveClick(event:Event):void
        {
            if ((((!(this.backData.intColorBase == this.avatar.objData.intColorBase)) || (!(this.backData.intColorTrim == this.avatar.objData.intColorTrim))) || (!(this.backData.intColorAccessory == this.avatar.objData.intColorAccessory))))
            {
                Game.root.world.sendChangeArmorColorRequest(this.avatar.objData.intColorBase, this.avatar.objData.intColorTrim, this.avatar.objData.intColorAccessory);
            };
            gotoAndPlay("out");
        }

        private function onColorSelect(event:Event):void
        {
            switch (event.target.name)
            {
                case "cpBase":
                    this.avatar.objData.intColorBase = event.target.selectedColor;
                    break;
                case "cpTrim":
                    this.avatar.objData.intColorTrim = event.target.selectedColor;
                    break;
                case "cpAccessory":
                    this.avatar.objData.intColorAccessory = event.target.selectedColor;
                    break;
            };
            AvatarMC(this.avatar.pMC).updateColor();
        }

        private function onItemRollOver(event:Event):void
        {
            var tempData:Object = {
                "intColorSkin":this.avatar.objData.intColorSkin,
                "intColorHair":this.avatar.objData.intColorHair,
                "intColorEye":this.avatar.objData.intColorEye,
                "intColorBase":this.avatar.objData.intColorBase,
                "intColorTrim":this.avatar.objData.intColorTrim,
                "intColorAccessory":this.avatar.objData.intColorAccessory
            };
            switch (event.target.name)
            {
                case "cpBase":
                    tempData.intColorBase = event.target.selectedColor;
                    break;
                case "cpTrim":
                    tempData.intColorTrim = event.target.selectedColor;
                    break;
                case "cpAccessory":
                    tempData.intColorAccessory = event.target.selectedColor;
                    break;
            };
            AvatarMC(this.avatar.pMC).updateColor(tempData);
        }

        private function onItemRollOut(event:Event):void
        {
            AvatarMC(this.avatar.pMC).updateColor();
        }

        private function onColorPickerTrim(event:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorTrim);
        }

        private function onColorPickerAccessory(event:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorAccessory);
        }

        private function onColorPickerBase(event:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorBase);
        }

        private function onClickColorTrim(event:MouseEvent):void
        {
            var picker:uint = this.colorPicker();
            var color:Color = new Color();
            color.setTint(picker, 1);
            this.cpTrim.cpicker.face.transform.colorTransform = color;
            this.avatar.objData.intColorTrim = picker;
            AvatarMC(this.avatar.pMC).updateColor();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorTrim);
        }

        private function onClickColorAccessory(event:MouseEvent):void
        {
            var picker:uint = this.colorPicker();
            var color:Color = new Color();
            color.setTint(picker, 1);
            this.cpAccessory.cpicker.face.transform.colorTransform = color;
            this.avatar.objData.intColorAccessory = picker;
            AvatarMC(this.avatar.pMC).updateColor();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorAccessory);
        }

        private function onClickColorBase(event:MouseEvent):void
        {
            var picker:uint = this.colorPicker();
            var color:Color = new Color();
            color.setTint(picker, 1);
            this.cpBase.cpicker.face.transform.colorTransform = color;
            this.avatar.objData.intColorBase = picker;
            AvatarMC(this.avatar.pMC).updateColor();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorBase);
        }

        private function colorPicker():uint
        {
            var _stageBitmap:BitmapData = new BitmapData(stage.width, stage.height);
            _stageBitmap.draw(stage);
            return (_stageBitmap.getPixel(stage.mouseX, stage.mouseY));
        }

        private function frame1():void
        {
            this.avatar = Game.root.world.myAvatar;
            this.backData = {
                "intColorBase":this.avatar.objData.intColorBase,
                "intColorTrim":this.avatar.objData.intColorTrim,
                "intColorAccessory":this.avatar.objData.intColorAccessory
            };
            this.cpBase.selectedColor = this.avatar.objData.intColorBase;
            this.cpTrim.selectedColor = this.avatar.objData.intColorTrim;
            this.cpAccessory.selectedColor = this.avatar.objData.intColorAccessory;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.submit.addEventListener(MouseEvent.CLICK, this.onSaveClick, false, 0, true);
            this.cpBase.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpBase.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpBase.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpTrim.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpTrim.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpTrim.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpAccessory.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpAccessory.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpAccessory.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpTrimPicker.addEventListener(MouseEvent.CLICK, this.onColorPickerTrim);
            this.cpAccessoryPicker.addEventListener(MouseEvent.CLICK, this.onColorPickerAccessory);
            this.cpBasePicker.addEventListener(MouseEvent.CLICK, this.onColorPickerBase);
        }

        private function frame20():void
        {
            stop();
        }

        private function frame36():void
        {
            MovieClip(parent).gotoAndPlay("Init");
        }


    }
}//package Main.UI

