// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Login.LoginCharacterButton

package Main.Login
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.Network.*;
    import flash.net.*;
    import Main.*;

    public class LoginCharacterButton extends MovieClip 
    {

        public var txtCharacter:TextField;
        private var data:Object;

        public function LoginCharacterButton(data:Object)
        {
            this.data = data;
            this.txtCharacter.mouseEnabled = false;
            if (this.data == null)
            {
                this.txtCharacter.text = "Link Character";
                this.gotoAndStop("Off");
            }
            else
            {
                this.txtCharacter.text = this.data.Username;
                this.gotoAndStop("On");
            };
            this.addEventListener(MouseEvent.CLICK, this.onCharacterClick, false, 0, true);
        }

        private function onCharacterClick(event:MouseEvent):void
        {
            if (this.data == null)
            {
                Game.root.mcLogin.addChild(new LoginCharacterLinkPanel());
                return;
            };
            Game.root.mcLogin.txtName.text = this.data.Username.toUpperCase();
            User.CHARACTER = this.data;
            Login.avatarDestroy();
            var urlRequest:URLRequest = new URLRequest(((Config.serverApiURL + "user/character/data/") + this.data.id));
            urlRequest.method = URLRequestMethod.GET;
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, Login.onAvatarComplete);
            urlLoader.load(urlRequest);
        }


    }
}//package Main.Login

