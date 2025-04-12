// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//cMenuMC

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import Main.*;

    public class cMenuMC extends MovieClip 
    {

        public var cnt:MovieClip;
        private var fData:Object = null;
        private var fMode:String;
        private var mc:MovieClip;
        private var rootClass:Game;

        public function cMenuMC()
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 9, this.frame10);
            this.mc = MovieClip(this);
            this.rootClass = Game.root;
            this.mc.cnt.iproto.visible = false;
            this.mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOn);
            this.mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
            this.fData = {};
            this.fData.params = {};
            this.fData.user = ["Char Page", "Whisper", "Relationship", "Add Friend", "Invite", "Report", "Delete Friend", "Duel", "Trade", "Ignore", "Close"];
            this.fData.friend = ["Char Page", "Whisper", "Relationship", "Add Friend", "Go To", "Invite", "Report", "Delete Friend", "Ignore", "Close"];
            this.fData.party = ["Char Page", "Whisper", "Relationship", "Add Friend", "Go To", "Remove", "Summon", "Promote", "Report", "Delete Friend", "Duel", "Trade", "Ignore", "Close"];
            this.fData.self = ["Char Page", "Reputation", "Relationship", "Leave Party", "Close"];
            this.fData.npc = ["Information", "Close"];
            this.fData.monster = ["Information", "Close"];
            this.fData.pvpqueue = ["Leave Queue", "Close"];
            this.fData.offline = ["Delete Friend", "Char Page", "Close"];
            this.fData.ignored = ["Char Page", "Unignore", "Relationship", "Close"];
            this.fData.selfguild = ["Char Page", "Relationship", "Leave Guild", "Close"];
            this.fData.guildrank = ["Delete Rank", "Close"];
            this.fData.guild = this.fData.user;
            this.fData.cl = [];
            this.fData.clc = [];
        }

        private static function mouseOn(_arg1:MouseEvent):void
        {
            MovieClip(_arg1.currentTarget).cnt.gotoAndStop("hold");
        }

        private static function mouseOut(_arg1:MouseEvent):void
        {
            MovieClip(_arg1.currentTarget).cnt.gotoAndPlay("out");
        }


        public function fOpenWith(_arg1:String, _arg2:Object):void
        {
            var _local3:int;
            var _local7:*;
            var _local8:*;
            var _local9:*;
            this.fMode = _arg1.toLowerCase();
            this.fData.params = _arg2;
            this.mc.cnt.mHi.visible = false;
            var iCT:ColorTransform = this.mc.cnt.mHi.transform.colorTransform;
            iCT.color = 13434675;
            this.mc.cnt.mHi.transform.colorTransform = iCT;
            _local3 = 0;
            while (_local3 < this.fData.user.length)
            {
                _local7 = this.mc.cnt.getChildByName(("i" + _local3));
                if (_local7 != null)
                {
                    _local7.removeEventListener(MouseEvent.CLICK, this.itemClick);
                    _local7.removeEventListener(MouseEvent.MOUSE_OVER, this.itemMouseOver);
                    this.mc.cnt.removeChild(_local7);
                };
                _local3++;
            };
            var _local4:* = 0;
            delete this.fData.cl;
            delete this.fData.clc;
            var _local5:String = this.fData.params.strUsername.toLowerCase();
            var _local6:* = this.rootClass.world.uoTree[_local5];
            this.fData.cl = this.rootClass.copyObj(this.fData[this.fMode]);
            this.fData.clc = [];
            _local3 = 0;
            while (_local3 < this.fData.cl.length)
            {
                if (((this.fData.cl[_local3] == "Add Friend") && (this.rootClass.world.myAvatar.isFriend(this.fData.params.ID))))
                {
                    this.fData.cl.splice(_local3, 1);
                    _local3--;
                };
                if (((this.fData.cl[_local3] == "Delete Friend") && (!(this.rootClass.world.myAvatar.isFriend(this.fData.params.ID)))))
                {
                    this.fData.cl.splice(_local3, 1);
                    _local3--;
                };
                if (((this.fData.cl[_local3] == "Divorce") && (!(this.rootClass.world.myAvatar.isMarry()))))
                {
                    this.fData.cl.splice(_local3, 1);
                    _local3--;
                };
                _local3++;
            };
            _local3 = 0;
            while (_local3 < this.fData.cl.length)
            {
                if (((this.fData.cl[_local3] == "Ignore") && (this.rootClass.chatF.isIgnored(_local5))))
                {
                    this.fData.cl[_local3] = "Unignore";
                };
                _local8 = this.mc.cnt.addChild(new cProto());
                _local8.name = ("i" + _local3);
                _local8.y = (this.mc.cnt.iproto.y + (_local3 * 24));
                iCT = _local8.transform.colorTransform;
                _local9 = true;
                switch (this.fData.cl[_local3].toLowerCase())
                {
                    case "add friend":
                        if (((((!(this.rootClass.world.getAvatarByUserName(_local5) == null)) && (!(this.rootClass.world.getAvatarByUserName(_local5).objData == null))) && (this.rootClass.world.getAvatarByUserName(_local5).isStaff())) && (!(this.rootClass.world.myAvatar.isStaff()))))
                        {
                            _local9 = false;
                        };
                        break;
                    case "go to":
                        if (!((this.rootClass.world.partyController.isPartyMember(_local5)) || (this.rootClass.world.myAvatar.isFriend(this.fData.params.ID))))
                        {
                            _local9 = false;
                        };
                        break;
                    case "ignore":
                    case "unignore":
                        if (_local5 == this.rootClass.network.myUserName)
                        {
                            _local9 = false;
                        };
                        break;
                    case "invite":
                        if ((((((((_local5 == this.rootClass.network.myUserName) || (_local6 == null)) || ((((!(this.rootClass.world.getAvatarByUserName(_local5) == null)) && (!(this.rootClass.world.getAvatarByUserName(_local5).objData == null))) && (this.rootClass.world.getAvatarByUserName(_local5).isStaff())) && (!(this.rootClass.world.myAvatar.isStaff())))) || (this.rootClass.world.partyController.partyMembers.length > 4)) || (this.rootClass.world.partyController.isPartyMember(this.fData.params.strUsername))) || ((this.rootClass.world.bPvP) && (!(_local6.pvpTeam == this.rootClass.world.myAvatar.dataLeaf.pvpTeam)))) || ((this.rootClass.world.partyController.partyMembers.length > 0) && (!(this.rootClass.world.partyController.partyOwner.toLowerCase() == this.rootClass.network.myUserName)))))
                        {
                            _local9 = false;
                        };
                        break;
                    case "leave party":
                        if (this.rootClass.world.partyController.partyMembers.length == 0)
                        {
                            _local9 = false;
                        };
                        break;
                    case "remove":
                        if (this.rootClass.world.partyController.partyOwner.toLowerCase() != this.rootClass.network.myUserName)
                        {
                            this.fData.cl[_local3] = "Leave Party";
                        };
                        break;
                    case "private: on":
                    case "private: off":
                    case "promote":
                        if (this.rootClass.world.partyController.partyOwner != this.rootClass.world.myAvatar.objData.strUsername)
                        {
                            _local9 = false;
                        };
                        break;
                };
                if (_local9)
                {
                    iCT.color = 0x999999;
                    _local8.addEventListener(MouseEvent.CLICK, this.itemClick, false, 0, true);
                    _local8.buttonMode = true;
                }
                else
                {
                    iCT.color = 0x666666;
                };
                _local8.addEventListener(MouseEvent.MOUSE_OVER, this.itemMouseOver, false, 0, true);
                this.fData.clc.push(iCT.color);
                _local8.ti.text = this.fData.cl[_local3];
                if (_local8.ti.textWidth > _local4)
                {
                    _local4 = _local8.ti.textWidth;
                };
                _local8.transform.colorTransform = iCT;
                _local8.ti.width = (_local8.ti.textWidth + 5);
                _local8.hit.width = ((_local8.ti.x + _local8.ti.textWidth) + 2);
                _local3++;
            };
            this.mc.cnt.bg.height = (this.mc.cnt.getChildByName(String(("i" + (this.fData.cl.length - 1)))).y + 26);
            this.mc.cnt.bg.width = (_local4 + 20);
            this.mc.x = (MovieClip(parent).mouseX - 5);
            this.mc.y = (MovieClip(parent).mouseY - 5);
            if ((this.mc.x + this.mc.cnt.bg.width) > 960)
            {
                this.mc.x = (MovieClip(parent).mouseX - this.mc.cnt.bg.width);
            };
            if ((this.mc.y + this.mc.cnt.bg.height) > 500)
            {
                this.mc.y = (500 - this.mc.cnt.bg.height);
            };
            this.mc.gotoAndPlay("in");
        }

        public function fClose():void
        {
            if (this.mc.currentFrame != 1)
            {
                if (this.mc.currentFrame == 10)
                {
                    this.mc.gotoAndPlay("out");
                }
                else
                {
                    this.mc.gotoAndStop("hold");
                };
            };
        }

        private function frame1():void
        {
            visible = false;
            stop();
        }

        private function frame5():void
        {
            visible = true;
        }

        private function frame10():void
        {
            stop();
        }

        private function leaveGuild(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.network.send("guild", ["guildLeave"]);
            };
        }

        private function deleteRank(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.ui.mcPopup.GuildRewrite.deleteRank(obj.name);
            };
        }

        private function itemMouseOver(_arg1:MouseEvent):void
        {
            var _local4:*;
            var _local3:int;
            var iCT:ColorTransform;
            var _local2:* = MovieClip(_arg1.currentTarget);
            var iHi:Number = int(_local2.name.substr(1));
            _local3 = 0;
            while (_local3 < this.fData.cl.length)
            {
                _local4 = this.mc.cnt.getChildByName(("i" + _local3));
                iCT = _local4.transform.colorTransform;
                if (_local3 == iHi)
                {
                    if (_local2.hasEventListener(MouseEvent.CLICK))
                    {
                        iCT.color = 0xFFFFFF;
                        this.cnt.mHi.visible = true;
                        this.cnt.mHi.y = (_local4.y + 3);
                    }
                    else
                    {
                        this.cnt.mHi.visible = false;
                    };
                }
                else
                {
                    iCT.color = this.fData.clc[_local3];
                };
                _local4.transform.colorTransform = iCT;
                _local3++;
            };
        }

        private function itemClick(_arg1:MouseEvent):void
        {
            var _local3:String;
            var _local2:MovieClip = MovieClip(_arg1.currentTarget);
            var iSel:Number = int(_local2.name.substr(1));
            var iCT:ColorTransform = this.mc.cnt.mHi.transform.colorTransform;
            iCT.color = 16763955;
            this.mc.cnt.mHi.transform.colorTransform = iCT;
            this.fClose();
            _local3 = this.fData.cl[iSel];
            var strUsername:String = this.fData.params.strUsername;
            switch (_local3.toLowerCase())
            {
                case "char page":
                    this.rootClass.toggleCharPage(strUsername);
                    return;
                case "relationship":
                    this.rootClass.toggleCouplePanel(strUsername);
                    return;
                case "is staff?":
                    this.rootClass.world.isModerator(strUsername);
                    return;
                case "reputation":
                    this.rootClass.showFactionInterface();
                    return;
                case "whisper":
                    this.rootClass.chatF.openPMsg(strUsername);
                    return;
                case "ignore":
                    this.rootClass.chatF.ignore(strUsername);
                    this.rootClass.chatF.pushMsg("server", (("You are now ignoring user " + strUsername) + "."), "SERVER", "", 0);
                    return;
                case "unignore":
                    this.rootClass.chatF.unignore(strUsername);
                    this.rootClass.chatF.pushMsg("server", (("User " + strUsername) + " is no longer being ignored."), "SERVER", "", 0);
                    return;
                case "report":
                    this.rootClass.ui.mcPopup.fOpen("Report", {"unm":strUsername});
                    return;
                case "close":
                    if ((((((this.fMode == "user") || (this.fMode == "party")) || (this.fMode == "npc")) || (this.fMode == "self")) || (this.fMode == "monster")))
                    {
                        this.rootClass.world.cancelTarget();
                    };
                    return;
                case "add friend":
                    if (this.rootClass.world.myAvatar.friends.length >= 100)
                    {
                        this.rootClass.chatF.pushMsg("server", "You are too popular! (100 friends max)", "SERVER", "", 0);
                    }
                    else
                    {
                        this.rootClass.world.requestFriend(strUsername);
                    };
                    return;
                case "duel":
                    this.rootClass.world.sendDuelInvite(strUsername);
                    break;
                case "marry":
                    Config.menuMarry();
                    break;
                case "trade":
                    this.rootClass.world.sendTradeInvite(strUsername);
                    break;
                case "vending":
                    this.rootClass.toggleAuction(strUsername);
                    break;
                case "divorce":
                    MainController.modal("Do you want to Divorce?", this.rootClass.world.divorceMarry, {}, "red,medium", "dual");
                    return;
                case "delete friend":
                    this.rootClass.world.deleteFriend(this.fData.params.ID, strUsername);
                    return;
                case "delete rank":
                    MainController.modal((("Are you sure of deleting this rank " + this.fData.params.name) + "?"), this.deleteRank, {"name":this.fData.params.name}, "red,medium", "dual");
                    return;
                case "go to":
                    this.rootClass.world._SafeStr_1(strUsername);
                    return;
                case "invite":
                    this.rootClass.world.partyController.partyInvite(strUsername);
                    return;
                case "remove":
                    this.rootClass.world.partyController.partyKick(strUsername);
                    return;
                case "leave party":
                    this.rootClass.world.partyController.partyLeave();
                    return;
                case "private: on":
                case "private: off":
                    this.rootClass.world.partyController.partyUpdate(String(((_local3.toLowerCase().split(": ")[1] == "on") ? 1 : 0)));
                    return;
                case "promote":
                    this.rootClass.world.partyController.partyPromote(strUsername);
                    return;
                case "promote member":
                    this.rootClass.world.partyController.partyPromote(strUsername);
                    return;
                case "leave guild":
                    MainController.modal("Do you want to leave the guild?", this.leaveGuild, {}, "red,medium", "dual");
                    return;
                case "summon":
                    this.rootClass.world.partyController.partySummon(strUsername);
                    return;
                case "information":
                    if (this.fData.params.MonID == null)
                    {
                        navigateToURL(new URLRequest((Config.serverWikiNpcURL + this.fData.params.NpcID)), "_blank");
                    }
                    else
                    {
                        navigateToURL(new URLRequest((Config.serverWikiMonsterURL + this.fData.params.MonID)), "_blank");
                    };
                    break;
                case "leave queue":
                    this.rootClass.world.requestPVPQueue("none");
                    return;
            };
        }


    }
}//package 

// _SafeStr_1 = "goto" (String#9324)


