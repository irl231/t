// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MCRedeem

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import Main.*;

    public class MCRedeem extends MovieClip 
    {

        public var btnRedeem:SimpleButton;
        public var btnRedeemMore:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtCode:TextField;

        public function MCRedeem()
        {
            addFrameScript(0, this.frame1);
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function frame1():void
        {
            this.btnRedeem.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnRedeemMore.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnRedeem":
                    if (this.txtCode.text == "")
                    {
                        Game.root.MsgBox.notify("Please insert a redeem code!");
                        return;
                    };
                    Game.root.world.redeemCode(this.txtCode.text);
                    this.txtCode.text = "";
                    return;
                case "btnRedeemMore":
                    navigateToURL(new URLRequest(Config.serverDiscordURL), "_blank");
                    return;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    return;
            };
        }


    }
}//package 

