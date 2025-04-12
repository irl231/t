// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//apopScene

package 
{
    import flash.display.Sprite;
    import flash.text.TextFormat;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.*;
    import flash.text.*;
    import Main.Aqw.*;

    public class apopScene extends Sprite 
    {

        private const titleFormat:TextFormat = new TextFormat("Arial", 16, null, true);
        private const descFormat:TextFormat = new TextFormat("Arial", 12);
        private const questFormat:TextFormat = new TextFormat("Arial", 9, null, true);
        private const coinFormat:TextFormat = new TextFormat("Arial", 12, null, true);
        private const btnAccept:Object = {
            "intAction":9,
            "buttonText":"Begin Quest",
            "buttonID":-1,
            "strIcon":"iidesign"
        };
        private const btnTurnin:Object = {
            "intAction":11,
            "buttonText":"Turnin",
            "buttonID":-1,
            "strIcon":"iCheck"
        };
        private const btnAbandon:Object = {
            "intAction":12,
            "buttonText":"Abandon",
            "buttonID":-1,
            "strIcon":"iTrash",
            "width":148
        };
        private const btnBack:Object = {
            "intAction":10,
            "buttonText":"Back",
            "strIcon":"iArrow",
            "buttonID":-1
        };
        private const rewardTypes:Array = ["itemsS", "itemsC", "itemsR", "itemsROLL", "itemsR_ONE"];

        public var mcBackground:MovieClip;
        public var bMask:MovieClip;
        public var bMask2:MovieClip;
        public var mcGold:MovieClip;
        public var tbBold:TextField;
        public var mcScene2:MovieClip;
        public var mcScene:MovieClip;
        public var accepted:Boolean = false;
        private var rootClass:Game;
        private var bQuest:Boolean;
        private var intBack:int = -1;
        private var qID:int;
        private var questTitle:String;
        private var parent_:apopCore;
        private var initialized:Boolean = false;
        private var complete:Boolean = false;
        private var tbTitle:TextField;
        private var tbDesc:TextField;
        private var tbQuestO:TextField;
        private var tbReward:TextField;
        private var tbCoinExp:TextField;
        private var ID_:int = -1;
        private var curY:Number;
        private var btns:apopBtn;
        private var start_:Boolean = false;
        private var locked:Boolean = false;
        private var qData:Object;
        private var arrQuest:Array;
        private var arrBtns:Array;
        private var questBtns:Array;
        private var item:Object;

        public function apopScene(_arg1:MovieClip, _arg2:Object, _arg3:apopCore)
        {
            var _local4:Sprite;
            var _local5:Object;
            var _local6:uint;
            var _local7:mcObjective;
            var _local8:MovieClip;
            var _local9:*;
            var _local10:String;
            var _local11:Class;
            var _local12:MovieClip;
            var _local13:MovieClip;
            this.questBtns = [];
            super();
            if (_arg2.sceneID != null)
            {
                this.rootClass = _arg1;
                this.parent_ = _arg3;
                this.bQuest = _arg2.bType;
                if (_arg2.arrQuests != null)
                {
                    this.arrQuest = String(_arg2.arrQuests).split(",");
                };
                if (_arg2.sBtns != null)
                {
                    this.arrBtns = _arg2.sBtns;
                };
                this.tbBold.visible = false;
                this.bMask.visible = false;
                this.bMask2.visible = false;
                this.ID_ = _arg2.sceneID;
                this.start_ = _arg2.bStart;
                if (_arg2.strLock != null)
                {
                    this.locked = this.decodeLock(_arg2.strLock);
                };
                if (this.bQuest)
                {
                    this.qID = _arg2.qID;
                    this.qData = this.rootClass.world.questTree[_arg2.qID];
                    this.tbTitle = new TextField();
                    this.tbTitle.defaultTextFormat = this.titleFormat;
                    this.tbTitle.embedFonts = true;
                    this.tbTitle.antiAliasType = AntiAliasType.ADVANCED;
                    this.tbTitle.text = this.qData.sName;
                    this.questTitle = this.qData.sName;
                    this.tbTitle.width = 283;
                    this.tbTitle.mouseEnabled = false;
                    this.mcScene.addChild(this.tbTitle);
                    this.tbDesc = new TextField();
                    this.tbDesc.defaultTextFormat = this.descFormat;
                    this.tbDesc.embedFonts = true;
                    this.tbDesc.wordWrap = true;
                    this.tbDesc.multiline = true;
                    this.tbDesc.width = 283;
                    this.tbDesc.antiAliasType = AntiAliasType.ADVANCED;
                    this.tbDesc.text = this.qData.sDesc;
                    this.tbDesc.mouseEnabled = false;
                    this.tbDesc.y = 22;
                    this.mcScene.addChild(this.tbDesc);
                    this.tbDesc.height = (this.tbDesc.textHeight + 10);
                    this.curY = (this.tbDesc.y + this.tbDesc.height);
                    if (this.qData.turnin != null)
                    {
                        this.tbQuestO = new TextField();
                        this.tbQuestO.defaultTextFormat = this.questFormat;
                        this.tbQuestO.embedFonts = true;
                        this.tbQuestO.antiAliasType = AntiAliasType.ADVANCED;
                        this.tbQuestO.width = 283;
                        this.tbQuestO.text = "QUEST OBJECTIVES";
                        this.tbQuestO.mouseEnabled = false;
                        this.tbQuestO.y = this.curY;
                        this.mcScene.addChild(this.tbQuestO);
                        this.curY = (this.curY + 15);
                        _local6 = 0;
                        while (_local6 < this.qData.turnin.length)
                        {
                            _local5 = this.rootClass.world.invTree[this.qData.turnin[_local6].ItemID];
                            _local7 = new mcObjective();
                            _local7.x = 1;
                            _local7.y = this.curY;
                            this.curY = (this.curY + 18.25);
                            _local7.txtObjective.text = ((((_local5.sName + " ") + _local5.iQty) + "/") + this.qData.turnin[_local6].iQty);
                            if (_local5.iQty >= this.qData.turnin[_local6].iQty)
                            {
                                _local7.txtObjective.textColor = 2518295;
                            }
                            else
                            {
                                _local7.txtObjective.textColor = 8198940;
                            };
                            this.mcScene.addChild(_local7);
                            _local6++;
                        };
                    };
                    this.curY = (this.curY + 7);
                    this.tbReward = new TextField();
                    this.tbReward.defaultTextFormat = this.questFormat;
                    this.tbReward.embedFonts = true;
                    this.tbReward.antiAliasType = AntiAliasType.ADVANCED;
                    this.tbReward.width = 283;
                    this.tbReward.text = "REWARDS";
                    this.tbReward.y = this.curY;
                    this.tbReward.mouseEnabled = false;
                    this.mcScene.addChild(this.tbReward);
                    this.curY = (this.curY + 17);
                    _local4 = new iCoin();
                    _local4.x = 2;
                    _local4.y = this.curY;
                    _local4.width = (_local4.height = 17);
                    this.mcScene.addChild(_local4);
                    this.tbCoinExp = new TextField();
                    this.tbCoinExp.defaultTextFormat = this.coinFormat;
                    this.tbCoinExp.embedFonts = true;
                    this.tbCoinExp.textColor = 0x4C4C4C;
                    this.tbCoinExp.antiAliasType = AntiAliasType.ADVANCED;
                    this.tbCoinExp.text = ("x" + this.qData.iGold);
                    this.tbCoinExp.x = 23;
                    this.tbCoinExp.y = this.curY;
                    this.tbCoinExp.mouseEnabled = false;
                    this.mcScene.addChild(this.tbCoinExp);
                    _local4 = new iXP();
                    _local4.x = 79;
                    _local4.y = this.curY;
                    _local4.width = 27;
                    _local4.height = 18;
                    this.mcScene.addChild(_local4);
                    this.tbCoinExp = new TextField();
                    this.tbCoinExp.defaultTextFormat = this.coinFormat;
                    this.tbCoinExp.embedFonts = true;
                    this.tbCoinExp.textColor = 0x4C4C4C;
                    this.tbCoinExp.antiAliasType = AntiAliasType.ADVANCED;
                    this.tbCoinExp.text = ("x" + this.qData.iExp);
                    this.tbCoinExp.x = (_local4.x + 30);
                    this.tbCoinExp.y = this.curY;
                    this.tbCoinExp.mouseEnabled = false;
                    this.mcScene.addChild(this.tbCoinExp);
                    this.curY = (this.curY + 25);
                    if (this.qData.oRewards != null)
                    {
                        _local6 = 0;
                        while (_local6 < this.rewardTypes.length)
                        {
                            if (this.qData.oRewards[this.rewardTypes[_local6]] != null)
                            {
                                this.tbCoinExp = new TextField();
                                this.tbCoinExp.defaultTextFormat = this.coinFormat;
                                this.tbCoinExp.embedFonts = true;
                                this.tbCoinExp.textColor = 0x4C4C4C;
                                this.tbCoinExp.antiAliasType = AntiAliasType.ADVANCED;
                                this.tbCoinExp.y = this.curY;
                                this.tbCoinExp.mouseEnabled = false;
                                switch (this.rewardTypes[_local6])
                                {
                                    case "itemsS":
                                    default:
                                        this.tbCoinExp.text = "Items:";
                                        break;
                                    case "itemsC":
                                        this.tbCoinExp.text = "You may also choose one of:";
                                        break;
                                    case "itemsR":
                                        this.tbCoinExp.text = "You may also recieve, at random:";
                                        break;
                                    case "itemsROLL":
                                        this.tbCoinExp.text = "You will recieve ONE OF THE FOLLOWING ITEMS:";
                                        break;
                                    case "itemsR_ONE":
                                        this.tbCoinExp.text = "You will recieve ONE OF THE FOLLOWING ITEMS:";
                                };
                                this.mcScene.addChild(this.tbCoinExp);
                                this.curY = (this.curY + 17);
                                for (_local9 in this.qData.oRewards[this.rewardTypes[_local6]])
                                {
                                    _local8 = new mcItem();
                                    _local8.y = this.curY;
                                    _local5 = this.qData.oRewards[this.rewardTypes[_local6]][_local9];
                                    _local8.txtName.text = _local5.sName;
                                    _local8.txtQty.text = ("X" + _local5.iQty);
                                    this.mcScene.addChild(_local8);
                                    _local10 = "";
                                    if (_local5.sType.toLowerCase() == "enhancement")
                                    {
                                        _local10 = this.rootClass.getIconBySlot(_local5.sES);
                                    }
                                    else
                                    {
                                        if ((((_local5.sIcon == null) || (_local5.sIcon == "")) || (_local5.sIcon == "none")))
                                        {
                                            if (_local5.sLink.toLowerCase() != "none")
                                            {
                                                _local10 = "iidesign";
                                            }
                                            else
                                            {
                                                _local10 = "iibag";
                                            };
                                        }
                                        else
                                        {
                                            _local10 = _local5.sIcon;
                                        };
                                    };
                                    try
                                    {
                                        _local11 = (this.rootClass.world.getClass(_local10) as Class);
                                        _local12 = (_local8.addChild(new (_local11)()) as MovieClip);
                                        _local12.scaleX = (_local12.scaleY = 0.5);
                                    }
                                    catch(e:Error)
                                    {
                                    };
                                    this.curY = (this.curY + 33);
                                };
                            };
                            _local6++;
                        };
                    };
                    this.curY = (this.curY + 20);
                    if (this.curY > 290)
                    {
                        _local13 = (this.addChild(new sBar(this.mcScene, this.bMask, this.rootClass)) as MovieClip);
                        _local13.x = 309;
                        _local13.y = 25;
                        this.curY = 290;
                    };
                    this.mcBackground.height = this.curY;
                    this.mcBackground.height = ((this.mcBackground.height < 130) ? 130 : this.mcBackground.height);
                    this.curY = (this.mcBackground.height + 15);
                }
                else
                {
                    this.tbDesc = new TextField();
                    this.tbDesc.defaultTextFormat = this.descFormat;
                    this.tbDesc.embedFonts = true;
                    this.tbDesc.wordWrap = true;
                    this.tbDesc.multiline = true;
                    this.tbDesc.width = 283;
                    this.tbDesc.antiAliasType = AntiAliasType.ADVANCED;
                    this.tbDesc.text = _arg2.strText;
                    this.tbDesc.mouseEnabled = false;
                    this.mcScene.addChild(this.tbDesc);
                    this.tbDesc.height = (this.tbDesc.textHeight + 10);
                    this.curY = (this.tbDesc.height + 15);
                    this.mcBackground.height = this.curY;
                    this.mcBackground.height = ((this.mcBackground.height < 130) ? 130 : this.mcBackground.height);
                    this.curY = (this.mcBackground.height + 15);
                    if (this.arrQuest != null)
                    {
                        this.tbTitle = new TextField();
                        this.tbTitle.defaultTextFormat = this.titleFormat;
                        this.tbTitle.embedFonts = true;
                        this.tbTitle.antiAliasType = AntiAliasType.ADVANCED;
                        this.tbTitle.text = "Quests";
                        this.tbTitle.width = 283;
                        this.tbTitle.y = this.tbDesc.height;
                        this.tbTitle.mouseEnabled = false;
                        this.mcScene.addChild(this.tbTitle);
                        this.curY = (this.tbTitle.y + 22);
                        this.mcBackground.height = this.curY;
                    };
                };
            };
        }

        public function get ID():int
        {
            return (this.ID_);
        }

        public function get QuestID():int
        {
            return (this.qID);
        }

        public function get Start():Boolean
        {
            return (this.start_);
        }

        public function get Locked():Boolean
        {
            return (this.locked);
        }

        public function get Quest():Boolean
        {
            return (this.bQuest);
        }

        public function get QuestTitle():String
        {
            return (this.questTitle);
        }

        public function get Parent():apopCore
        {
            return (this.parent_);
        }

        public function isQuestComplete():Boolean
        {
            var _local1:Object;
            var _local2:uint;
            if (this.qData.turnin.length < 1)
            {
                return (true);
            };
            while (_local2 < this.qData.turnin.length)
            {
                _local1 = this.rootClass.world.invTree[this.qData.turnin[_local2].ItemID];
                if (_local1.iQty < this.qData.turnin[_local2].iQty)
                {
                    return (false);
                };
                _local2++;
            };
            return (true);
        }

        public function isQuestAvailable():Boolean
        {
            if (this.qData != null)
            {
                if (((!(this.qData.bGuild == null)) && (this.qData.bGuild == 1)))
                {
                    if (this.rootClass.world.myAvatar.objData.guild == null)
                    {
                        return (false);
                    };
                    if (((this.qData.iReqRep > 0) && (this.rootClass.world.myAvatar.objData.guild.guildRep < this.qData.iReqRep)))
                    {
                        return (false);
                    };
                };
                if ((((((((!(this.qData.sField == null)) && (!(Achievement.getAchievement(this.qData.sField, this.qData.iIndex) == 0))) || (this.qData.iLvl > this.rootClass.world.myAvatar.objData.intLevel)) || ((this.qData.bUpg == 1) && (!(this.rootClass.world.myAvatar.isUpgraded())))) || ((this.qData.iSlot >= 0) && (this.rootClass.world.getQuestValue(this.qData.iSlot) < (Math.abs(this.qData.iValue) - 1)))) || ((this.qData.iClass > 0) && (this.rootClass.world.myAvatar.getCPByID(this.qData.iClass) < this.qData.iReqCP))) || ((this.qData.FactionID > 1) && (this.rootClass.world.myAvatar.getRep(this.qData.FactionID) < this.qData.iReqRep))))
                {
                    return (false);
                };
            }
            else
            {
                return (false);
            };
            return (true);
        }

        public function init(_arg1:int=-1):void
        {
            var _local2:Boolean;
            var _local3:apopScene;
            var _local4:uint;
            var _local5:questBtn;
            var _local6:uint;
            var _local7:MovieClip;
            var _local8:int;
            var _local9:int;
            if (_arg1 > -1)
            {
                this.intBack = _arg1;
            };
            this.btnBack.width = 227;
            if (this.bQuest)
            {
                if (this.initialized)
                {
                    return;
                };
                this.accepted = this.rootClass.world.isQuestInProgress(this.qID);
                if (!this.accepted)
                {
                    this.btns = new apopBtn(this.rootClass, this.btnAccept, this);
                    this.btns.y = this.curY;
                    this.btns.x = 50;
                    this.addChild(this.btns);
                    this.curY = (this.curY + 37);
                    this.btns = new apopBtn(this.rootClass, this.btnBack, this);
                    this.btns.y = this.curY;
                    this.btns.x = 50;
                    this.addChild(this.btns);
                }
                else
                {
                    _local2 = false;
                    if (this.isQuestComplete())
                    {
                        this.btns = new apopBtn(this.rootClass, this.btnTurnin, this);
                        this.btns.y = this.curY;
                        this.btns.x = 50;
                        this.addChild(this.btns);
                        this.btnBack.width = 148;
                        this.curY = (this.curY + 37);
                        this.btns = new apopBtn(this.rootClass, this.btnBack, this);
                        this.btns.y = this.curY;
                        this.btns.x = 10;
                        this.addChild(this.btns);
                        this.btns = new apopBtn(this.rootClass, this.btnAbandon, this);
                        this.btns.y = this.curY;
                        this.btns.x = 170;
                        this.addChild(this.btns);
                    }
                    else
                    {
                        this.btnBack.width = 148;
                        this.btns = new apopBtn(this.rootClass, this.btnBack, this);
                        this.btns.y = this.curY;
                        this.btns.x = 10;
                        this.addChild(this.btns);
                        this.btns = new apopBtn(this.rootClass, this.btnAbandon, this);
                        this.btns.y = this.curY;
                        this.btns.x = 170;
                        this.addChild(this.btns);
                    };
                };
                this.mcGold.height = (this.curY + 50);
            }
            else
            {
                if (this.arrQuest != null)
                {
                    if (this.initialized)
                    {
                        while (_local4 < this.questBtns.length)
                        {
                            _local3 = this.parent_.getQuestScene(("q" + String(this.questBtns[_local4].ID)));
                            this.questBtns[_local4].update(this.rootClass.world.isQuestInProgress(_local3.QuestID), _local3.isQuestAvailable(), _local3.isQuestComplete());
                            _local4++;
                        };
                    }
                    else
                    {
                        _local6 = 0;
                        while (_local6 < this.arrQuest.length)
                        {
                            _local3 = this.parent_.getQuestScene(("q" + String(this.arrQuest[_local6])));
                            _local5 = new questBtn(this.parent_, {
                                "sceneID":_local3.QuestID,
                                "strText":_local3.QuestTitle,
                                "accepted":this.rootClass.world.isQuestInProgress(_local3.QuestID),
                                "available":_local3.isQuestAvailable(),
                                "complete":_local3.isQuestComplete()
                            }, this.rootClass);
                            _local5.x = 1;
                            _local5.y = this.curY;
                            this.questBtns.push(_local5);
                            this.mcScene.addChild(_local5);
                            this.curY = (this.curY + 18.25);
                            _local6++;
                        };
                        this.curY = (this.curY + 30);
                        if (this.curY > 290)
                        {
                            _local7 = (this.addChild(new sBar(this.mcScene, this.bMask, this.rootClass)) as MovieClip);
                            _local7.x = 309;
                            _local7.y = 25;
                            this.curY = 290;
                        };
                        this.mcBackground.height = this.curY;
                        this.mcBackground.height = ((this.mcBackground.height < 130) ? 130 : this.mcBackground.height);
                        this.curY = (this.mcBackground.height + 30);
                        this.btns = new apopBtn(this.rootClass, this.btnBack, this);
                        this.btns.y = this.curY;
                        this.btns.x = 50;
                        this.addChild(this.btns);
                        this.curY = (this.curY + 30);
                    };
                }
                else
                {
                    if (this.arrBtns != null)
                    {
                        if (this.initialized)
                        {
                            return;
                        };
                        if (!this.start_)
                        {
                            this.arrBtns.push(this.btnBack);
                        };
                        _local8 = this.arrBtns.length;
                        _local9 = 10;
                        _local9 = 0;
                        this.mcScene2.y = this.curY;
                        this.bMask2.y = this.curY;
                        _local6 = 0;
                        while (_local6 < _local8)
                        {
                            this.btns = new apopBtn(this.rootClass, this.arrBtns[_local6], this);
                            this.btns.y = _local9;
                            this.curY = (this.curY + 37);
                            _local9 = (_local9 + 37);
                            this.mcScene2.addChild(this.btns);
                            _local6++;
                        };
                        if (this.curY > 360)
                        {
                            this.curY = 360;
                            this.bMask2.height = (360 - this.bMask2.y);
                            _local7 = (this.addChild(new sBar(this.mcScene2, this.bMask2, this.rootClass)) as MovieClip);
                            _local7.x = 309;
                            _local7.y = (this.mcScene2.y + 5);
                        };
                    }
                    else
                    {
                        if (((!(this.start_)) && (!(this.initialized))))
                        {
                            this.btns = new apopBtn(this.rootClass, this.btnBack, this);
                            this.btns.y = this.curY;
                            this.btns.x = 40;
                            this.addChild(this.btns);
                            this.curY = (this.curY + 30);
                        };
                    };
                };
                this.mcGold.height = (this.curY + 20);
            };
            this.initialized = true;
        }

        public function Back():void
        {
            this.parent_.showScene(this.intBack, true);
        }

        private function decodeLock(_arg1:String):Boolean
        {
            var lockData:Array;
            var qVal:int;
            var fct:Function;
            var i:uint;
            var strLock:String = _arg1;
            var lockTokens:Array = strLock.split(";");
            var bReturn:Boolean = true;
            while (i < lockTokens.length)
            {
                lockData = lockTokens[i].split(",");
                switch (lockData[0])
                {
                    case "map":
                        try
                        {
                            fct = this.rootClass.world.map[lockData[1]];
                            return (fct(this.ID_));
                        }
                        catch(e)
                        {
                        };
                        break;
                    case "qs":
                        qVal = this.rootClass.world.getQuestValue(int(lockData[1]));
                        bReturn = ((bReturn) && (qVal >= int(lockData[2])));
                        break;
                    case "qsb":
                        qVal = this.rootClass.world.getQuestValue(int(lockData[1]));
                        bReturn = ((bReturn) && ((qVal >= int(lockData[2])) && (qVal < int(lockData[3]))));
                        break;
                    case "qip":
                        bReturn = ((bReturn) && (this.rootClass.world.isQuestInProgress(int(lockData[1]))));
                        break;
                    case "item":
                        bReturn = ((bReturn) && (this.rootClass.world.myAvatar.isItemInInventory(int(lockData[1]))));
                        break;
                };
                i++;
            };
            return (!(bReturn));
        }


    }
}//package 

