// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.SoundMC

package FoM
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.media.*;

    public dynamic class SoundMC extends MovieClip 
    {

        public var chkBtn:SimpleButton;
        public var checkmark:MovieClip;
        public var game:Game = Game.root;

        public function SoundMC()
        {
            addFrameScript(0, this.frame1);
        }

        private function frame1():void
        {
            this.checkmark.mouseEnabled = false;
            this.chkBtn.addEventListener(MouseEvent.CLICK, this.onClick, false, 1, true);
            this.chkBtn.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this.chkBtn.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
        }

        public function onClick(_arg1:MouseEvent):void
        {
            SoundMixer.stopAll();
            this.game.toggleAudioSetting("audioSettingsOverall", "audioSettingsOverallBackup", this.game.audioSettingsOverallCheck);
            if (this.game.userPreference.data["audioSettingsOverall"])
            {
                if ((this.game.currentLabel == "Login"))
                {
                    this.game.playBGM();
                }
                else
                {
                    this.game.world.loadMusic();
                };
                this.checkmark.visible = true;
            }
            else
            {
                this.checkmark.visible = false;
            };
        }

        public function onMouseOut(_arg1:MouseEvent):void
        {
            if (!this.game.isGameLabel)
            {
                return;
            };
            this.game.ui.ToolTip.close();
        }

        public function onMouseOver(_arg1:MouseEvent):void
        {
            if (!this.game.isGameLabel)
            {
                return;
            };
            var toolTip:ToolTipMC = this.game.ui.ToolTip;
            if (this.game.userPreference.data["audioSettingsOverall"])
            {
                toolTip.openWith({"str":"Sound Off"});
            }
            else
            {
                toolTip.openWith({"str":"Sound On"});
            };
        }


    }
}//package FoM

