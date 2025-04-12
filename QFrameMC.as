// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//QFrameMC

package 
{
    import flash.display.MovieClip;
    import Game_fla.mcQFrame_1033;
    import flash.events.MouseEvent;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import flash.filters.GlowFilter;
    import flash.events.Event;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import Main.Aqw.LPF.*;
    import Main.Aqw.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;

    public class QFrameMC extends MovieClip 
    {

        public var cnt:mcQFrame_1033;
        public var world:World;
        public var qData:Object = null;
        public var qMode:String = null;
        private var choiceID:int = -1;
        private var isOpen:Boolean = false;
        private var mDown:Boolean = false;
        private var hRun:int = 0;
        private var dRun:int = 0;
        private var mbY:int = 0;
        private var mhY:int = 0;
        private var mbD:int = 0;
        private var count:int = 0;

        public var game:Game = Game.root;
        public var qIDs:Array = [];
        public var sIDs:Array = [];
        public var tIDs:Array = [];
        private var qla:Array = [];
        private var qlb:Array = [];
        private const rewardType:Array = ["itemsS", "itemsC", "itemsR", "itemsROLL", "itemsR_ONE"];

        public function QFrameMC():void
        {
            addFrameScript(6, this.frame7, 11, this.frame12, 15, this.frame16);
            this.cnt.bg.btnClose.addEventListener(MouseEvent.CLICK, this.onClose);
        }

        private static function bMouseOver(mouseEvent:MouseEvent):void
        {
            MovieClip(mouseEvent.currentTarget).fx.visible = true;
        }

        private static function bMouseOut(mouseEvent:MouseEvent):void
        {
            MovieClip(mouseEvent.currentTarget).fx.visible = false;
        }

        private static function onPreviewClick(mouseEvent:MouseEvent):void
        {
            LPFLayoutChatItemPreview.linkItem(mouseEvent.currentTarget.parent.ItemData);
        }


        public function onPin(param1:MouseEvent):void
        {
            var questID:String;
            this.game.pinnedQuests = "";
            if (!param1.shiftKey)
            {
                for each (questID in this.qIDs)
                {
                    this.game.pinnedQuests = (this.game.pinnedQuests + (questID + ","));
                };
            };
        }

        public function open():void
        {
            this.cnt.bg.btnPin.addEventListener(MouseEvent.CLICK, this.onPin, false, 0, true);
            this.cnt.bg.btnWiki.addEventListener(MouseEvent.CLICK, this.onBtnLibraryClick, false, 0, true);
            this.cnt.bg.btnPin.visible = true;
            this.cnt.bg.btnWiki.visible = false;
            if (!this.isOpen)
            {
                this.isOpen = true;
                this.cnt.gotoAndPlay("intro");
                return;
            };
            this.isOpen = false;
            this.onClose();
        }

        public function showQuestList():void
        {
            var i:int;
            var ii:int;
            var empty:Boolean;
            switch (this.qMode)
            {
                case "l":
                    if (this.game.world.getActiveQuests() != "")
                    {
                        this.qIDs = this.game.world.getActiveQuests().split(",");
                        this.cnt.strTitle.htmlText = 'Current Quests<font color="#FF0000">:</font>';
                    }
                    else
                    {
                        empty = true;
                    };
                    break;
                case "q":
                    this.qIDs = [];
                    i = 0;
                    while (i < this.sIDs.length)
                    {
                        this.qIDs.push(this.sIDs[i]);
                        i++;
                    };
                    ii = 0;
                    while (ii < this.tIDs.length)
                    {
                        if (((this.game.world.isQuestInProgress(this.tIDs[ii])) && (this.qIDs.indexOf(this.tIDs[ii]) == -1)))
                        {
                            this.qIDs.push(this.tIDs[ii]);
                        };
                        ii++;
                    };
                    this.cnt.strTitle.htmlText = 'Available Quests<font color="#FF0000">:</font>';
                    break;
            };
            if (empty)
            {
                this.showEmptyList();
            }
            else
            {
                this.game.world.checkAllQuestStatus();
                this.buildQuestList();
            };
            this.cnt.qList.visible = true;
            this.cnt.qList.mHi.visible = false;
            this.cnt.mouseChildren = true;
        }

        public function showQuestDetail():void
        {
            var buttonsType:MovieClip;
            var buttons:Object;
            var keyButton:String;
            var qdy:int;
            var showReq:String;
            var count:int;
            var item1:Object;
            var itemTurnQuantity:int;
            var battlePass:Object;
            var rewardMC:MovieClip;
            var ii:int;
            var rewardTypeElement:String;
            var rewards:Object;
            var position:int;
            var key:String;
            var item:Item;
            var dropFrameMC:DFrameMCcnt;
            var mcIcon:DisplayObject;
            var glowFilter:GlowFilter;
            var buttonType:MovieClip;
            this.choiceID = -1;
            this.cnt.bg.btnPin.visible = false;
            this.cnt.bg.btnWiki.visible = true;
            this.game.world.checkAllQuestStatus();
            this.cnt.mouseChildren = true;
            this.cnt.strTitle.text = this.qData.sName;
            var core:MovieClip = this.cnt.core;
            core.strNote.autoSize = "left";
            core.strNote.text = this.getQuestValidationString(this.qData);
            core.strDesc.mouseWheelEnabled = false;
            core.strReq.mouseWheelEnabled = false;
            core.rewards.strRew.mouseWheelEnabled = false;
            core.strDesc.autoSize = "left";
            core.strReq.autoSize = "left";
            core.rewards.strRew.autoSize = "left";
            core.strDesc.text = ((((this.qData.status == "c") && (this.tIDs.indexOf(String(this.qData.QuestID)) >= 0)) && (!(this.qData.sEndText == ""))) ? this.qData.sEndText : this.qData.sDesc);
            core.strReq.htmlText = "";
            if (this.qData.turnin != null)
            {
                showReq = "";
                count = 0;
                while (count < this.qData.turnin.length)
                {
                    item1 = this.game.world.invTree[this.qData.turnin[count].ItemID];
                    itemTurnQuantity = int(this.qData.turnin[count].iQty);
                    if (count > 0)
                    {
                        showReq = (showReq + ",<br>");
                    };
                    showReq = (showReq + ((item1.iQty < itemTurnQuantity) ? (((((((('<a target="_blank" href="' + Config.serverWikiItemURL) + item1.ItemID) + '">') + item1.sName) + '</a> <font color="#888888">') + item1.iQty) + "/</font>") + itemTurnQuantity) : ((((((((('<font color="#888888"><a target="_blank" href="' + Config.serverWikiItemURL) + item1.ItemID) + '">') + item1.sName) + "</a> ") + item1.iQty) + "/") + itemTurnQuantity) + "</font>")));
                    count++;
                };
                core.strReq.htmlText = showReq;
            };
            var showRew:* = (((((this.qData.iCoins + '<font color="#FF9900"> ') + Config.getString("coins_name_short")) + "</font><br>") + this.qData.iExp) + '<font color="#FF00FF"> Experience</font>');
            if (this.qData.iCP > 0)
            {
                showRew = (showRew + (("<br>" + this.qData.iCP) + " <font color='#66FFFF'>Class points</font>"));
            };
            if (((this.qData.FactionID > 1) && (this.qData.iRep > 0)))
            {
                showRew = (showRew + (((("<br>" + this.qData.iRep) + " <font color='#00FF66'>Reputation : ") + this.qData.sFaction) + "</font>"));
            };
            if (((this.qData.iBadge > 0) || (this.qData.iTitle > 0)))
            {
                if (this.qData.iBadge > 0)
                {
                    showRew = (showRew + (("<br>Badge: <font color='#00FFFF'>" + this.qData.sBadge) + "</font>"));
                };
                if (this.qData.iTitle > 0)
                {
                    showRew = (showRew + (((("<br>Title: <font color='#" + this.qData.sTitleColor) + "'>") + this.qData.sTitle) + "</font>"));
                };
            };
            if (this.qData.battlePassXPs != null)
            {
                showRew = (showRew + "<br><br><i><font color='#CCCCCC'>BATTLE PASS</font><font color='#FF0000'>:</font></i></font>");
                count = 0;
                while (count < this.qData.battlePassXPs.length)
                {
                    battlePass = this.qData.battlePassXPs[count];
                    showRew = (showRew + (((("<br>- " + battlePass.name) + ": <font color='#FF6666'>") + battlePass.experience) + " XP</font>"));
                    count++;
                };
            };
            core.rewards.strRew.htmlText = showRew;
            if (core.strNote.text == "")
            {
                core.descTitle.y = 0;
            }
            else
            {
                core.descTitle.y = ((core.strNote.y + core.strNote.textHeight) + 10);
            };
            core.strDesc.y = (core.descTitle.y + 15);
            core.reqTitle.y = Math.round(((core.strDesc.y + core.strDesc.textHeight) + 10));
            core.strReq.y = (core.reqTitle.y + 15);
            core.rewards.y = Math.round(((core.strReq.y + core.strReq.textHeight) + 10));
            var rewardPosition:Number = ((core.rewards.y + core.rewards.height) + 15);
            if (this.qData.oRewards != null)
            {
                ii = 0;
                while (ii < this.rewardType.length)
                {
                    rewardTypeElement = this.rewardType[ii];
                    switch (rewardTypeElement)
                    {
                        case "itemsS":
                        default:
                            rewardMC = core.rewardsStatic;
                            break;
                        case "itemsC":
                            rewardMC = core.rewardsChoice;
                            break;
                        case "itemsR":
                            rewardMC = core.rewardsRandom;
                            break;
                        case "itemsROLL":
                            rewardMC = core.rewardsRoll;
                            break;
                        case "itemsR_ONE":
                            rewardMC = core.rewardsRandomOne;
                    };
                    if (this.qData.oRewards[rewardTypeElement] == null)
                    {
                        rewardMC.visible = false;
                    }
                    else
                    {
                        rewards = this.qData.oRewards[rewardTypeElement];
                        position = 16;
                        for (key in rewards)
                        {
                            item = new Item(rewards[key]);
                            dropFrameMC = DFrameMCcnt(rewardMC.addChild(new DFrameMCcnt()));
                            dropFrameMC.btnEye.addEventListener(MouseEvent.CLICK, onPreviewClick, false, 0, true);
                            dropFrameMC.ItemData = item;
                            dropFrameMC.ItemID = item.ItemID;
                            dropFrameMC.strRate.text = "";
                            dropFrameMC.strName.autoSize = "left";
                            dropFrameMC.strName.htmlText = item.sName;
                            dropFrameMC.strName.width = (dropFrameMC.strName.textWidth + 6);
                            if (((item.iType == 2) || (item.iType == 4)))
                            {
                                dropFrameMC.strType.htmlText = (((item.sType + " (") + item.iRate) + "%)");
                            }
                            else
                            {
                                dropFrameMC.strType.htmlText = item.sType;
                            };
                            dropFrameMC.bg.width = (dropFrameMC.strName.textWidth + 75);
                            if (dropFrameMC.bg.width < 175)
                            {
                                dropFrameMC.bg.width = 175;
                            };
                            dropFrameMC.fx1.width = dropFrameMC.bg.width;
                            if (item.iQty > 1)
                            {
                                dropFrameMC.strQ.text = ("x" + item.iQty);
                                dropFrameMC.strQ.x = ((dropFrameMC.bg.width - dropFrameMC.strQ.width) - 7);
                                dropFrameMC.strQ.visible = true;
                            }
                            else
                            {
                                dropFrameMC.strQ.x = 0;
                                dropFrameMC.strQ.visible = false;
                            };
                            if (item.iType != 2)
                            {
                                dropFrameMC.strQ.y = 7.4;
                            };
                            Game.root.onRemoveChildrens(dropFrameMC.icon);
                            mcIcon = dropFrameMC.icon.addChild(item.iconClass);
                            mcIcon.scaleX = (mcIcon.scaleY = 0.5);
                            glowFilter = item.rarityGlow;
                            dropFrameMC.icon.filters = [glowFilter];
                            dropFrameMC.bg.filters = [glowFilter];
                            dropFrameMC.y = position;
                            position = (position + Math.round((dropFrameMC.height + 8)));
                            if ((((((rewardTypeElement == "itemsC") && (!(this.qMode == "l"))) && (!(this.qData.status == null))) && (this.qData.status == "c")) && (this.tIDs.indexOf(String(this.qData.QuestID)) >= 0)))
                            {
                                dropFrameMC.mouseEnabled = true;
                                dropFrameMC.mouseChildren = false;
                                dropFrameMC.buttonMode = true;
                                dropFrameMC.addEventListener(MouseEvent.CLICK, this.btnRewardClick, false, 0, true);
                            };
                        };
                    };
                    if (rewardMC.visible)
                    {
                        rewardMC.y = rewardPosition;
                        rewardPosition = ((rewardMC.y + rewardMC.height) + 15);
                    };
                    ii++;
                };
            };
            if (this.qMode == "l")
            {
                switch (this.qData.status)
                {
                    case "c":
                        buttonsType = this.cnt.btns.tri;
                        this.cnt.btns.dual.visible = false;
                        buttons = {
                            "b1":{
                                "txt":"Back",
                                "fn":this.btnBack
                            },
                            "b2":{
                                "txt":"Turn in!",
                                "fn":this.btnComplete
                            },
                            "b3":{
                                "txt":"Abandon",
                                "fn":this.btnAbandon
                            }
                        };
                        break;
                    default:
                        buttonsType = this.cnt.btns.dual;
                        this.cnt.btns.tri.visible = false;
                        buttons = {
                            "b1":{
                                "txt":"Back",
                                "fn":this.btnBack
                            },
                            "b2":{
                                "txt":"Abandon",
                                "fn":this.btnAbandon
                            }
                        };
                };
            }
            else
            {
                switch (this.qData.status)
                {
                    case undefined:
                    case null:
                        buttonsType = this.cnt.btns.dual;
                        this.cnt.btns.tri.visible = false;
                        buttons = {
                            "b1":{
                                "txt":"Accept",
                                "fn":this.btnAccept
                            },
                            "b2":{
                                "txt":"Decline",
                                "fn":this.btnBack
                            }
                        };
                        break;
                    case "c":
                        buttonsType = this.cnt.btns.tri;
                        this.cnt.btns.dual.visible = false;
                        buttons = {
                            "b1":{
                                "txt":"Back",
                                "fn":this.btnBack
                            },
                            "b2":{
                                "txt":"Turn in!",
                                "fn":this.btnComplete
                            },
                            "b3":{
                                "txt":"Abandon",
                                "fn":this.btnAbandon
                            }
                        };
                        break;
                    default:
                        buttonsType = this.cnt.btns.dual;
                        this.cnt.btns.tri.visible = false;
                        buttons = {
                            "b1":{
                                "txt":"Back",
                                "fn":this.btnBack
                            },
                            "b2":{
                                "txt":"Abandon",
                                "fn":this.btnAbandon
                            }
                        };
                };
            };
            for (keyButton in buttons)
            {
                buttonType = buttonsType[keyButton];
                buttonType.buttonMode = true;
                buttonType.fx.visible = false;
                buttonType.ti.mouseEnabled = false;
                buttonType.addEventListener(MouseEvent.MOUSE_OVER, bMouseOver, false, 0, true);
                buttonType.addEventListener(MouseEvent.MOUSE_OUT, bMouseOut, false, 0, true);
                buttonType.ti.text = buttons[keyButton].txt;
                buttonType.addEventListener(MouseEvent.CLICK, buttons[keyButton].fn, false, 0, true);
            };
            this.cnt.scr.h.height = int(((this.cnt.scr.b.height / core.height) * this.cnt.scr.b.height));
            this.hRun = (this.cnt.scr.b.height - this.cnt.scr.h.height);
            this.dRun = ((core.height - this.cnt.scr.b.height) + 20);
            this.cnt.scr.h.y = 0;
            qdy = 58;
            core.oy = (core.y = qdy);
            this.cnt.scr.visible = false;
            this.cnt.scr.hit.alpha = 0;
            this.mDown = false;
            if (core.height > this.cnt.scr.b.height)
            {
                this.cnt.scr.visible = true;
                this.cnt.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                this.cnt.scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                core.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
                if (!MovieClip(this.cnt).hasEventListener(MouseEvent.MOUSE_WHEEL))
                {
                    MovieClip(this.cnt).addEventListener(MouseEvent.MOUSE_WHEEL, this.onQuestWheel, false, 0, true);
                };
            };
        }

        public function killDetailUI():void
        {
            if (this.cnt.core.hasEventListener(Event.ENTER_FRAME))
            {
                this.cnt.core.removeEventListener(Event.ENTER_FRAME, this.dEF);
            };
        }

        public function turninResult(questID:String):void
        {
            this.getQuestListB();
            this.qData = null;
            if (this.cnt.currentLabel == "hold")
            {
                if (questID == "pass")
                {
                    this.qData = this.nextQuestAvailable();
                };
                this.cnt.gotoAndPlay("back");
            };
        }

        private function frame7():void
        {
            stop();
        }

        private function frame12():void
        {
        }

        private function frame16():void
        {
            this.onClose();
        }

        private function isQuestAvailable(quest:Object):Boolean
        {
            if (quest == null)
            {
                return (false);
            };
            if (((!(quest.isLocked == null)) && (quest.isLocked)))
            {
                return (false);
            };
            if (((!(quest.bGuild == null)) && (quest.bGuild == 1)))
            {
                if (this.game.world.myAvatar.objData.guild == null)
                {
                    return (false);
                };
                if (((quest.iReqRep > 0) && (this.game.world.myAvatar.objData.guild.guildRep < quest.iReqRep)))
                {
                    return (false);
                };
            };
            if (((!(quest.sField == null)) && (!(Achievement.getAchievement(quest.sField, quest.iIndex) == 0))))
            {
                return (false);
            };
            if (quest.iLvl > this.game.world.myAvatar.objData.intLevel)
            {
                return (false);
            };
            if (((quest.bUpg == 1) && (!(this.game.world.myAvatar.isUpgraded()))))
            {
                return (false);
            };
            if (((quest.iSlot >= 0) && (this.game.world.getQuestValue(quest.iSlot) < (Math.abs(quest.iValue) - 1))))
            {
                return (false);
            };
            if (((quest.iClass > 0) && (this.game.world.myAvatar.getCPByID(quest.iClass) < quest.iReqCP)))
            {
                return (false);
            };
            if (((quest.FactionID > 1) && (this.game.world.myAvatar.getRep(quest.FactionID) < quest.iReqRep)))
            {
                return (false);
            };
            if (quest.iReqGuildLevel > 0)
            {
                if (this.game.world.myAvatar.objData.guild == null)
                {
                    return (false);
                };
                if (quest.iReqGuildLevel > this.game.world.myAvatar.objData.guild.Level)
                {
                    return (false);
                };
            };
            return (true);
        }

        private function getQuestListA():void
        {
            var quest:Object;
            this.qla = [];
            var i:int;
            while (i < this.qIDs.length)
            {
                quest = this.game.world.questTree[this.qIDs[i]];
                this.qla.push(this.isQuestAvailable(quest));
                i++;
            };
        }

        private function getQuestListB():void
        {
            var quest:Object;
            this.qlb = [];
            var i:int;
            while (i < this.qIDs.length)
            {
                quest = this.game.world.questTree[this.qIDs[i]];
                this.qlb.push(this.isQuestAvailable(quest));
                i++;
            };
        }

        private function nextQuestAvailable():Object
        {
            var quest:Object;
            var i:int;
            while (i < this.qIDs.length)
            {
                if (((!(this.qla[i])) && (this.qlb[i])))
                {
                    quest = this.game.world.questTree[this.qIDs[i]];
                    break;
                };
                i++;
            };
            return (quest);
        }

        private function hasRequiredItemsForQuest(quest:Object):Boolean
        {
            var i:int;
            var itemRequired:Object;
            var itemID:int;
            var quantity:int;
            if (((!(quest.reqd == null)) && (quest.reqd.length > 0)))
            {
                i = 0;
                while (i < quest.reqd.length)
                {
                    itemRequired = quest.reqd[i];
                    itemID = itemRequired.ItemID;
                    quantity = itemRequired.iQty;
                    if (((this.game.world.invTree[itemID] == null) || (int(this.game.world.invTree[itemID].iQty) < quantity)))
                    {
                        return (false);
                    };
                    i++;
                };
            };
            return (true);
        }

        private function getQuestValidationString(quest:Object):String
        {
            var show:String;
            var i:int;
            var itemRequired:Object;
            var item:Object;
            var quantity:int;
            if (quest.strNote != null)
            {
                return (quest.strNote);
            };
            if (((!(quest.sField == null)) && (!(Achievement.getAchievement(quest.sField, quest.iIndex) == 0))))
            {
                return ((quest.sField == "im0") ? "Monthly Quests are only available once per month." : "Daily Quests are only available once per day.");
            };
            if (((quest.bUpg == 1) && (!(this.game.world.myAvatar.isUpgraded()))))
            {
                return ("Hero is required for this quest!");
            };
            if (((quest.iSlot >= 0) && (this.game.world.getQuestValue(quest.iSlot) < (quest.iValue - 1))))
            {
                return ("Quest has not been unlocked!");
            };
            if (quest.iLvl > this.game.world.myAvatar.objData.intLevel)
            {
                return (("Unlocks at Level " + quest.iLvl) + ".");
            };
            if (((quest.iClass > 0) && (this.game.world.myAvatar.getCPByID(quest.iClass) < quest.iReqCP)))
            {
                return (((("Requires " + quest.sClass) + ", Rank ") + Rank.getRankFromPoints(quest.iReqCP)) + ".");
            };
            if (((quest.FactionID > 1) && (this.game.world.myAvatar.getRep(quest.FactionID) < quest.iReqRep)))
            {
                return (((("Requires " + quest.sFaction) + ", Rank ") + Rank.getRankFromPoints(quest.iReqRep)) + ".");
            };
            if (((quest.iReqGuildLevel > 0) && ((this.game.world.myAvatar.objData.guild == null) || (quest.iReqGuildLevel > this.game.world.myAvatar.objData.guild.Level))))
            {
                return (("Unlocks at Guild Level " + quest.iReqGuildLevel) + ".");
            };
            if (((!(quest.reqd == null)) && (!(this.hasRequiredItemsForQuest(quest)))))
            {
                show = "Required Item(s): ";
                i = 0;
                while (i < quest.reqd.length)
                {
                    itemRequired = quest.reqd[i];
                    item = this.game.world.invTree[itemRequired.ItemID];
                    quantity = itemRequired.iQty;
                    if (item.sES == "ar")
                    {
                        show = (show + ((item.sName + ", Rank ") + Rank.getRankFromPoints(quantity)));
                    }
                    else
                    {
                        show = (show + item.sName);
                        if (quantity > 1)
                        {
                            show = (show + ("x" + quantity));
                        };
                    };
                    show = (show + ", ");
                    i++;
                };
                return (show.substr(0, (show.length - 2)) + ".");
            };
            return ("");
        }

        private function isOneTimeQuestDone(quest:Object):Boolean
        {
            return ((quest.bOnce == 1) && ((quest.iSlot < 0) || (this.game.world.getQuestValue(quest.iSlot) >= quest.iValue)));
        }

        private function buildQuestList():void
        {
            var quest:Object;
            var questProto:qProto;
            var i:int;
            while (i < this.qIDs.length)
            {
                quest = this.game.world.questTree[this.qIDs[i]];
                if (((!(quest == null)) && (!(this.isOneTimeQuestDone(quest)))))
                {
                    questProto = qProto(this.cnt.qList.addChild(new qProto()));
                    questProto.ti.htmlText = ((this.isQuestAvailable(quest)) ? (("<font color='#009900'><b>" + quest.sName) + "</b></font>") : (("<font color='#990000'><b>" + quest.sName) + "</b></font>"));
                    questProto.addEventListener(MouseEvent.CLICK, this.qListClick);
                    questProto.QuestID = quest.QuestID;
                    if (quest.sTyp != null)
                    {
                        questProto.ti.htmlText = (questProto.ti.htmlText + ((' <font color="#888888">' + quest.sTyp) + "</font>"));
                    };
                    switch (quest.status)
                    {
                        case "p":
                            questProto.ti.htmlText = (questProto.ti.htmlText + "<font color='#888888'> - In progress</font>");
                            break;
                        case "c":
                            questProto.ti.htmlText = (questProto.ti.htmlText + "<font color='#99FF00'> - <b>Complete!</b></font>");
                            break;
                    };
                    questProto.addEventListener(MouseEvent.MOUSE_OVER, this.iMouseOver, false, 0, true);
                    questProto.addEventListener(MouseEvent.MOUSE_OUT, this.iMouseOut, false, 0, true);
                    questProto.buttonMode = true;
                    questProto.hit.alpha = 0;
                    questProto.y = (i * 20);
                    questProto.x = 10;
                };
                i++;
            };
            var list:MovieClip = this.cnt.qList;
            this.cnt.scr.h.height = int(((this.cnt.scr.b.height / list.height) * this.cnt.scr.b.height));
            this.hRun = (this.cnt.scr.b.height - this.cnt.scr.h.height);
            this.dRun = ((list.height - this.cnt.scr.b.height) + 20);
            this.cnt.scr.h.y = 0;
            var qly:int = 70;
            list.oy = (list.y = qly);
            this.cnt.scr.visible = false;
            this.cnt.scr.hit.alpha = 0;
            this.mDown = false;
            if (list.height > this.cnt.scr.b.height)
            {
                this.cnt.scr.visible = true;
                this.cnt.scr.hit.addEventListener(MouseEvent.MOUSE_DOWN, this.scrDown, false, 0, true);
                this.cnt.scr.h.addEventListener(Event.ENTER_FRAME, this.hEF, false, 0, true);
                list.addEventListener(Event.ENTER_FRAME, this.dEF, false, 0, true);
            };
            this.cnt.qList.iproto.visible = false;
        }

        private function showEmptyList():void
        {
            var questProto:qProto = qProto(this.cnt.qList.addChild(new qProto()));
            questProto.ti.htmlText = "<font color=\"#DDDDDD\">You aren't on any quests!</font>";
            questProto.hit.alpha = 0;
            questProto.x = 10;
            this.cnt.qList.iproto.visible = false;
            this.cnt.scr.visible = false;
        }

        public function onQuestWheel(e:MouseEvent):void
        {
            var quest:MovieClip = MovieClip(e.currentTarget.scr);
            quest.h.y = (quest.h.y + ((e.delta * -1) * 3));
            if (quest.h.y < 0)
            {
                quest.h.y = 0;
            };
            if ((quest.h.y + quest.h.height) > quest.b.height)
            {
                quest.h.y = int((quest.b.height - quest.h.height));
            };
        }

        private function qListClick(_arg1:MouseEvent):void
        {
            var questProto:qProto = qProto(_arg1.currentTarget);
            this.qData = this.game.world.questTree[questProto.QuestID];
            questProto.removeEventListener(MouseEvent.CLICK, this.qListClick);
            questProto.removeEventListener(MouseEvent.MOUSE_OVER, this.iMouseOver);
            questProto.removeEventListener(MouseEvent.MOUSE_OUT, this.iMouseOut);
            this.cnt.gotoAndPlay("out");
            if (this.cnt.qList.hasEventListener(Event.ENTER_FRAME))
            {
                this.cnt.qList.removeEventListener(Event.ENTER_FRAME, this.dEF);
            };
            this.cnt.qList.mouseEnabled = false;
            this.cnt.qList.mouseChildren = false;
        }

        private function onBtnLibraryClick(event:MouseEvent):void
        {
            navigateToURL(new URLRequest((Config.serverWikiQuestURL + this.qData.QuestID)), "_blank");
        }

        private function scrDown(_arg1:MouseEvent):void
        {
            this.mbY = int(mouseY);
            this.mhY = int(MovieClip(_arg1.currentTarget.parent).h.y);
            this.mDown = true;
            stage.addEventListener(MouseEvent.MOUSE_UP, this.scrUp, false, 0, true);
        }

        private function scrUp(_arg1:MouseEvent):void
        {
            this.mDown = false;
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.scrUp);
        }

        private function hEF(_arg1:Event):void
        {
            var _local2:*;
            if (this.mDown)
            {
                _local2 = MovieClip(_arg1.currentTarget.parent);
                this.mbD = (int(mouseY) - this.mbY);
                _local2.h.y = (this.mhY + this.mbD);
                if ((_local2.h.y + _local2.h.height) > _local2.b.height)
                {
                    _local2.h.y = int((_local2.b.height - _local2.h.height));
                };
                if (_local2.h.y < 0)
                {
                    _local2.h.y = 0;
                };
            };
        }

        private function dEF(event:Event):void
        {
            var subject2:MovieClip;
            var subject:MovieClip;
            subject2 = MovieClip(event.currentTarget.parent).scr;
            subject = MovieClip(event.currentTarget);
            var number:Number = (int(((-(subject2.h.y) / this.hRun) * this.dRun)) + subject.oy);
            subject.y = ((Math.abs((number - subject.y)) > 0.2) ? (subject.y + ((number - subject.y) / 1.1)) : number);
        }

        private function btnAccept(_arg1:MouseEvent):void
        {
            var button:MovieClip;
            this.cnt.bg.btnPin.visible = true;
            this.cnt.bg.btnWiki.visible = false;
            var validation:String = this.getQuestValidationString(this.qData);
            if (validation != "")
            {
                this.game.MsgBox.notify(validation);
            }
            else
            {
                if (this.game.world.coolDown("acceptQuest"))
                {
                    this.game.mixer.playSound("QuestAccept");
                    button = MovieClip(_arg1.currentTarget);
                    MainController.setCT(button.bg, 43775);
                    button.removeEventListener(MouseEvent.CLICK, this.btnAccept);
                    button.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
                    button.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
                    this.game.world.acceptQuest(this.qData.QuestID);
                    this.qData = null;
                    this.cnt.gotoAndPlay("back");
                };
            };
        }

        private function btnAbandon(_arg1:MouseEvent):void
        {
            this.cnt.bg.btnPin.visible = true;
            this.cnt.bg.btnWiki.visible = false;
            var button:MovieClip = MovieClip(_arg1.currentTarget);
            this.game.world.abandonQuest(this.qData.QuestID);
            MainController.setCT(button.bg, 0xFF0000);
            button.removeEventListener(MouseEvent.CLICK, this.btnAbandon);
            button.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
            button.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
            this.qData = null;
            this.cnt.gotoAndPlay("back");
        }

        private function btnComplete(_arg1:MouseEvent):void
        {
            var button:MovieClip;
            var quantityToTurn:int;
            this.cnt.bg.btnPin.visible = true;
            this.cnt.bg.btnWiki.visible = false;
            if (((this.game.world.coolDown("tryQuestComplete")) && (this.game.world.canTurnInQuest(this.qData.QuestID))))
            {
                if (((!(this.qData.oRewards.itemsC == null)) && (this.choiceID == -1)))
                {
                    this.game.addUpdate("Please choose a reward before turning the quest in!");
                    this.game.chatF.pushMsg("warning", "Please choose a reward before turning the quest in!", "SERVER", "", 0);
                    return;
                };
                button = MovieClip(_arg1.currentTarget);
                MainController.setCT(button.bg, 0xFF00);
                button.removeEventListener(MouseEvent.CLICK, this.btnAbandon);
                button.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
                button.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
                this.cnt.gotoAndPlay("hold");
                this.getQuestListA();
                quantityToTurn = this.game.world.quantityToTurn(this.qData.QuestID);
                if (quantityToTurn > 1)
                {
                    MainController.modal("Number of quantity to complete:", this.game.world.tryQuestCompleteMulti, {
                        "questId":this.qData.QuestID,
                        "choiceId":this.choiceID
                    }, "white,medium", "dual", true, {
                        "min":1,
                        "max":quantityToTurn
                    });
                }
                else
                {
                    this.game.world.tryQuestComplete(this.qData.QuestID, this.choiceID);
                };
            };
        }

        private function btnBack(_arg1:MouseEvent):void
        {
            this.cnt.bg.btnPin.visible = true;
            this.cnt.bg.btnWiki.visible = false;
            var button:MovieClip = MovieClip(_arg1.currentTarget);
            MainController.setCT(button.bg, 0xAAAAAA);
            button.removeEventListener(MouseEvent.CLICK, this.btnBack);
            button.removeEventListener(MouseEvent.MOUSE_OVER, bMouseOver);
            button.removeEventListener(MouseEvent.MOUSE_OUT, bMouseOut);
            this.cnt.mouseChildren = false;
            this.qData = null;
            this.cnt.gotoAndPlay("back");
        }

        private function btnRewardClick(_arg1:MouseEvent):void
        {
            var _local4:MovieClip;
            var _local5:Array;
            var _local2:MovieClip = (_arg1.currentTarget as MovieClip);
            var _local3:MovieClip = (_local2.parent as MovieClip);
            this.choiceID = _local2.ItemID;
            var _local6:int = 1;
            while (_local6 < _local3.numChildren)
            {
                _local4 = (_local3.getChildAt(_local6) as MovieClip);
                _local5 = _local4.bg.filters;
                if (((this.choiceID == _local4.ItemID) && (_local5.length == 1)))
                {
                    _local5.push(new GlowFilter(16763955, 1, 5, 5, 2, 1, true, false));
                    _local4.bg.filters = _local5;
                };
                if (((!(this.choiceID == _local4.ItemID)) && (_local5.length > 1)))
                {
                    _local5.pop();
                    _local4.bg.filters = _local5;
                };
                _local6++;
            };
        }

        private function iMouseOver(mouseEvent:MouseEvent):*
        {
            var movieClip:MovieClip = MovieClip(mouseEvent.currentTarget);
            MovieClip(movieClip.parent).mHi.visible = true;
            MovieClip(movieClip.parent).mHi.y = movieClip.y;
        }

        private function iMouseOut(mouseEvent:MouseEvent):*
        {
            MovieClip(mouseEvent.currentTarget.parent).mHi.visible = false;
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            UIController.close("quest_frame");
        }


    }
}//package 

