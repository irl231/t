// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Login.LoginCharacterSelect

package Main.Login
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import Main.UI.ServerListItem;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.*;
    import Main.UI.*;
    import Main.Network.*;
    import Main.Avatar.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;

    public class LoginCharacterSelect extends MovieClip 
    {

        public var txtPlay:TextField;
        public var btnPlay:SimpleButton;
        private var data:Object = null;
        private var sequence:int = 0;
        public var avatarMC:AvatarMC;

        public function LoginCharacterSelect()
        {
            addFrameScript(0, this.frame1);
        }

        public function frame1():void
        {
            this.txtPlay.mouseEnabled = false;
            this.txtPlay.text = "Link";
            stop();
        }

        public function updateData(data:Object, sequence:int):*
        {
            var urlRequest:URLRequest;
            var urlLoader:URLLoader;
            this.data = data;
            this.sequence = sequence;
            if (this.data != null)
            {
                urlRequest = new URLRequest(((Config.serverApiURL + "user/character/data/") + this.data.id));
                urlRequest.method = URLRequestMethod.GET;
                urlLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, this.onAvatarComplete);
                urlLoader.load(urlRequest);
            };
            this.btnPlay.addEventListener(MouseEvent.CLICK, this.onPlayClick, false, 0, true);
        }

        private function onPlayClick(event:MouseEvent):void
        {
            var mcLogin:Login;
            if (this.data == null)
            {
                Game.root.mcLogin.addChild(new LoginCharacterLinkPanel());
                return;
            };
            User.CHARACTER = this.data;
            if (User.SERVERS[1].Online)
            {
                mcLogin = Game.root.mcLogin;
                mcLogin.setupServer();
                return;
            };
            Game.root.mixer.playSound("ClickBig");
            var server:Object = User.SERVERS[0];
            var serverListItem:ServerListItem = new ServerListItem();
            serverListItem.obj = server;
            if (!serverListItem.obj.Online)
            {
                Game.root.MsgBox.notify("Server currently offline!");
                return;
            };
            if (serverListItem.obj.Count >= serverListItem.obj.Max)
            {
                Game.root.MsgBox.notify("Server is Full!");
                return;
            };
            if (((serverListItem.obj.Name.indexOf("(STAFF)") >= 0) && (User.CHARACTER.Access < 40)))
            {
                Game.root.MsgBox.notify("Only the staff can enter the server at the moment.");
                return;
            };
            this.avatarDestroy();
            Game.root.objServerInfo = serverListItem.obj;
            Game.root.chatF.iChat = serverListItem.obj.Chat;
            Game.root.connectTo(serverListItem.obj.IP, serverListItem.obj.Port);
        }

        public function onAvatarComplete(event:Event):void
        {
            var mcLogin:Login = Game.root.mcLogin;
            this.avatarDestroy();
            Game.SCALE = 2.8;
            var characterData:* = JSON.parse(event.target.data);
            if (characterData.eqp.hasOwnProperty("Weapon"))
            {
                delete characterData.eqp["Weapon"];
            };
            if (characterData.eqp.hasOwnProperty("pe"))
            {
                delete characterData.eqp["pe"];
            };
            this.avatarMC = AvatarUtil.createAvatar("login_character", this, characterData);
            this.avatarMC.scale(Game.SCALE);
            this.avatarMC.scaleEntity();
            this.avatarMC.x = 115;
            this.avatarMC.y = 20;
            this.avatarMC.pname.ti.text = this.data.Username;
            this.avatarMC.pname.ti.y = 40;
            if (this.sequence == 1)
            {
                this.avatarMC.mcChar.scaleX = (this.avatarMC.mcChar.scaleX * -1);
                this.avatarMC.mcChar.x = 20;
            };
            setChildIndex(this.avatarMC, 1);
            this.txtPlay.text = "Play";
        }

        public function avatarDestroy():void
        {
            if (((!(this.avatarMC == null)) && (this.contains(this.avatarMC))))
            {
                this.removeChild(this.avatarMC);
                LoadController.singleton.clearLoaderByType("avatar");
            };
        }


    }
}//package Main.Login

