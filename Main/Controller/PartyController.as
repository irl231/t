// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.PartyController

package Main.Controller
{
    import Main.Party.PartyPortrait;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.Party.*;
    import Main.*;

    public class PartyController 
    {

        public var partyMembers:Array = [];
        private var partyTree:Object = {};
        public var partyOwner:String = "";
        private var partyID:int = -1;


        public function loadParty(data:Object):void
        {
            var member:Object;
            var i:int;
            this.partyMembers = [];
            this.partyTree = {};
            this.partyOwner = data.leader;
            this.partyID = data.id;
            Game.root.chatF.chn.party.act = 1;
            for each (member in data.members)
            {
                i = 0;
                while (i < data.branch.length)
                {
                    if (((data.branch[i].strUsername == member.strUsername) && (!(member.sServer == "Offline"))))
                    {
                        this.partyTree[member.strUsername.toLowerCase()] = data.branch[i];
                    };
                    i++;
                };
                this.addPartyMember(member.strUsername);
            };
            if (Game.root.ui.mcPopup.currentLabel == "PartyPanel")
            {
                PartyPanel(Game.root.ui.mcPopup.mcPartyPanel).setupParty();
            };
        }

        public function updatePartyFrame(partyData:Object=null):void
        {
            var i:int;
            var partyMembersList:Array;
            var partyPanelList:Array;
            var partyPanel:PartyPortrait;
            var partyMemberName:String;
            var username:String;
            var partyPanel2:PartyPortrait;
            var partyTreeData:Object;
            var hpDisplay:String;
            var hp:String;
            var mpDisplay:String;
            var mp:String;
            var vitalityPoints:Number = 0;
            var maxVitalityPoints:Number = 0;
            var rangeVisible:Boolean = true;
            var rangeUnavailable:Boolean;
            if ((((!(partyData == null)) && (!(partyData.range == null))) && (!(partyData.range))))
            {
                rangeVisible = false;
            };
            if (partyData == null)
            {
                rangeUnavailable = true;
                partyMembersList = this.partyMembers;
            }
            else
            {
                partyMembersList = [partyData.unm];
            };
            if (partyMembersList.length > 0)
            {
                if (partyData == null)
                {
                    partyPanelList = [];
                    i = 0;
                    while (i < Game.root.ui.mcPartyFrame.numChildren)
                    {
                        partyPanelList.push(PartyPortrait(Game.root.ui.mcPartyFrame.getChildAt(i)));
                        i++;
                    };
                    i = 0;
                    while (i < partyPanelList.length)
                    {
                        partyPanel = partyPanelList[i];
                        partyMemberName = partyPanel.strName.text;
                        if (this.partyMembers.indexOf(partyMemberName) == -1)
                        {
                            partyPanel.removeEventListener(MouseEvent.CLICK, this.onPartyPanelClick);
                            Game.root.ui.mcPartyFrame.removeChild(partyPanel);
                        };
                        i++;
                    };
                };
                partyMembersList = Game.excludeLeader(Game.root.world.myAvatar.objData.party.members, Game.root.world.myAvatar.objData.strUsername);
                i = 0;
                while (i < partyMembersList.length)
                {
                    username = partyMembersList[i].strUsername;
                    partyPanel2 = this.getPartyPanelByName(username);
                    partyTreeData = this.partyTree[username.toLowerCase()];
                    if (((partyTreeData == null) || (partyTreeData.strServer == "Offline")))
                    {
                        partyPanel2.txtRange.visible = true;
                        partyPanel2.HP.visible = false;
                        partyPanel2.MP.visible = false;
                    }
                    else
                    {
                        if (rangeVisible)
                        {
                            vitalityPoints = partyTreeData.intHP;
                            maxVitalityPoints = partyTreeData.intHPMax;
                            hpDisplay = vitalityPoints;
                            if (Game.root.userPreference.data.combatShowCommaHPDisplay)
                            {
                                hpDisplay = MainController.formatNumber(vitalityPoints);
                            };
                            hp = ((vitalityPoints >= 0) ? hpDisplay : "X");
                            partyPanel2.HP.strIntHP.text = hp;
                            partyPanel2.HP.strIntHPs.text = hp;
                            if (vitalityPoints < 0)
                            {
                                vitalityPoints = 0;
                            };
                            partyPanel2.HP.intHPbar.x = -(partyPanel2.HP.intHPbar.width * (1 - (vitalityPoints / maxVitalityPoints)));
                            vitalityPoints = partyTreeData.intMP;
                            maxVitalityPoints = partyTreeData.intMPMax;
                            mpDisplay = vitalityPoints;
                            if (Game.root.userPreference.data.combatShowCommaMPDisplay)
                            {
                                mpDisplay = MainController.formatNumber(vitalityPoints);
                            };
                            mp = ((vitalityPoints >= 0) ? mpDisplay : "X");
                            partyPanel2.MP.strIntMP.text = mp;
                            partyPanel2.MP.strIntMPs.text = mp;
                            if (vitalityPoints < 0)
                            {
                                vitalityPoints = 0;
                            };
                            partyPanel2.MP.intMPbar.x = -(partyPanel2.MP.intMPbar.width * (1 - (vitalityPoints / maxVitalityPoints)));
                            partyPanel2.HP.visible = true;
                            partyPanel2.MP.visible = true;
                            partyPanel2.txtRange.visible = false;
                        }
                        else
                        {
                            partyPanel2.HP.visible = false;
                            partyPanel2.MP.visible = false;
                            partyPanel2.txtRange.visible = true;
                        };
                    };
                    if (rangeUnavailable)
                    {
                        partyPanel2.y = (33.85 * i);
                    };
                    partyPanel2.partyLead.visible = (username.toLowerCase() == this.partyOwner.toLowerCase());
                    i++;
                };
            }
            else
            {
                i = 0;
                while (((Game.root.ui.mcPartyFrame.numChildren > 0) && (i < 10)))
                {
                    PartyPortrait(Game.root.ui.mcPartyFrame.getChildAt(0)).removeEventListener(MouseEvent.CLICK, this.onPartyPanelClick);
                    Game.root.ui.mcPartyFrame.removeChildAt(0);
                    i++;
                };
            };
            Game.root.ui.mcPortrait.partyLead.visible = (this.partyOwner.toLowerCase() == Game.root.network.myUserName);
        }

        public function onPartyPanelClick(mouseEvent:MouseEvent):void
        {
            var partyPortrait:PartyPortrait;
            var avatar:Avatar;
            partyPortrait = PartyPortrait(mouseEvent.currentTarget);
            var data:Object = {"strUsername":partyPortrait.strName.text};
            if (mouseEvent.shiftKey)
            {
                avatar = Game.root.world.getAvatarByUserName(data.strUsername.toLowerCase());
                if (((((!(avatar == null)) && (!(avatar.pMC == null))) && (!(avatar.dataLeaf == null))) && (avatar.dataLeaf.strFrame == Game.root.world.myAvatar.dataLeaf.strFrame)))
                {
                    Game.root.world.setTarget(avatar);
                };
            }
            else
            {
                cMenuMC(Game.root.ui.cMenu).fOpenWith("party", data);
            };
        }

        public function addPartyMember(_arg1:String):void
        {
            this.partyMembers.push(_arg1);
            this.updatePartyFrame();
        }

        public function removePartyMember(_arg1:String):void
        {
            var _local2:*;
            if (_arg1 != Game.root.network.myUserName)
            {
                _local2 = this.partyMembers.indexOf(_arg1);
                if (_local2 > -1)
                {
                    this.partyMembers.splice(_local2, 1);
                };
            }
            else
            {
                this.partyID = -1;
                this.partyOwner = "";
                this.partyMembers = [];
            };
            this.updatePartyFrame();
        }

        public function createPartyPanel(_arg1:Object):PartyPortrait
        {
            var partyPortrait:PartyPortrait = PartyPortrait(Game.root.ui.mcPartyFrame.addChild(new PartyPortrait()));
            partyPortrait.strName.text = _arg1.unm;
            partyPortrait.HP.visible = false;
            partyPortrait.MP.visible = false;
            partyPortrait.txtRange.visible = false;
            partyPortrait.addEventListener(MouseEvent.CLICK, this.onPartyPanelClick, false, 0, true);
            partyPortrait.buttonMode = true;
            return (partyPortrait);
        }

        public function getPartyPanelByName(username:String):PartyPortrait
        {
            var partyPortrait:PartyPortrait;
            var partyFramesNumChildren:int = Game.root.ui.mcPartyFrame.numChildren;
            var i:int;
            while (i < partyFramesNumChildren)
            {
                partyPortrait = PartyPortrait(Game.root.ui.mcPartyFrame.getChildAt(i));
                if (partyPortrait.strName.text == username)
                {
                    return (partyPortrait);
                };
                i++;
            };
            return (this.createPartyPanel({"unm":username}));
        }

        public function partyInvite(_arg1:String):void
        {
            Game.root.network.send("gp", ["pi", _arg1]);
        }

        public function partyKick(_arg1:String):void
        {
            Game.root.network.send("gp", ["pk", _arg1]);
        }

        public function partyLeave():void
        {
            Game.root.network.send("gp", ["pl"]);
        }

        public function partySummon(_arg1:String):void
        {
            Game.root.network.send("gp", ["ps", _arg1]);
        }

        public function acceptPartySummon(data:Object):void
        {
            if (data.accept)
            {
                Game.root.network.send("gp", ["psa"]);
                if (data.strF == null)
                {
                    Game.root.network.send("cmd", ["goto", data.unm]);
                }
                else
                {
                    Game.root.world.moveToCell(data.strF, data.strP);
                };
            }
            else
            {
                Game.root.network.send("gp", ["psd", data.unm]);
            };
        }

        public function partyPromote(_arg1:String):void
        {
            Game.root.network.send("gp", ["pp", _arg1]);
        }

        public function partyRename(_arg1:String):void
        {
            Game.root.network.send("gp", ["pr", _arg1]);
        }

        public function partyUpdate(_arg1:*):void
        {
            Game.root.network.send("gp", ["pu", _arg1]);
        }

        public function isPartyMember(username:String):Boolean
        {
            var i:int;
            username = username.toLowerCase();
            if (username != Game.root.network.myUserName)
            {
                i = 0;
                while (i < this.partyMembers.length)
                {
                    if (this.partyMembers[i].toLowerCase() == username)
                    {
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }

        public function doPartyAccept(data:Object):void
        {
            if (data.accept)
            {
                Game.root.network.send("gp", ["pa", data.pid]);
                return;
            };
            Game.root.network.send("gp", ["pd", data.pid]);
        }


    }
}//package Main.Controller

