// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Login.Login

package Main.Login
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import Game_fla.chkBox_32;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import Main.UI.ServerListItem;
    import flash.events.*;
    import Main.UI.*;
    import Main.Network.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;
    import Game_fla.*;

    public class Login extends MovieClip 
    {

        public static const globalMaxCharacters:uint = 3;

        private const game:Game = Game.root;

        public var mcTitle:MovieClip;
        public var ni:TextField;
        public var pi:TextField;
        public var chkUserName:chkBox_32;
        public var chkMobile:chkBox_32;
        public var btnLogin:SimpleButton;
        public var mcForgotPassword:SimpleButton;
        public var btnLogout:SimpleButton;
        public var btnCreate:SimpleButton;
        public var mcManageAccount:SimpleButton;
        public var WarningCounter:MovieClip;
        public var characterDisplay:Sprite;
        public var display:Sprite;
        private var serverPanel:LoginServer = null;
        public var mcCharacter0:MovieClip;
        public var mcCharacter1:MovieClip;
        public var mcCharacter2:MovieClip;

        public function Login()
        {
            addFrameScript(0, this.login, 1, this.character);
        }

        public static function avatarDestroy():void
        {
            var mcLogin:Login = Game.root.mcLogin;
            var j:uint;
            while (j < globalMaxCharacters)
            {
                mcLogin.getChildByName(("mcCharacter" + j)).avatarDestroy();
                j++;
            };
        }

        private static function onLogoutClick(event:MouseEvent):void
        {
            avatarDestroy();
            Game.root.mcLogin.gotoAndStop("Init");
        }

        private static function onHelpClick(mouseEvent:MouseEvent):void
        {
            navigateToURL(new URLRequest(Game.root.getStaticData("discord")), "_blank");
        }

        private static function onServerClick(mouseEvent:MouseEvent):void
        {
            Game.root.mixer.playSound("ClickBig");
            var serverListItem:ServerListItem = ServerListItem(mouseEvent.currentTarget);
            if (serverListItem.obj.Online == 0)
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
            avatarDestroy();
            Game.root.objServerInfo = serverListItem.obj;
            Game.root.chatF.iChat = serverListItem.obj.Chat;
            Game.root.connectTo(serverListItem.obj.IP, serverListItem.obj.Port);
        }

        private static function onMouseOver(mouseEvent:MouseEvent):void
        {
            var serverListItem:ServerListItem = ServerListItem(mouseEvent.currentTarget);
            if (((serverListItem.obj.Online > 0) && (!(serverListItem.frame.currentLabel == "in"))))
            {
                serverListItem.frame.gotoAndPlay("in");
            };
        }

        private static function onMouseOut(mouseEvent:MouseEvent):void
        {
            var serverListItem:ServerListItem = ServerListItem(mouseEvent.currentTarget);
            if (((serverListItem.obj.Online > 0) && (serverListItem.frame.currentLabel == "in")))
            {
                serverListItem.frame.gotoAndPlay("out");
            };
        }


        private function login():void
        {
            LoadController.singleton.clearLoaderByType("junk");
            LoadController.singleton.clearLoaderByType("map");
            LoadController.singleton.clearLoaderByType("avatar");
            this.btnCreate.addEventListener(MouseEvent.CLICK, this.onCreateClick, false, 0, true);
            Game.root.discord.update("stage");
            Game.root.initLogin();
            stop();
        }

        private function character():void
        {
            LoadController.singleton.clearLoaderByType("junk");
            LoadController.singleton.clearLoaderByType("map");
            LoadController.singleton.clearLoaderByType("avatar");
            Game.root.discord.update("stage");
            this.setupCharacter();
            this.btnLogout.addEventListener(MouseEvent.CLICK, onLogoutClick, false, 0, true);
        }

        private function setupCharacter():void
        {
            var j:uint;
            while (j < globalMaxCharacters)
            {
                this.getChildByName(("mcCharacter" + j)).updateData(User.CHARACTERS[j], j);
                j++;
            };
        }

        public function setupServer():void
        {
            var character:Object;
            var i:int;
            var iTotal:int;
            var iTotalOnline:int;
            var arrServers:Object;
            var server:Object;
            var serverListItem:ServerListItem;
            if (((!(this.serverPanel == null)) && (this.display.contains(this.serverPanel))))
            {
                this.display.removeChild(this.serverPanel);
                this.serverPanel = null;
            };
            this.serverPanel = LoginServer(this.display.addChild(new LoginServer()));
            this.serverPanel.x = 330;
            this.serverPanel.y = 100;
            Game.root.onRemoveChildrens(this.serverPanel.serverDisplay);
            for each (character in User.CHARACTERS)
            {
                if (character.Access >= 40)
                {
                    this.serverPanel.btnHelp.addEventListener(MouseEvent.CLICK, onHelpClick, false, 0, true);
                    break;
                };
            };
            this.serverPanel.btnClose.addEventListener(MouseEvent.CLICK, this.onCloseClick, false, 0, true);
            i = 0;
            iTotal = 0;
            iTotalOnline = 0;
            arrServers = User.SERVERS;
            while (i < arrServers.length)
            {
                server = arrServers[i];
                serverListItem = (this.serverPanel.serverDisplay.addChildAt(new ServerListItem(), 0) as ServerListItem);
                serverListItem.ttStr = "";
                serverListItem.x = 0;
                serverListItem.y = ((serverListItem.height + 5) * i);
                serverListItem.obj = server;
                serverListItem.tName.ti.text = server.Name;
                iTotal = (iTotal + int(server.Count));
                serverListItem.iconStandard.visible = false;
                serverListItem.iconStaff.visible = false;
                if (server.Upgrade == 0)
                {
                    serverListItem.ttStr = (serverListItem.ttStr + "This is a free server. ");
                }
                else
                {
                    serverListItem.ttStr = (serverListItem.ttStr + "This is an hero-only server. ");
                    serverListItem.tName.ti.textColor = 16763955;
                };
                if (server.Staff)
                {
                    serverListItem.iconStaff.visible = true;
                    serverListItem.ttStr = (serverListItem.ttStr + " Only Staff.");
                    serverListItem.tName.ti.textColor = 16745727;
                }
                else
                {
                    serverListItem.iconStandard.visible = true;
                };
                serverListItem.mcPop.visible = true;
                serverListItem.iconFull.visible = false;
                if (server.Count < server.Max)
                {
                    serverListItem.mcPop.txtPopulation.text = ((server.Count + "/") + server.Max);
                }
                else
                {
                    serverListItem.mcPop.visible = false;
                    serverListItem.iconFull.visible = true;
                    serverListItem.ttStr = "Server is full.";
                };
                if (server.Online)
                {
                    serverListItem.bgOn.gotoAndStop("Online");
                    serverListItem.iconOffline.visible = false;
                    iTotalOnline++;
                }
                else
                {
                    serverListItem.bgOn.gotoAndStop("Offline");
                    serverListItem.iconOffline.visible = true;
                    serverListItem.iconStandard.visible = false;
                    serverListItem.mcPop.visible = false;
                    serverListItem.tName.alpha = 0.8;
                    serverListItem.ttStr = "Server is temporarily offline.";
                };
                serverListItem.buttonMode = true;
                serverListItem.mouseChildren = false;
                serverListItem.addEventListener(MouseEvent.CLICK, onServerClick, false, 0, true);
                serverListItem.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
                serverListItem.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
                serverListItem.frame.stop();
                i++;
            };
            this.serverPanel.txtCount.text = this.game.strNumWithCommas(iTotal);
        }

        public function onCreateClick(mouseEvent:MouseEvent):void
        {
            Game.root.mcConnDetail.showDisconnect("We are now redirecting you to our registration page.");
            navigateToURL(new URLRequest(Config.serverRegisterURL), "_blank");
        }

        private function onCloseClick(mouseEvent:MouseEvent):void
        {
            this.display.removeChild(this.serverPanel);
        }

        public function onPlayClick(mouseEvent:MouseEvent=null):void
        {
            var j:uint;
            while (j < globalMaxCharacters)
            {
                if (User.CHARACTERS[j].id == User.CHARACTER.id)
                {
                    this.getChildByName(("mcCharacter" + j)).btnPlay.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                };
                j++;
            };
            if (((!(this.serverPanel == null)) && (this.display.contains(this.serverPanel))))
            {
                this.serverPanel.serverDisplay.getChildAt((this.serverPanel.serverDisplay.numChildren - 1)).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
        }


    }
}//package Main.Login

