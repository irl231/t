// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Customization.PanelMC

package Main.Customization
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import Main.Model.Item;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Avatar.*;
    import Main.*;

    public class PanelMC extends MovieClip 
    {

        public static const DEFAULT_HUE:int = 180;
        public static const DEFAULT_BRIGHTNESS:int = 100;
        public static const DEFAULT_CONTRAST:int = 100;
        public static const DEFAULT_SATURATION:int = 100;

        public var game:Game = Game.root;
        public var btnClose:SimpleButton;
        public var btnSubmit:SimpleButton;
        public var btnReset:SimpleButton;
        public var item:Item;
        public var preview:MovieClip;
        public var color:Object = {};
        public var avatar:AvatarMC;
        public var mcHue:QtySelectorMC;
        public var mcBrightness:QtySelectorMC;
        public var mcContrast:QtySelectorMC;
        public var mcSaturation:QtySelectorMC;

        public function PanelMC()
        {
            this.addEventListeners();
            this.item = MovieClip(parent).fData.item;
            this.loadPreview();
            this.initializeSliders();
            this.updateAllValues();
        }

        private function addEventListeners():void
        {
            this.btnSubmit.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnReset.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function initializeSliders():void
        {
            this.setSlider(this.mcHue, this.item.iHue, DEFAULT_HUE, 0, 360, "hue");
            this.setSlider(this.mcBrightness, this.item.iBrightness, DEFAULT_BRIGHTNESS, 0, 200, "brightness");
            this.setSlider(this.mcContrast, this.item.iContrast, DEFAULT_CONTRAST, 0, 200, "contrast");
            this.setSlider(this.mcSaturation, this.item.iSaturation, DEFAULT_SATURATION, 0, 200, "saturation");
        }

        private function setSlider(slider:QtySelectorMC, value:int, defaultValue:int, min:int, max:int, field:String):void
        {
            var sliderValue:int = ((value != -1) ? (value + defaultValue) : defaultValue);
            slider.setMovieClip(this, sliderValue, min, max, function ():void
            {
                update(field, int(slider.t1.text));
            });
        }

        public function update(field:String, val:int):void
        {
            this.color[field] = (val - ((field == "hue") ? 180 : 100));
            this.updateColors();
        }

        private function updateColors():void
        {
            this.item.iHue = this.color.hue;
            this.item.iBrightness = this.color.brightness;
            this.item.iContrast = this.color.contrast;
            this.item.iSaturation = this.color.saturation;
            this.avatar.updateColor();
        }

        public function loadPreview():void
        {
            var avatarData:Object = this.game.copyObj(this.game.world.myAvatar.objData);
            avatarData.iUpgDays = 1;
            avatarData.eqp[this.item.sES] = this.item;
            if (((this.item.sES == "ar") && (avatarData.eqp.hasOwnProperty("ar"))))
            {
                delete avatarData.eqp["co"];
            };
            if (((!(this.item.sES == "pe")) && (avatarData.eqp.hasOwnProperty("pe"))))
            {
                delete avatarData.eqp["pe"];
            };
            this.avatar = AvatarUtil.createAvatar("player", this.preview, avatarData);
            this.avatar.x = 260;
            this.avatar.y = 300;
            if (this.item.sES == "pe")
            {
                this.avatar.mcChar.visible = false;
                this.avatar.shadow.visible = false;
            };
        }

        private function colorRequest(event:Object):void
        {
            if (!event.accept)
            {
                return;
            };
            Game.root.network.send("customizeItem", [0, this.item.CharItemID, this.color.hue, this.color.brightness, this.color.contrast, this.color.saturation]);
        }

        private function resetRequest(event:Object):void
        {
            if (!event.accept)
            {
                return;
            };
            Game.root.network.send("customizeItem", [1, this.item.CharItemID, this.color.hue, this.color.brightness, this.color.contrast, this.color.saturation]);
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnSubmit":
                    MainController.modal((("Are you sure you want to purchase this color customization? This action will cost " + Config.getInt("item_customize_cost")) + " coins."), this.colorRequest, {}, "red,medium", "dual", true);
                    break;
                case "btnReset":
                    MainController.modal((("Are you sure you want to reset the color attached to this item? This action will cost " + Config.getInt("item_customize_reset_cost")) + " coins."), this.resetRequest, {}, "red,medium", "dual", true);
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }

        private function updateAllValues():void
        {
            this.update("hue", int(this.mcHue.t1.text));
            this.update("brightness", int(this.mcBrightness.t1.text));
            this.update("contrast", int(this.mcContrast.t1.text));
            this.update("saturation", int(this.mcSaturation.t1.text));
        }


    }
}//package Main.Customization

