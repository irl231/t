// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Chat.ChatPanel

package Main.Chat
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.events.TextEvent;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import Main.Aqw.LPF.*;
    import flash.net.*;
    import Main.*;
    import flash.ui.*;

    public class ChatPanel extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var txtChat:TextField;
        public var btnClose:SimpleButton;
        public var listChat:MovieClip;
        public var scrollChat:LPFElementScrollBar;
        public var maskChat:MovieClip;
        public var listTabs:MovieClip;
        public var maskTabs:MovieClip;
        public var scrollTabs:LPFElementScrollBar;
        public var chatChannel:String = "all";
        public var chatText:TextField;
        public var btnSend:SimpleButton;
        public var chatSpacing:int = 5;
        public var chatBackgroundPadding:int = 20;
        public var btnDelete:SimpleButton;

        public function ChatPanel()
        {
            this.btnDelete.visible = false;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnDelete.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnSend.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.addEventListener(KeyboardEvent.KEY_DOWN, this.onPress);
        }

        private static function buildTextLinks(chatText:TextField):void
        {
            var chatLog:String;
            var chatLogOpen:String;
            var chatLogClose:String;
            var chatLogOpener:String;
            var chatLogArray:Array;
            var chatLogOption:String;
            var chatLogName:String;
            while (((chatText.htmlText.indexOf(Chat.openTag) > -1) && (chatText.htmlText.indexOf(Chat.closeTag) > -1)))
            {
                chatLog = chatText.htmlText;
                chatLogOpen = chatLog.substr(0, chatLog.indexOf(Chat.openTag));
                chatLogClose = chatLog.substr((chatLog.indexOf(Chat.closeTag) + Chat.closeTag.length));
                chatLogOpener = chatLog.substr((chatLog.indexOf(Chat.openTag) + Chat.openTag.length));
                chatLogArray = chatLogOpener.substr(0, chatLogOpener.indexOf(Chat.closeTag)).split(",");
                chatLogOption = chatLogArray[0];
                chatLogName = chatLogArray[1].split("&amp;").join("&");
                switch (chatLogOption)
                {
                    case "url":
                        chatText.htmlText = ((((((((((chatLogOpen + Chat.fontColorStart) + "FFFF99") + Chat.fontColorEnd) + "<u><a href='event:loadUrl:") + chatLogName) + "'>") + chatLogName) + "</a></u>") + Chat.fontColorClose) + chatLogClose);
                        break;
                    case "item":
                        chatText.htmlText = ((((((((((chatLogOpen + Chat.fontColorStart) + "FFFF99") + Chat.fontColorEnd) + "&lt;<a href='event:") + chatLogArray[2]) + "'>") + chatLogName) + "</a>&gt;") + Chat.fontColorClose) + chatLogClose);
                        break;
                };
            };
        }

        private static function onTextFieldLink(textEvent:TextEvent):void
        {
            var eventArray:Array = textEvent.text.split(":");
            switch (eventArray[0])
            {
                case "loadItem":
                    LPFLayoutChatItemPreview.linkItem(Game.root.world.linkTree[eventArray[1]]);
                    break;
                case "loadUrl":
                    navigateToURL(new URLRequest(textEvent.text.split("loadUrl:")[1]), "_blank");
                    break;
            };
        }


        public function toggleChat():void
        {
            var chatTab:ChatTab;
            if (this.rootClass.stage.focus == this.txtChat)
            {
                chatTab = this.rootClass.chatSession.getTab(this.chatChannel);
                if (((chatTab) && (chatTab.type === "whisper")))
                {
                    this.rootClass.chatF.pmMode = 1;
                    this.rootClass.chatF.chn.cur = this.rootClass.chatF.chn.whisper;
                    this.rootClass.ui.mcInterface.te.text = chatTab.tab;
                    this.rootClass.chatF.formatMsgEntry(chatTab.tab);
                    this.rootClass.chatF.updateMsgEntry();
                };
                this.rootClass.ui.mcInterface.te.htmlText = this.txtChat.htmlText;
                this.rootClass.chatF.chatSend();
                this.txtChat.htmlText = "";
            }
            else
            {
                this.rootClass.stage.focus = this.txtChat;
            };
        }

        private function onPress(event:KeyboardEvent):void
        {
            switch (event.charCode)
            {
                case Keyboard.ENTER:
                    this.toggleChat();
                    break;
                case Keyboard.ESCAPE:
                    this.txtChat.htmlText = "";
                    this.rootClass.stage.focus = null;
                    break;
            };
        }

        public function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    this.rootClass.chatSession.hide();
                    break;
                case "btnSend":
                    this.rootClass.ui.mcInterface.te.htmlText = this.txtChat.htmlText;
                    this.rootClass.chatF.chatSend();
                    this.txtChat.htmlText = "";
                    break;
                case "btnTab":
                    this.changeTab(ChatTab(event.currentTarget));
                    break;
                case "btnDelete":
                    MainController.modal("Would you like to delete this conversation?", this.confirmChatDelete, {}, "red,medium", "dual");
                    break;
            };
        }

        public function confirmChatDelete(event:Object):void
        {
            var mcTab:ChatTab;
            if (event.accept)
            {
                mcTab = this.rootClass.chatSession.getTab("all");
                if (mcTab)
                {
                    this.rootClass.chatSession.deleteTab(this.chatChannel);
                    this.changeTab(mcTab);
                };
            };
        }

        public function updateTabPositions():void
        {
            var mcTab:DisplayObject;
            var i:int;
            while (i < this.listTabs.numChildren)
            {
                mcTab = this.listTabs.getChildAt(i);
                mcTab.y = (i * (mcTab.height + 5));
                i++;
            };
        }

        public function dyeChat(message:String, chat:Object):String
        {
            var channel:String;
            var chatColor:String;
            channel = chat.target;
            var username:String = chat.user.username.toLowerCase();
            var avatarChat:Avatar = ((channel == "npc") ? this.rootClass.world.getNpcAvatarByUserName(username) : this.rootClass.world.getAvatarByUserName(username));
            if (((channel == "whisper") || (channel == "event")))
            {
                return (message);
            };
            var channelColor:String = ((this.rootClass.chatF.chn[channel].col) || ("FFFFFF"));
            var isRainbow:Boolean;
            if (((((!(channel === null)) && (["warning", "server", "game", "event", "wheel"].indexOf(channel) === -1)) && (avatarChat)) && (avatarChat.objData)))
            {
                chatColor = ((avatarChat.objData.strChatColor) || (channelColor));
                switch (chatColor)
                {
                    case "000001":
                    case "1":
                        chatColor = channelColor;
                        break;
                    case "000002":
                    case "2":
                        isRainbow = true;
                        break;
                    default:
                        chatColor = Chat.Hex2Color(chatColor);
                };
            }
            else
            {
                chatColor = channelColor;
            };
            if (username == "server")
            {
                chatColor = channelColor;
            };
            return ((isRainbow) ? Chat.rainbowMessage(message) : ((((Chat.fontColorStart + chatColor) + Chat.fontColorEnd) + message) + Chat.fontColorClose));
        }

        private function loadHead(username:String, display:MovieClip, self:Boolean):void
        {
            var imageLoader:Loader;
            if (username == "server")
            {
                return;
            };
            imageLoader = new Loader();
            var request:URLRequest = new URLRequest(this.rootClass.getPlayerLoadPath(username));
            imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:*):void
            {
                display.mcAvatar.icon.addChild(imageLoader);
                display.mcAvatar.icon.height = 64;
                display.mcAvatar.icon.width = 64;
                display.mcAvatar.icon.x = 0;
                display.mcAvatar.icon.y = 4;
                display.mcAvatar.removeChild(display.mcAvatar.mcDefault);
                if (self)
                {
                    imageLoader.scaleX = -1;
                    imageLoader.x = imageLoader.width;
                };
            });
            imageLoader.load(request);
        }

        public function addChat(chat:Object, playSound:Boolean=true):Boolean
        {
            var mcChat:ChatMessage;
            var channelTag:String;
            var channelColor:String;
            var usernameHtml:String;
            var isMe:Boolean;
            var message:String;
            var previousChat:ChatMessage;
            var removedMessage:ChatMessage;
            var i:int;
            var chatMessage:ChatMessage;
            if (chat.channel == this.chatChannel)
            {
                mcChat = ChatMessage(this.listChat.addChild(new ChatMessage()));
                channelTag = ((this.rootClass.chatF.chn[chat.target].tag != "") ? (("[" + this.rootClass.chatF.chn[chat.target].tag) + "]") : "");
                channelColor = ((this.rootClass.chatF.chn[chat.target]) ? this.rootClass.chatF.chn[chat.target].col : "FFFFFF");
                usernameHtml = ((((((((((Chat.fontColorStart + channelColor) + Chat.fontColorEnd) + channelTag) + Chat.fontColorClose) + " ") + Chat.fontColorStart) + "FFFFFF") + Chat.fontColorEnd) + chat.user.username) + Chat.fontColorClose);
                isMe = (chat.user.username.toLowerCase() == this.rootClass.world.myAvatar.objData.strUsername.toLowerCase());
                message = chat.message;
                if (message.indexOf("loadItem") > 0)
                {
                    message = message.replace(Chat.regExpLinking2, "$1");
                    message = message.replace(/<\s*A HREF="(.*?)">&lt;(.*?)&gt;<\s*\/A\s*>/ig, "$({item,$2,$1})$");
                };
                message = message.replace(Chat.regExpURL, "$({url,$&})$");
                message = this.dyeChat(message, chat);
                mcChat.mouseEnabled = false;
                mcChat.name = "btnChat";
                mcChat.mcMessage.txtMessage.multiline = true;
                mcChat.mcMessage.txtMessage.autoSize = TextFieldAutoSize.LEFT;
                mcChat.mcMessage.txtMessage.htmlText = message;
                mcChat.mcMessage.txtMessage.addEventListener("link", onTextFieldLink);
                mcChat.mcMessage.txtName.htmlText = usernameHtml;
                mcChat.mcMessage.txtTime.text = chat.time;
                buildTextLinks(mcChat.mcMessage.txtMessage);
                mcChat.mcMessage.mcBackground.height = (mcChat.mcMessage.txtMessage.textHeight + this.chatBackgroundPadding);
                mcChat.mcAvatar.mcFeatherRight.visible = false;
                if (isMe)
                {
                    mcChat.mcAvatar.mcFeatherLeft.visible = false;
                    mcChat.mcAvatar.mcFeatherRight.visible = true;
                    mcChat.mcAvatar.x = 225;
                    mcChat.mcMessage.x = 2.85;
                };
                previousChat = ((this.listChat.numChildren > 1) ? (this.listChat.getChildAt((this.listChat.numChildren - 2)) as ChatMessage) : null);
                mcChat.y = ((previousChat) ? ((previousChat.y + previousChat.height) + this.chatSpacing) : 0);
                if (this.listChat.numChildren > 30)
                {
                    removedMessage = (this.listChat.removeChildAt(0) as ChatMessage);
                    i = 0;
                    while (i < this.listChat.numChildren)
                    {
                        chatMessage = (this.listChat.getChildAt(i) as ChatMessage);
                        chatMessage.y = (chatMessage.y - (removedMessage.height + this.chatSpacing));
                        i++;
                    };
                };
                return (true);
            };
            var tab:ChatTab = this.rootClass.chatSession.getTab(chat.channel);
            if ((((tab) && (!(chat.channel == "server"))) && (!(chat.user.username.toLowerCase() == this.rootClass.world.myAvatar.objData.strUsername.toLowerCase()))))
            {
                this.rootClass.mixer.playSound("Good");
                this.rootClass.chatSession.updateTab(tab, (Number(tab.mcNotification.txtCount.text) + 1));
            };
            return (false);
        }

        public function changeTab(menu:ChatTab):void
        {
            if (menu.tab != this.chatChannel)
            {
                switch (menu.type)
                {
                    case "whisper":
                        this.rootClass.chatF.openPMsg(menu.tab);
                        break;
                };
                this.chatChannel = menu.tab;
                if (menu.id)
                {
                    this.rootClass.chatLog.changeChannel(menu.id);
                };
                this.btnDelete.visible = (!(menu.isChannel));
                this.rootClass.chatSession.updateTab(menu, 0);
                this.buildChat();
            };
        }

        public function configureTabScroll(reset:Boolean=false):void
        {
            Game.configureScroll(this.listTabs, this.maskTabs, this.scrollTabs, this.maskTabs.height, reset);
        }

        public function configureChatScroll(reset:Boolean=false):void
        {
            Game.configureScroll(this.listChat, this.maskChat, this.scrollChat, this.maskChat.height, reset, true);
        }

        public function clearChat():void
        {
            while (this.listChat.numChildren > 0)
            {
                this.listChat.removeChildAt(0);
            };
        }

        public function buildChat():void
        {
            var chat:Object;
            this.clearChat();
            var chatCounter:int;
            for each (chat in this.rootClass.chatSession.history[this.chatChannel])
            {
                this.addChat(chat, false);
                chatCounter++;
            };
            this.configureChatScroll(true);
        }

        public function buildMenu():void
        {
            var tab:Object;
            for each (tab in this.rootClass.chatSession.arrayTabs)
            {
                this.rootClass.chatSession.addTab(tab);
            };
            Game.configureScroll(this.listTabs, this.maskTabs, this.scrollTabs, this.maskTabs.height);
        }

        public function resetTab():void
        {
            this.chatChannel = "all";
            this.rootClass.chatSession.updateTab(this.rootClass.chatSession.getTab("all"), 0);
        }


    }
}//package Main.Chat

