// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//ChatBoxMC

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.TextEvent;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import Main.Aqw.LPF.*;
    import flash.net.*;

    public class ChatBoxMC extends MovieClip 
    {

        public var btnClose:SimpleButton;
        public var btnSwitch:SimpleButton;
        public var txtCharacter:TextField;
        public var mcState:Boolean = true;
        public var mcOutline:MovieClip;
        public var mcInterface:MovieClip;
        public var game:Game;
        public var mDown:Boolean = false;
        public var chatIcon:MovieClip;
        public var sAlliance:String = "";
        public var mbY:int;
        public var mhY:int;
        public var btnSend:SimpleButton;

        public function ChatBoxMC(game:Game)
        {
            this.game = game;
            addFrameScript(0, this.frame1);
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


        public function sendMessage(message:String):void
        {
            this.cleanMessage(message);
        }

        public function updateMessage(sender:String, message:String):void
        {
            if (sender.toLowerCase() != this.game.world.myAvatar.objData.strUsername.toLowerCase())
            {
                if (!this.mcState)
                {
                    this.mcOutline.gotoAndStop(2);
                    this.game.mixer.playSound("Bad");
                };
            };
            message = message.replace(Chat.regExpLinking2, "$1");
            message = message.replace(/<\s*A HREF="(.*?)">&lt;(.*?)&gt;<\s*\/A\s*>/ig, "$({item,$2,$1})$");
            message = message.replace(Chat.regExpURL, "$({url,$&})$");
            this.mcInterface.txtMessages.multiline = true;
            this.mcInterface.txtMessages.autoSize = "left";
            this.mcInterface.txtMessages.htmlText = (this.mcInterface.txtMessages.htmlText + (((("<font color='#00FFFF'>" + sender) + ":</font> ") + message) + "\n"));
            buildTextLinks(this.mcInterface.txtMessages);
            if (this.mcInterface.txtMessages.textHeight > this.mcInterface.scr.height)
            {
                this.mcInterface.scr.visible = true;
                this.mcInterface.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
            }
            else
            {
                this.mcInterface.scr.visible = false;
            };
            this.scrollToLastItem();
        }

        public function cleanMessage(message:String):void
        {
            var iDiff:Number;
            var iHrs:Number;
            var iMin:Number;
            this.game.world.afkPostpone();
            message = message.replace(Chat.regExpLinking1, "$1");
            message = message.replace(Chat.regExpLinking2, "$1");
            message = message.replace(Chat.regExpLinking3, '<A HREF="$1">$2</A>');
            if (this.game.chatF.iChat == 0)
            {
                this.game.chatF.pushMsg("warning", "This server only allows canned chat.", "SERVER", "", 0);
                return;
            };
            if (this.game.world.myAvatar.objData.bPermaMute == 1)
            {
                this.game.chatF.pushMsg("warning", "You are mute! Chat privileges have been permanently revoked.", "SERVER", "", 0);
                return;
            };
            if (((!(this.game.world.myAvatar.objData.dMutedTill == null)) && (this.game.world.myAvatar.objData.dMutedTill.getTime() > this.game.date_server.getTime())))
            {
                iDiff = ((this.game.world.myAvatar.objData.dMutedTill.getTime() - this.game.date_server.getTime()) / 1000);
                iHrs = Math.floor((iDiff / 3600));
                iMin = Math.floor(((iDiff - (iHrs * 3600)) / 60));
                this.game.chatF.pushMsg("warning", (((("You are mute! Chat privileges have been revoked for the next " + iHrs) + "h ") + iMin) + "m!"), "SERVER", "", 0);
                return;
            };
            if (this.game.chatF.amIMute())
            {
                this.game.chatF.pushMsg("warning", "You are mute! Chat privileges have been temporarily revoked.", "SERVER", "", 0);
                return;
            };
            if (((message == "") || (message == " ")))
            {
                return;
            };
            if (this.sAlliance == "")
            {
                this.game.network.send("whisper", [message, this.txtCharacter.text]);
            }
            else
            {
                this.game.network.send("alliance", [message, this.sAlliance]);
            };
            this.mcInterface.txtMessage.text = "";
        }

        public function initButtons():void
        {
            this.mcOutline.gotoAndStop(1);
            this.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnSwitch.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcOutline.addEventListener(MouseEvent.MOUSE_DOWN, this.startDrg);
            this.mcOutline.addEventListener(MouseEvent.MOUSE_UP, this.stopDrg);
            this.mcInterface.txtMessages.addEventListener("link", onTextFieldLink);
            this.mcInterface.txtMessage.maxChars = 150;
            this.mcInterface.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
            this.addEventListener(KeyboardEvent.KEY_DOWN, this.sendMessageKey);
        }

        private function frame1():void
        {
            this.initButtons();
            this.chatIcon.mouseEnabled = false;
            this.mcInterface.scr.hit.alpha = 0;
            this.mcInterface.bMask.mouseEnabled = false;
            this.mcInterface.bMask.mouseChildren = false;
            stop();
        }

        public function sendMessageKey(event:KeyboardEvent):void
        {
            if (event.keyCode == 13)
            {
                this.sendMessage(this.mcInterface.txtMessage.htmlText);
            };
        }

        public function onClick(event:MouseEvent):void
        {
            if (((event.currentTarget.name.indexOf("chat_alliance_") >= 0) || (event.currentTarget.name.indexOf("chat_whisper_") >= 0)))
            {
                if (parent.getChildByName(this.name) != null)
                {
                    this.game.world.chatFocus = this.mcInterface.txtMessage;
                };
                return;
            };
            switch (event.currentTarget.name)
            {
                case "btnSend":
                    this.sendMessage(this.mcInterface.txtMessage.htmlText);
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    if (this.game.world.chatFocus == this.mcInterface.txtMessage)
                    {
                        this.game.world.chatFocus = null;
                    };
                    parent.removeChild(this);
                    break;
                case "btnSwitch":
                    if (this.mcState)
                    {
                        this.mcState = false;
                        this.mcInterface.visible = false;
                    }
                    else
                    {
                        this.mcState = true;
                        this.mcInterface.visible = true;
                        this.mcOutline.gotoAndStop(1);
                    };
                    break;
            };
        }

        public function startDrg(event:MouseEvent):void
        {
            this.startDrag();
        }

        public function stopDrg(event:MouseEvent):void
        {
            this.stopDrag();
        }

        private function scrDown(event:MouseEvent):void
        {
            this.mDown = true;
            this.mbY = mouseY;
            this.mhY = MovieClip(event.currentTarget.parent).h.y;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp);
            this.mcInterface.scr.h.addEventListener(Event.ENTER_FRAME, this.hEF);
        }

        private function scrUp(event:MouseEvent):void
        {
            this.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
            this.mcInterface.scr.h.removeEventListener(Event.ENTER_FRAME, this.hEF);
        }

        private function hEF(event:Event):void
        {
            var mouseYDiff:int;
            var maxScrollPosition:Number;
            var scrollHeight:Number;
            var messagesHeight:int;
            var messagesPosition:int;
            if (this.mDown)
            {
                mouseYDiff = (mouseY - this.mbY);
                this.mcInterface.scr.h.y = (this.mhY + mouseYDiff);
                maxScrollPosition = (this.mcInterface.scr.b.height - this.mcInterface.scr.h.height);
                this.mcInterface.scr.h.y = Math.max(0, Math.min(maxScrollPosition, this.mcInterface.scr.h.y));
                scrollHeight = (-(this.mcInterface.scr.h.y) / maxScrollPosition);
                messagesHeight = (this.mcInterface.txtMessages.textHeight - this.mcInterface.scr.b.height);
                messagesPosition = int((scrollHeight * messagesHeight));
                this.mcInterface.txtMessages.y = (messagesPosition + 50);
            };
        }

        private function scrollToLastItem():void
        {
            var maxScrollPosition:Number;
            var scrollHeight:Number;
            var messagesHeight:int;
            maxScrollPosition = (this.mcInterface.scr.b.height - this.mcInterface.scr.h.height);
            this.mcInterface.scr.h.y = maxScrollPosition;
            scrollHeight = (-(this.mcInterface.scr.h.y) / maxScrollPosition);
            messagesHeight = (this.mcInterface.txtMessages.textHeight - this.mcInterface.scr.b.height);
            var messagesPosition:int = int((scrollHeight * messagesHeight));
            this.mcInterface.txtMessages.y = (messagesPosition + 50);
        }


    }
}//package 

