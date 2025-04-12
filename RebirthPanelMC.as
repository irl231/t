// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//RebirthPanelMC

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;

    public dynamic class RebirthPanelMC extends MovieClip 
    {

        public var btnRebirth:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtConfirm:TextField;
        public var txtRebirths:TextField;

        public function RebirthPanelMC()
        {
            addFrameScript(0, this.frame1);
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function frame1():void
        {
            this.btnRebirth.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.txtRebirths.text = ("Total Number of Rebirths: " + Game.root.world.myAvatar.objData.intRebirth);
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnRebirth":
                    if (this.txtConfirm.text.toLowerCase() != "confirm")
                    {
                        Game.root.MsgBox.notify("Please write confirm in the input box!");
                        return;
                    };
                    Game.root.network.send("rebirth", []);
                    this.fClose();
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    this.fClose();
                    break;
            };
        }


    }
}//package 

