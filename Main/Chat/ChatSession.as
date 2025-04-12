// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Chat.ChatSession

package Main.Chat
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import flash.display.Sprite;
    import __AS3__.vec.*;
    import flash.events.*;
    import Main.Controller.*;

    public class ChatSession extends MovieClip 
    {

        public const arrayTabs:Vector.<Object> = new <Object>[{
            "id":1,
            "label":"All",
            "name":"all",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":null,
            "label":"Server",
            "name":"server",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":2,
            "label":"Area",
            "name":"area",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":3,
            "label":"World",
            "name":"world",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":4,
            "label":"Party",
            "name":"party",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":5,
            "label":"Guild",
            "name":"guild",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":6,
            "label":"Trade",
            "name":"trade",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }, {
            "id":7,
            "label":"Cross Server",
            "name":"crosschat",
            "icon":"",
            "type":"channel",
            "isChannel":true,
            "unread":0
        }];

        public var history:Object = {};


        public function show():void
        {
            var chatPanel:ChatPanel = ChatPanel(UIController.getByNameOrShow("chat_panel"));
            chatPanel.buildMenu();
            chatPanel.buildChat();
            chatPanel.resetTab();
            Game.root.world.chatFocus = chatPanel.txtChat;
        }

        public function hide():void
        {
            Game.root.world.chatFocus = null;
            UIController.close("chat_panel");
        }

        public function panel():ChatPanel
        {
            return (ChatPanel(UIController.getByName("chat_panel")));
        }

        public function shown():Boolean
        {
            return (!(this.panel() == null));
        }

        public function addChatHistory(chat:Object):void
        {
            var chatPanelMC:ChatPanel = this.panel();
            if (!this.history[chat.channel])
            {
                this.history[chat.channel] = new Vector.<Object>();
            };
            if (this.history[chat.channel].length > 30)
            {
                this.history[chat.channel].shift();
            };
            var chatData:Object = {
                "user":{
                    "username":chat.username,
                    "guild":"Test"
                },
                "message":chat.message,
                "channel":chat.channel,
                "time":chat.time,
                "target":chat.target
            };
            this.history[chat.channel].push(chatData);
            if (chatPanelMC)
            {
                if (chatPanelMC.addChat(chatData))
                {
                    chatPanelMC.configureChatScroll();
                };
            };
        }

        public function addTab(tab:Object):void
        {
            var mcTab:ChatTab;
            var tabMC:Sprite = this.getTab(tab.name);
            var chatPanelMC:ChatPanel = this.panel();
            if (((!(tabMC)) && (chatPanelMC)))
            {
                mcTab = ChatTab(chatPanelMC.listTabs.addChild(new ChatTab()));
                mcTab.addEventListener(MouseEvent.CLICK, chatPanelMC.onClick);
                mcTab.mcNotification.mouseEnabled = false;
                mcTab.txtChat.text = tab.label;
                mcTab.txtChat.mouseEnabled = false;
                mcTab.name = "btnTab";
                mcTab.tab = tab.name;
                mcTab.id = tab.id;
                mcTab.isChannel = tab.isChannel;
                mcTab.type = tab.type;
                mcTab.y = ((chatPanelMC.listTabs.numChildren - 1) * (mcTab.height + 5));
                this.updateTab(mcTab, tab.unread);
            };
            if (this.arrayTabs.indexOf(tab) === -1)
            {
                this.arrayTabs.push(tab);
            };
        }

        public function deleteTab(name:String):void
        {
            var tab:Object;
            var mcTab:ChatTab;
            var tabMC:ChatTab = this.getTab(name);
            var chatPanelMC:ChatPanel = this.panel();
            var i:int;
            while (i < this.arrayTabs.length)
            {
                tab = this.arrayTabs[i];
                if (tab.name == name)
                {
                    this.history[name] = null;
                    this.arrayTabs.splice(i, 1);
                    break;
                };
                i++;
            };
            if (((tabMC) && (chatPanelMC)))
            {
                mcTab = ChatTab(tabMC);
                if (mcTab.parent)
                {
                    mcTab.parent.removeChild(mcTab);
                };
                chatPanelMC.updateTabPositions();
                chatPanelMC.configureTabScroll(true);
            };
        }

        public function getTab(channel:String):ChatTab
        {
            var chatTab:ChatTab;
            var i:int;
            var chatPanelMC:ChatPanel = this.panel();
            if (chatPanelMC)
            {
                i = 0;
                while (i < chatPanelMC.listTabs.numChildren)
                {
                    chatTab = ChatTab(chatPanelMC.listTabs.getChildAt(i));
                    if (((chatTab) && (chatTab.tab == channel)))
                    {
                        return (chatTab);
                    };
                    i++;
                };
            };
            return (null);
        }

        public function updateTab(menu:ChatTab, count:int):void
        {
            var tab:Object;
            menu.mcNotification.txtCount.text = ((count >= 100) ? "99+" : count);
            menu.mcNotification.visible = (!(count == 0));
            for each (tab in this.arrayTabs)
            {
                if (tab.name == menu.tab)
                {
                    tab.unread = count;
                    break;
                };
            };
        }


    }
}//package Main.Chat

