// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcCustomizeGuild

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import org.sepy.ColorPicker.ColorPicker2;
    import flash.events.Event;
    import flash.events.*;

    public dynamic class mcCustomizeGuild extends MovieClip 
    {

        public var submit:SimpleButton;
        public var btnClose:SimpleButton;
        public var cpGuildName:ColorPicker2;
        public var bg:MovieClip;
        public var rootClass:Game;
        public var avt:Avatar;
        public var backData:*;

        public function mcCustomizeGuild(mainClass:MovieClip)
        {
            this.rootClass = mainClass;
            addFrameScript(0, this.frame1, 19, this.frame20, 35, this.frame36);
            this.__setProp_cpGuildName_GuildCustomization_Layer24_0();
        }

        public function onCloseClick(_arg1:Event):*
        {
            if ((((!(this.backData.intColorGuildName == this.avt.objData.intColorGuildName)) || (!(this.backData.intGuildEmblemBase == this.avt.objData.intGuildEmblemBase))) || (!(this.backData.intGuildEmblemTrim == this.avt.objData.intGuildEmblemTrim))))
            {
                this.avt.pMC.pname.tg.textColor = this.backData.intColorGuildName;
                this.avt.pMC.updateColor();
            };
            gotoAndPlay("out");
        }

        public function onSaveClick(_arg1:Event):*
        {
            _local8 = new ModalMC();
            _local9 = {};
            _local9.strBody = "Are you sure you want to change your guild color? This will charge you 200,000 Gold.";
            _local9.params = {"iSel":"dummy"};
            _local9.callback = this.onChangeRequest;
            _local9.glow = "white,medium";
            this.rootClass.ui.ModalStack.addChild(_local8);
            _local8.init(_local9);
        }

        private function onChangeRequest(_arg_1:Object):void
        {
            if (_arg_1.accept)
            {
                if (this.backData.intColorGuildName != this.avt.pMC.pname.tg.textColor)
                {
                    this.rootClass.world.sendChangeGuildSettingsRequest(this.avt.pMC.pname.tg.textColor);
                };
                gotoAndPlay("out");
            };
        }

        public function onColorSelect(_arg1:Event):void
        {
            switch (_arg1.target.name)
            {
                case "cpGuildName":
                    this.avt.pMC.pname.tg.textColor = _arg1.target.selectedColor;
                    this.avt.objData.intColorGuildName = _arg1.target.selectedColor;
                    break;
            };
        }

        public function onItemRollOver(_arg1:Event):void
        {
            var _local2:* = new Object();
            switch (_arg1.target.name)
            {
                case "cpGuildName":
                    this.avt.pMC.pname.tg.textColor = _arg1.target.selectedColor;
                    this.avt.objData.intColorGuildName = _arg1.target.selectedColor;
                    break;
            };
        }

        public function onItemRollOut(_arg1:Event):void
        {
        }

        internal function __setProp_cpGuildName_GuildCustomization_Layer24_0():*
        {
            try
            {
                this.cpGuildName["componentInspectorSetting"] = true;
            }
            catch(e:Error)
            {
            };
            this.cpGuildName.allowUserColor = true;
            this.cpGuildName.selectedColor = 0;
            this.cpGuildName.columns = 21;
            this.cpGuildName.direction = "DL";
            this.cpGuildName.useAdvancedColorSelector = true;
            this.cpGuildName.useNoColorSelector = false;
            try
            {
                this.cpGuildName["componentInspectorSetting"] = false;
            }
            catch(e:Error)
            {
            };
        }

        internal function frame1():*
        {
            this.avt = this.rootClass.world.myAvatar;
            this.backData = new Object();
            this.backData.intColorGuildName = this.avt.pMC.pname.tg.textColor;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            this.submit.addEventListener(MouseEvent.CLICK, this.onSaveClick, false, 0, true);
            this.cpGuildName.addEventListener("CHANGE", this.onColorSelect, false, 0, true);
            this.cpGuildName.addEventListener("ROLL_OVER", this.onItemRollOver, false, 0, true);
            this.cpGuildName.addEventListener("ROLL_OUT", this.onItemRollOut, false, 0, true);
            this.cpGuildName.selectedColor = this.avt.pMC.pname.tg.textColor;
        }

        internal function frame20():*
        {
            stop();
        }

        internal function frame36():*
        {
            parent.removeChild(this);
        }


    }
}//package Game_fla

