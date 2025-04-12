// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.CustomizeCharacter

package Main.UI
{
    import flash.display.MovieClip;
    import org.sepy.ColorPicker.ColorPicker2;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import fl.motion.Color;
    import flash.display.BitmapData;
    import flash.display.*;
    import flash.events.*;
    import fl.motion.*;

    public dynamic class CustomizeCharacter extends MovieClip 
    {

        public var cpEye:ColorPicker2;
        public var cpHair:ColorPicker2;
        public var cpSkin:ColorPicker2;
        public var cpEyePicker:SimpleButton;
        public var cpHairPicker:SimpleButton;
        public var cpSkinPicker:SimpleButton;
        public var btnLeft:SimpleButton;
        public var btnRight:SimpleButton;
        public var submit:SimpleButton;
        public var btnClose:SimpleButton;
        public var bg:MovieClip;
        public var txtHair:TextField;
        private var avatar:Avatar;
        private var backData:Object;
        private var HairStyle:Array;
        private var intHairStyleIndex:int;

        public function CustomizeCharacter()
        {
            addFrameScript(0, this.frame1, 19, this.frame20, 35, this.frame36);
            setPropertiesForColorPicker(this.cpEye);
            setPropertiesForColorPicker(this.cpSkin);
            setPropertiesForColorPicker(this.cpHair);
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
            if (this.avatar.objData.HairID != this.backData.HairID)
            {
                this.avatar.objData.HairID = this.backData.HairID;
                this.avatar.objData.strHairName = this.backData.strHairName;
                this.avatar.objData.strHairFilename = this.backData.strHairFilename;
                AvatarMC(this.avatar.pMC).loadHair();
            };
            if ((((!(this.backData.intColorSkin == this.avatar.objData.intColorSkin)) || (!(this.backData.intColorHair == this.avatar.objData.intColorHair))) || (!(this.backData.intColorEye == this.avatar.objData.intColorEye))))
            {
                this.avatar.objData.intColorSkin = this.backData.intColorSkin;
                this.avatar.objData.intColorTrim = this.backData.intColorHair;
                this.avatar.objData.intColorAccessory = this.backData.intColorEye;
                AvatarMC(this.avatar.pMC).updateColor();
            };
            this.btnClose.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
            this.submit.removeEventListener(MouseEvent.CLICK, this.onSaveClick);
            this.btnLeft.removeEventListener(MouseEvent.CLICK, this.nextHairStyle);
            this.btnRight.removeEventListener(MouseEvent.CLICK, this.nextHairStyle);
            this.cpSkin.removeEventListener("CHANGE", this.onColorSelect);
            this.cpSkin.removeEventListener("ROLL_OVER", this.onItemRollOver);
            this.cpSkin.removeEventListener("ROLL_OUT", this.onItemRollOut);
            this.cpEye.removeEventListener("CHANGE", this.onColorSelect);
            this.cpEye.removeEventListener("ROLL_OVER", this.onItemRollOver);
            this.cpEye.removeEventListener("ROLL_OUT", this.onItemRollOut);
            this.cpHair.removeEventListener("CHANGE", this.onColorSelect);
            this.cpHair.removeEventListener("ROLL_OVER", this.onItemRollOver);
            this.cpHair.removeEventListener("ROLL_OUT", this.onItemRollOut);
            this.cpSkinPicker.removeEventListener(MouseEvent.CLICK, this.onColorPickerSkin);
            this.cpEyePicker.removeEventListener(MouseEvent.CLICK, this.onColorPickerEye);
            this.cpHairPicker.removeEventListener(MouseEvent.CLICK, this.onColorPickerHair);
            stage.removeEventListener(MouseEvent.CLICK, this.onClickColorSkin);
            stage.removeEventListener(MouseEvent.CLICK, this.onClickColorHair);
            stage.removeEventListener(MouseEvent.CLICK, this.onClickColorEye);
            gotoAndPlay("out");
        }

        private function onSaveClick(event:Event):void
        {
            if (((((!(this.backData.HairID == this.avatar.objData.HairID)) || (!(this.backData.intColorSkin == this.avatar.objData.intColorSkin))) || (!(this.backData.intColorHair == this.avatar.objData.intColorHair))) || (!(this.backData.intColorEye == this.avatar.objData.intColorEye))))
            {
                Game.root.world.sendChangeColorRequest(this.avatar.objData.intColorSkin, this.avatar.objData.intColorHair, this.avatar.objData.intColorEye, this.avatar.objData.HairID);
            };
            gotoAndPlay("out");
        }

        private function nextHairStyle(event:Event):void
        {
            switch (event.currentTarget.name)
            {
                case "btnRight":
                    this.intHairStyleIndex = ((this.intHairStyleIndex + 1) % this.HairStyle.length);
                    break;
                case "btnLeft":
                    this.intHairStyleIndex = (((this.intHairStyleIndex + this.HairStyle.length) - 1) % this.HairStyle.length);
                    break;
            };
            this.avatar.objData.HairID = this.HairStyle[this.intHairStyleIndex].HairID;
            this.avatar.objData.strHairName = this.HairStyle[this.intHairStyleIndex].sName;
            this.avatar.objData.strHairFilename = this.HairStyle[this.intHairStyleIndex].sFile;
            this.txtHair.text = this.avatar.objData.strHairName;
            AvatarMC(this.avatar.pMC).loadHair();
        }

        private function onColorSelect(event:Event):void
        {
            switch (event.target.name)
            {
                case "cpSkin":
                    this.avatar.objData.intColorSkin = event.target.selectedColor;
                    break;
                case "cpEye":
                    this.avatar.objData.intColorEye = event.target.selectedColor;
                    break;
                case "cpHair":
                    this.avatar.objData.intColorHair = event.target.selectedColor;
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
                case "cpSkin":
                    tempData.intColorSkin = event.target.selectedColor;
                    break;
                case "cpEye":
                    tempData.intColorEye = event.target.selectedColor;
                    break;
                case "cpHair":
                    tempData.intColorHair = event.target.selectedColor;
                    break;
            };
            AvatarMC(this.avatar.pMC).updateColor(tempData);
        }

        private function onItemRollOut(event:Event):void
        {
            AvatarMC(this.avatar.pMC).updateColor();
        }

        private function onColorPickerSkin(event:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorSkin);
        }

        private function onColorPickerEye(event:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorEye);
        }

        private function onColorPickerHair(event:MouseEvent):void
        {
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorHair);
        }

        private function onClickColorSkin(event:MouseEvent):void
        {
            var picker:uint = this.colorPicker();
            var color:Color = new Color();
            color.setTint(picker, 1);
            this.cpSkin.cpicker.face.transform.colorTransform = color;
            this.avatar.objData.intColorSkin = picker;
            AvatarMC(this.avatar.pMC).updateColor();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorSkin);
        }

        private function onClickColorHair(event:MouseEvent):void
        {
            var picker:uint = this.colorPicker();
            var color:Color = new Color();
            color.setTint(picker, 1);
            this.cpHair.cpicker.face.transform.colorTransform = color;
            this.avatar.objData.intColorHair = picker;
            AvatarMC(this.avatar.pMC).updateColor();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorHair);
        }

        private function onClickColorEye(event:MouseEvent):void
        {
            var picker:uint = this.colorPicker();
            var color:Color = new Color();
            color.setTint(picker, 1);
            this.cpEye.cpicker.face.transform.colorTransform = color;
            this.avatar.objData.intColorEye = picker;
            AvatarMC(this.avatar.pMC).updateColor();
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.onClickColorEye);
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
                "HairID":this.avatar.objData.HairID,
                "strHairName":this.avatar.objData.strHairName,
                "strHairFilename":this.avatar.objData.strHairFilename,
                "intColorSkin":this.avatar.objData.intColorSkin,
                "intColorHair":this.avatar.objData.intColorHair,
                "intColorEye":this.avatar.objData.intColorEye
            };
            this.cpSkin.selectedColor = this.avatar.objData.intColorSkin;
            this.cpHair.selectedColor = this.avatar.objData.intColorHair;
            this.cpEye.selectedColor = this.avatar.objData.intColorEye;
            this.txtHair.text = this.avatar.objData.strHairName;
            this.intHairStyleIndex = -1;
            this.HairStyle = Game.root.world.hairshopinfo.hair;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.submit.addEventListener(MouseEvent.CLICK, this.onSaveClick, false, 0, true);
            this.btnLeft.addEventListener(MouseEvent.CLICK, this.nextHairStyle, false, 0, true);
            this.btnRight.addEventListener(MouseEvent.CLICK, this.nextHairStyle, false, 0, true);
            this.cpSkin.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpSkin.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpSkin.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpEye.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpEye.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpEye.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpHair.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpHair.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpHair.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpSkinPicker.addEventListener(MouseEvent.CLICK, this.onColorPickerSkin);
            this.cpEyePicker.addEventListener(MouseEvent.CLICK, this.onColorPickerEye);
            this.cpHairPicker.addEventListener(MouseEvent.CLICK, this.onColorPickerHair);
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

