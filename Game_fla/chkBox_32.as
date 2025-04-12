// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.chkBox_32

package Game_fla
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;

    public dynamic class chkBox_32 extends MovieClip 
    {

        public var checkmark:MovieClip;
        public var bitChecked:Boolean;

        public function chkBox_32()
        {
            this.checkmark.mouseEnabled = false;
            this.checkmark.visible = this.bitChecked;
            this.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        public function onClick(mouseEvent:MouseEvent):void
        {
            this.bitChecked = (!(this.bitChecked));
            this.checkmark.visible = this.bitChecked;
        }

        public function reCheck(check:Boolean):void
        {
            this.bitChecked = check;
            this.checkmark.visible = this.bitChecked;
        }


    }
}//package Game_fla

