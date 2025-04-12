// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MCStaffPanel

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import Plugins.ConfigurableNPC.*;

    public class MCStaffPanel extends MovieClip 
    {

        public var btnClose:SimpleButton;
        public var txtTitle:TextField;
        public var txtTitle2:TextField;
        public var mcShop:MovieClip;
        public var mcQuest:MovieClip;
        public var mcServerMessage:MovieClip;
        public var mcStaffYell:MovieClip;
        public var mcExperience:MovieClip;
        public var mcCoins:MovieClip;
        public var mcClassPoints:MovieClip;
        public var listMenu:MovieClip;
        public var maskMenu:MovieClip;
        public var scrollMenu:LPFElementScrollBar;
        public var listTools:MovieClip;
        public var maskTools:MovieClip;
        public var scrollTools:LPFElementScrollBar;
        public var listDatas:MovieClip;
        public var maskDatas:MovieClip;
        public var scrollDatas:LPFElementScrollBar;
        public var rootClass:Game = Game.root;
        public var arrayMenu:Array = [{
            "Name":"Game Loader",
            "Frame":"Loaders"
        }, {
            "Name":"Your Data",
            "Frame":"Entities"
        }, {
            "Name":"Game Data",
            "Frame":"Datas"
        }, {
            "Name":"Game Tools",
            "Frame":"Tools"
        }];
        public var arrayTools:Array = [{
            "sName":"NPC Builder",
            "sNameColor":"",
            "sSubtitle":"MAP TOOL",
            "sSubtitleColor":"",
            "sAction":"Function",
            "sValue":"toggleMCNPCBuilder"
        }, {
            "sName":"Map Builder",
            "sNameColor":"",
            "sSubtitle":"MAP TOOL",
            "sSubtitleColor":"",
            "sAction":"Function",
            "sValue":"toggleMCMapBuilder"
        }];
        public var arrayClears:Array = [{
            "sName":"All",
            "sNameColor":"",
            "sSubtitle":"/clear all",
            "sSubtitleColor":"00FF00",
            "sAction":"Chat",
            "sValue":"/clear all"
        }, {
            "sName":"Access",
            "sNameColor":"",
            "sSubtitle":"/clear access",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear access"
        }, {
            "sName":"Achievement",
            "sNameColor":"",
            "sSubtitle":"/clear achievement",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear achievement"
        }, {
            "sName":"Badge",
            "sNameColor":"",
            "sSubtitle":"/clear badge",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear badge"
        }, {
            "sName":"Bet",
            "sNameColor":"",
            "sSubtitle":"/clear bet",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear bet"
        }, {
            "sName":"Class",
            "sNameColor":"",
            "sSubtitle":"/clear class",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear class"
        }, {
            "sName":"Command",
            "sNameColor":"",
            "sSubtitle":"/clear command",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear command"
        }, {
            "sName":"Country",
            "sNameColor":"",
            "sSubtitle":"/clear country",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear country"
        }, {
            "sName":"Enhancement",
            "sNameColor":"",
            "sSubtitle":"/clear enhancement",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear enhancement"
        }, {
            "sName":"Faction",
            "sNameColor":"",
            "sSubtitle":"/clear faction",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear faction"
        }, {
            "sName":"Guild",
            "sNameColor":"",
            "sSubtitle":"/clear guild",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear guild"
        }, {
            "sName":"Hair",
            "sNameColor":"",
            "sSubtitle":"/clear hair",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear hair"
        }, {
            "sName":"Handler",
            "sNameColor":"",
            "sSubtitle":"/clear handler",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear handler"
        }, {
            "sName":"Item",
            "sNameColor":"",
            "sSubtitle":"/clear item",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear item"
        }, {
            "sName":"Map",
            "sNameColor":"",
            "sSubtitle":"/clear map",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear map"
        }, {
            "sName":"Monster",
            "sNameColor":"",
            "sSubtitle":"/clear monster",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear monster"
        }, {
            "sName":"Npc",
            "sNameColor":"",
            "sSubtitle":"/clear npc",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear npc"
        }, {
            "sName":"Server",
            "sNameColor":"",
            "sSubtitle":"/clear server",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear server"
        }, {
            "sName":"Setting",
            "sNameColor":"",
            "sSubtitle":"/clear setting",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear setting"
        }, {
            "sName":"Skill",
            "sNameColor":"",
            "sSubtitle":"/clear skill",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear skill"
        }, {
            "sName":"Title",
            "sNameColor":"",
            "sSubtitle":"/clear title",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear title"
        }, {
            "sName":"Type",
            "sNameColor":"",
            "sSubtitle":"/clear type",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear type"
        }, {
            "sName":"War",
            "sNameColor":"",
            "sSubtitle":"/clear war",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear war"
        }, {
            "sName":"Wheel",
            "sNameColor":"",
            "sSubtitle":"/clear wheel",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear wheel"
        }, {
            "sName":"WorldBoss",
            "sNameColor":"",
            "sSubtitle":"/clear worldboss",
            "sSubtitleColor":"",
            "sAction":"Chat",
            "sValue":"/clear worldboss"
        }];

        public function MCStaffPanel()
        {
            addFrameScript(1, this.Loaders, 3, this.Entities, 5, this.Datas, 7, this.Tools);
            this.txtTitle.text = "Menu";
            this.txtTitle2.text = currentLabel;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.buildMenu();
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function Loaders():void
        {
            stop();
            this.mcShop.txtTitle.text = "Load Shop (/shop)";
            this.mcShop.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcQuest.txtTitle.text = "Load Quest (/quest)";
            this.mcQuest.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcServerMessage.txtTitle.text = "Server Message (/iay @)";
            this.mcServerMessage.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcStaffYell.txtTitle.text = "Staff Yell (/iay)";
            this.mcStaffYell.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function Entities():void
        {
            stop();
            this.mcExperience.txtTitle.text = "Add Experience (/addxp)";
            this.mcExperience.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcCoins.txtTitle.text = "Add Coins(/addcoins)";
            this.mcCoins.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
            this.mcClassPoints.txtTitle.text = "Add Class Points (/addcp)";
            this.mcClassPoints.btnSend.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        private function Datas():void
        {
            stop();
            this.buildButtonList(this.listDatas, this.maskDatas, this.scrollDatas, this.arrayClears);
        }

        private function Tools():void
        {
            stop();
            this.buildButtonList(this.listTools, this.maskTools, this.scrollTools, this.arrayTools);
        }

        public function buildMenu():*
        {
            var Menu:Object;
            var mcMenu:*;
            var menuCounter:int;
            for each (Menu in this.arrayMenu)
            {
                mcMenu = this.listMenu.addChild(new MCStaffPanelMenuButton());
                mcMenu.txtTitle.text = Menu.Name;
                mcMenu.txtTitle.mouseEnabled = false;
                mcMenu.addEventListener(MouseEvent.CLICK, this.onClick);
                mcMenu.name = "btnMenu";
                mcMenu.title = Menu.Name;
                mcMenu.frame = Menu.Frame;
                mcMenu.y = ((menuCounter * mcMenu.height) + 5);
                menuCounter++;
            };
            Game.configureScroll(this.listMenu, this.maskMenu, this.scrollMenu, 270);
        }

        public function buildButtonList(mList:MovieClip, mMask:MovieClip, mScroll:MovieClip, aList:Array):*
        {
            var Menu:Object;
            var mcMenu:*;
            var nextX:int;
            var nextY:int = 5;
            var displayCount:int;
            for each (Menu in aList)
            {
                mcMenu = mList.addChild(new CoreButton(Menu.sName, Menu.sNameColor, Menu.sSubtitle, Menu.sSubtitleColor, Menu.sAction, Menu.sValue));
                if ((((displayCount % 3) == 0) && (!(displayCount == 0))))
                {
                    nextY = (nextY + (mcMenu.height + 5));
                    nextX = 0;
                };
                mcMenu.x = nextX;
                mcMenu.y = nextY;
                nextX = (nextX + (mcMenu.width + 40));
                displayCount++;
            };
            Game.configureScroll(mList, mMask, mScroll);
        }

        public function onClick(event:MouseEvent):void
        {
            var parentValue:*;
            var target:* = event.currentTarget;
            switch (target.name)
            {
                case "btnClose":
                    this.rootClass.ui.mcPopup.onClose();
                    return;
                case "btnMenu":
                    gotoAndPlay(target.frame);
                    this.txtTitle2.text = target.title;
                    break;
            };
            var parentTarget:* = event.currentTarget.parent;
            if (parentTarget != null)
            {
                parentValue = ((this[parentTarget.name].hasOwnProperty("txtInput")) ? this[parentTarget.name].txtInput.text : "");
                switch (parentTarget.name)
                {
                    case "mcShop":
                        if (((parentValue == "") || (isNaN(parentValue))))
                        {
                            this.rootClass.MsgBox.notify("Please input a valid shop ID.");
                            return;
                        };
                        this.rootClass.world.sendLoadShopRequest(parentValue);
                        break;
                    case "mcQuest":
                        if (((parentValue == "") || (isNaN(parentValue))))
                        {
                            this.rootClass.MsgBox.notify("Please input a valid quest ID.");
                            return;
                        };
                        this.rootClass.world.showQuests(parentValue, "q");
                        break;
                    case "mcServerMessage":
                        if (parentValue == "")
                        {
                            this.rootClass.MsgBox.notify("Please input a valid server message.");
                            return;
                        };
                        this.rootClass.chatF.submitMsg(("/iay @" + parentValue), this.rootClass.chatF.chn.cur.typ, this.rootClass.chatF.pmNm);
                        break;
                    case "mcStaffYell":
                        if (parentValue == "")
                        {
                            this.rootClass.MsgBox.notify("Please input a valid staff yell.");
                            return;
                        };
                        this.rootClass.chatF.submitMsg(("/iay " + parentValue), this.rootClass.chatF.chn.cur.typ, this.rootClass.chatF.pmNm);
                        break;
                    case "mcExperience":
                        if (((parentValue == "") || (isNaN(parentValue))))
                        {
                            this.rootClass.MsgBox.notify("Please input a valid experience.");
                            return;
                        };
                        this.rootClass.chatF.submitMsg(("/addexp " + parentValue), this.rootClass.chatF.chn.cur.typ, this.rootClass.chatF.pmNm);
                        break;
                    case "mcCoins":
                        if (((parentValue == "") || (isNaN(parentValue))))
                        {
                            this.rootClass.MsgBox.notify("Please input a valid coins.");
                            return;
                        };
                        this.rootClass.chatF.submitMsg(("/addcoins " + parentValue), this.rootClass.chatF.chn.cur.typ, this.rootClass.chatF.pmNm);
                        break;
                    case "mcClassPoints":
                        if (((parentValue == "") || (isNaN(parentValue))))
                        {
                            this.rootClass.MsgBox.notify("Please input a valid class points.");
                            return;
                        };
                        this.rootClass.chatF.submitMsg(("/addcp " + parentValue), this.rootClass.chatF.chn.cur.typ, this.rootClass.chatF.pmNm);
                        break;
                };
            };
        }


    }
}//package 

