// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Cross.CrossPanel

package Main.Cross
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import Main.*;

    public class CrossPanel extends MovieClip 
    {

        private var game:Game = Game.root;
        public var btnClose:SimpleButton;
        public var btnSubmit:SimpleButton;
        public var btnChangePin:SimpleButton;
        public var btnForget:SimpleButton;
        public var txtDescription:TextField;
        public var txtPassword:TextField;
        public var txtPasswordNew:TextField;
        public var txtPasswordConfirm:TextField;

        public function CrossPanel()
        {
            addFrameScript(0, this.login, 1, this.change);
            this.txtDescription.text = ((Config.isCrossServer()) ? "Transport back to your Home Server." : "Transport to the Domination Server.");
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnSubmit.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        public function login():*
        {
            stop();
            this.btnChangePin.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnForget.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        public function change():*
        {
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
                case "btnChangePin":
                    gotoAndStop("Change");
                    break;
                case "btnForget":
                    navigateToURL(new URLRequest("https://www.pornhub.com/view_video.php?viewkey=655c548110531#1"), "_blank");
                    break;
                case "btnSubmit":
                    if (this.game.world.coolDown("crossConnect"))
                    {
                        if (currentLabel == "Login")
                        {
                            if (this.txtPassword.text == "")
                            {
                                this.game.MsgBox.notify("Please enter a PIN.");
                                return;
                            };
                            this.game.network.send(((Config.isCrossServer()) ? "crossLogout" : "crossLogin"), [this.txtPassword.text]);
                            return;
                        };
                        if ((((this.txtPassword.text == "") || (this.txtPasswordNew.text == "")) || (this.txtPasswordConfirm.text == "")))
                        {
                            this.game.MsgBox.notify("Please enter a PIN.");
                            return;
                        };
                        if (this.txtPasswordNew.text != this.txtPasswordConfirm.text)
                        {
                            this.game.MsgBox.notify("Confirm PIN didnt match.");
                            return;
                        };
                        this.game.network.send("crossChangePassword", [this.txtPassword.text, this.txtPasswordNew.text, this.txtPasswordConfirm.text]);
                    };
                    break;
            };
        }


    }
}//package Main.Cross

