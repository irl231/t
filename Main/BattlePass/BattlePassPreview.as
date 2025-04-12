// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.BattlePass.BattlePassPreview

package Main.BattlePass
{
    import flash.display.MovieClip;
    import Main.UI.Preview;
    import flash.display.SimpleButton;
    import flash.events.*;
    import Main.UI.*;

    public class BattlePassPreview extends MovieClip 
    {

        public const preview:Preview = new Preview(BattlePassPreview);

        public var mcPreview:MovieClip;
        public var btnGender:SimpleButton;

        public function BattlePassPreview()
        {
            this.preview.LOAD_KEY = "battle_pass_preview_junk";
            this.btnGender.addEventListener(MouseEvent.CLICK, this.preview.onBtnGenderClick, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onGenderTTOver, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onGenderTTOut, false, 0, true);
        }

    }
}//package Main.BattlePass

