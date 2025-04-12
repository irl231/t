// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Login.LoginCharacterLinkPanel

package Main.Login
{
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.events.IOErrorEvent;
    import flash.events.Event;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.net.*;
    import Main.*;

    public class LoginCharacterLinkPanel extends Sprite 
    {

        public var btnButton:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtUsername:TextField;
        public var txtPassword:TextField;
        public var chkConfirm:MovieClip;

        public function LoginCharacterLinkPanel()
        {
            this.btnButton.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        private static function onLinkError(errorEvent:IOErrorEvent):void
        {
            Game.root.MsgBox.notify(("Unable to load URL: " + errorEvent.toString()));
        }


        public function onLinkComplete(event:Event):void
        {
            var data:Object = JSON.parse(event.target.data);
            if (data.message != "Success")
            {
                Game.root.MsgBox.notify(data.message);
                return;
            };
            this.parent.removeChild(this);
            Game.root.mcLogin.gotoAndStop("Init");
            Game.root.login();
        }

        private function onClick(event:MouseEvent):void
        {
            var variables:URLVariables;
            var request:URLRequest;
            var loader:URLLoader;
            switch (event.currentTarget.name)
            {
                case "btnButton":
                    if (((this.txtUsername.text == "") || (this.txtPassword.text == "")))
                    {
                        Game.root.MsgBox.notify("Please enter a valid account!");
                        break;
                    };
                    if (!this.chkConfirm.bitChecked)
                    {
                        Game.root.MsgBox.notify("Please confirm before linking an account!");
                        break;
                    };
                    variables = new URLVariables();
                    variables.username = this.txtUsername.text;
                    variables.password = this.txtPassword.text;
                    variables._token = Game.root.params.token;
                    request = new URLRequest((Config.serverApiURL + "user/character/connect"));
                    request.data = variables;
                    request.method = URLRequestMethod.POST;
                    loader = new URLLoader();
                    loader.addEventListener(IOErrorEvent.IO_ERROR, onLinkError);
                    loader.addEventListener(Event.COMPLETE, this.onLinkComplete);
                    loader.load(request);
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    this.parent.removeChild(this);
                    break;
            };
        }


    }
}//package Main.Login

