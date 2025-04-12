// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildPanelRewrite

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.display.Loader;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.net.URLRequest;
    import flash.events.MouseEvent;
    import fl.motion.Color;
    import flash.display.DisplayObject;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import fl.motion.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;
    import Plugins.ConfigurableNPC.*;

    public class GuildPanelRewrite extends MovieClip 
    {

        public var mcTechPreloader:MovieClip;
        public var btnGuildTech1:MovieClip;
        public var btnGuildTech2:MovieClip;
        public var btnGuildTech3:MovieClip;
        public var txtTitle:TextField;
        public var txtTitle2:TextField;
        public var txtGuildName:TextField;
        public var txtGuildLevel:TextField;
        public var txtTechTitle:TextField;
        public var txtTechDescription:TextField;
        public var txtDescription:TextField;
        public var txtRankName:TextField;
        public var txtGuildRename:TextField;
        public var txtGuildMOTD:TextField;
        public var txtGuildMOTDButton:TextField;
        public var txtGuildDescription:TextField;
        public var txtGuildDescriptionButton:TextField;
        public var guildData:Object;
        public var btnClose:SimpleButton;
        public var btnCreateRank:SimpleButton;
        public var btnKickOut:SimpleButton;
        public var btnSetRank:SimpleButton;
        public var btnSetGuildName:SimpleButton;
        public var btnGuildMOTDEdit:SimpleButton;
        public var btnGuildDescriptionEdit:SimpleButton;
        public var btnLeaveGuild:SimpleButton;
        public var btnDeleteGuild:SimpleButton;
        public var btnGuildSlots:SimpleButton;
        public var maskMember:MovieClip;
        public var maskRank:MovieClip;
        public var maskRecruitment:MovieClip;
        public var maskAlliance:MovieClip;
        public var maskPendingAlliance:MovieClip;
        public var maskTech:MovieClip;
        public var maskLog:MovieClip;
        public var listMember:MovieClip;
        public var listTechLevels:MovieClip;
        public var listRecruitment:MovieClip;
        public var listAlliance:MovieClip;
        public var listPendingAlliance:MovieClip;
        public var listRank:MovieClip;
        public var listTech:MovieClip;
        public var listLog:MovieClip;
        public var mcPortrait:MovieClip;
        public var imageLoader:Loader = new Loader();
        public var rootClass:Game = Game.root;
        public var scrollMember:LPFElementScrollBar;
        public var scrollRecruitment:LPFElementScrollBar;
        public var scrollAlliance:LPFElementScrollBar;
        public var scrollPendingAlliance:LPFElementScrollBar;
        public var scrollRank:LPFElementScrollBar;
        public var scrollTech:LPFElementScrollBar;
        public var scrollLog:LPFElementScrollBar;
        public var chkPermissionGuildWar:MovieClip;
        public var chkPermissionGuildFinances:MovieClip;
        public var chkPermissionGuildInvite:MovieClip;
        public var chkPermissionGuildAccept:MovieClip;
        public var chkPermissionGuildRemove:MovieClip;
        public var chkPermissionGuildPromote:MovieClip;
        public var chkPermissionGuildRaid:MovieClip;
        public var rankData:Array = [];
        public var logData:Array = [];
        public var recruitmentData:Array = [];
        public var allianceData:Array = [];
        public var pendingAllianceData:Array = [];
        public var selectedUser:Array = [];
        public var selectedRank:MovieClip = null;
        public var mcKillDeath:MovieClip;
        public var mcGuildWar:MovieClip;
        public var mcGuildRaid:MovieClip;
        public var mcPreloader:MovieClip;
        public var guildExpBar:MovieClip;
        public var btnBack:SimpleButton;
        public var listMenu:Array = [{
            "Name":"Members",
            "Frame":"Members"
        }, {
            "Name":"Ranks",
            "Frame":"Ranks"
        }, {
            "Name":"Management",
            "Frame":"Management"
        }, {
            "Name":"Operations",
            "Frame":"Operations"
        }, {
            "Name":"Recruitments",
            "Frame":"Recruitments"
        }, {
            "Name":"Alliances",
            "Frame":"Alliances"
        }];
        public var arrStatus:Array = ["Close", "Open", "Request"];
        public var txtAllianceName:TextField;
        public var txtPlayerName:TextField;
        public var btnInvitePlayer:SimpleButton;
        public var btnDeclareAlliance:SimpleButton;
        public var txtGuildStatus:TextField;
        public var btnUpdateStatus:SimpleButton;
        public var btnStatusLeft:SimpleButton;
        public var btnStatusRight:SimpleButton;
        public var statusId:uint;

        public function GuildPanelRewrite()
        {
            addFrameScript(0, this.Statistics, 1, this.Members, 2, this.Ranks, 3, this.Management, 4, this.Operations, 5, this.Recruitments, 6, this.Alliances, 7, this.Warehouse, 8, this.Tech);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnBack.addEventListener(MouseEvent.CLICK, this.onClick);
            this.refreshData();
            this.loadGuildImage();
            this.loadGuildMenu();
        }

        public function refreshData():void
        {
            var first:int;
            var second:int;
            var third:int;
            this.guildData = this.rootClass.world.myAvatar.objData.guild;
            this.rankData = this.guildData.ranks;
            this.logData = this.guildData.logs;
            this.recruitmentData = this.guildData.invites;
            this.allianceData = this.guildData.alliances;
            this.pendingAllianceData = this.guildData.pendingAlliances;
            this.statusId = this.guildData.Status;
            this.txtTitle.text = "Guild";
            this.txtTitle2.text = currentLabel;
            this.txtGuildName.text = this.guildData.Name;
            this.txtDescription.text = ((this.guildData.Description == "") ? this.guildData.MOTD : this.guildData.Description);
            this.btnBack.visible = (!(currentLabel == "Statistics"));
            this.btnBack.x = ((this.txtTitle2.x + this.txtTitle2.textWidth) + 10);
            if (this.guildData == null)
            {
                this.rootClass.MsgBox.notify("Guild Data is not set.");
                return;
            };
            switch (currentLabel)
            {
                case "Statistics":
                    first = this.guildData.Kill;
                    second = this.guildData.Death;
                    third = ((first * second) % (first + second));
                    this.mcKillDeath.tTitle1.text = "Kill Death Records";
                    this.mcKillDeath.tTitle2.text = ("Kills: " + first);
                    this.mcKillDeath.tTitle3.text = ("Deaths: " + second);
                    this.mcKillDeath.tTitle4.text = ((isNaN(third)) ? "0%" : (third + "%"));
                    first = this.guildData.Wins;
                    second = this.guildData.Loss;
                    third = ((first * second) % (first + second));
                    this.mcGuildWar.tTitle1.text = "Guild War Records";
                    this.mcGuildWar.tTitle2.text = ("Wins: " + first);
                    this.mcGuildWar.tTitle3.text = ("Loses: " + second);
                    this.mcGuildWar.tTitle4.text = ((isNaN(third)) ? "0%" : (third + "%"));
                    first = this.guildData.RaidWins;
                    second = this.guildData.RaidLoss;
                    third = ((first * second) % (first + second));
                    this.mcGuildRaid.tTitle1.text = "Guild Raid Records";
                    this.mcGuildRaid.tTitle2.text = ("Wins: " + first);
                    this.mcGuildRaid.tTitle3.text = ("Loses: " + second);
                    this.mcGuildRaid.tTitle4.text = ((isNaN(third)) ? "0%" : (third + "%"));
                    this.txtGuildLevel.text = ("Guild Level " + this.guildData.Level);
                    this.buildExpBar();
                    break;
                case "Members":
                    this.buildGuildMemberList();
                    break;
                case "Ranks":
                    this.buildGuildRankList();
                    break;
                case "Management":
                    this.buildGuildMemberList();
                    this.buildGuildRankList();
                    this.selectedUser = [];
                    this.selectedRank = null;
                    break;
                case "Operations":
                    this.buildGuildLogList();
                    this.txtGuildMOTD.htmlText = this.guildData.MOTD;
                    this.txtGuildDescription.htmlText = this.guildData.Description;
                    break;
                case "Recruitments":
                    this.buildGuildRecruitmentList();
                    this.txtGuildStatus.text = this.getStatusText(this.guildData.Status);
                    break;
                case "Alliances":
                    this.buildGuildAllianceList();
                    this.buildGuildPendingAllianceList();
                    break;
                case "Warehouse":
                    this.rootClass.MsgBox.notify("Coming soon.");
                    break;
                case "Tech":
                    break;
            };
        }

        public function deleteRank(rankName:String):void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id != 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Only the Owner can delete a rank.", "SERVER", "", 0);
                return;
            };
            var rankId:int = this.getPlayerRankId(rankName);
            if (rankName.length > 0)
            {
                this.rootClass.network.send("guild", ["deleteGuildRank", rankId]);
            }
            else
            {
                this.rootClass.chatF.pushMsg("warning", "Type a valid name for the rank.", "SERVER", "", 0);
            };
        }

        private function Statistics():void
        {
            this.btnGuildTech1.buttonMode = true;
            this.btnGuildTech2.buttonMode = true;
            this.btnGuildTech3.buttonMode = true;
            this.btnGuildTech1.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildTech2.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildTech3.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildTech1.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this.btnGuildTech2.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this.btnGuildTech3.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
            this.btnGuildTech1.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            this.btnGuildTech2.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            this.btnGuildTech3.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
            this.refreshData();
            stop();
        }

        private function Members():void
        {
            this.refreshData();
            stop();
        }

        private function Ranks():void
        {
            this.btnCreateRank.addEventListener(MouseEvent.CLICK, this.onClick);
            this.refreshData();
            stop();
        }

        private function Management():void
        {
            this.btnSetRank.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnKickOut.addEventListener(MouseEvent.CLICK, this.onClick);
            this.refreshData();
            stop();
        }

        private function Operations():void
        {
            this.btnSetGuildName.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildMOTDEdit.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildDescriptionEdit.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnLeaveGuild.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnDeleteGuild.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildSlots.addEventListener(MouseEvent.CLICK, this.onClick);
            this.txtGuildMOTD.mouseEnabled = false;
            this.txtGuildMOTDButton.mouseEnabled = false;
            this.txtGuildDescription.mouseEnabled = false;
            this.txtGuildDescriptionButton.mouseEnabled = false;
            this.refreshData();
            stop();
        }

        private function Recruitments():void
        {
            this.btnInvitePlayer.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnStatusLeft.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnStatusRight.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnUpdateStatus.addEventListener(MouseEvent.CLICK, this.onClick);
            this.refreshData();
            stop();
        }

        private function Alliances():void
        {
            this.btnDeclareAlliance.addEventListener(MouseEvent.CLICK, this.onClick);
            this.refreshData();
            stop();
        }

        private function Warehouse():void
        {
            this.refreshData();
            stop();
        }

        private function Tech():void
        {
            this.maskTech.alpha = 0;
            this.scrollTech.visible = false;
            this.mcTechPreloader.mcPct.text = "Loading";
            this.refreshData();
            stop();
        }

        private function loadGuildMenu():void
        {
            var Menu:Object;
            var mcMenu:MovieClip;
            var defaultX:int = 342.25;
            var menuCounter:int;
            for each (Menu in this.listMenu)
            {
                mcMenu = MovieClip(addChildAt(new mcGuildMenu(), 0));
                mcMenu.txtTitle.text = Menu.Name;
                mcMenu.txtTitle.mouseEnabled = false;
                mcMenu.addEventListener(MouseEvent.CLICK, this.onClick);
                mcMenu.name = "btnMenu";
                mcMenu.title = Menu.Name;
                mcMenu.frame = Menu.Frame;
                mcMenu.x = (defaultX + (menuCounter * mcMenu.width));
                mcMenu.y = 20;
                menuCounter++;
            };
        }

        private function loadGuildImage():void
        {
            var request:URLRequest = new URLRequest(this.rootClass.getGuildLoadPath(this.guildData.id));
            this.imageLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, function (event:*):void
            {
                var percent:int = int(Math.floor(((event.bytesLoaded / event.bytesTotal) * 100)));
                mcPreloader.mcPct.text = (percent + "%");
            });
            this.imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:*):void
            {
                mcPreloader.visible = false;
                mcPortrait.icon.addChild(imageLoader);
                mcPortrait.icon.height = 120;
                mcPortrait.icon.width = 190;
            });
            this.imageLoader.load(request);
        }

        private function toggleGuildSlot():void
        {
            if (this.guildData.MaxMembers == 200)
            {
                this.rootClass.chatF.pushMsg("server", "Congratulations, your guild has the maximum member slots!", "SERVER", "", 0);
                return;
            };
            UIController.show("guild_slot");
        }

        private function leaveGuildPop(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.network.send("guild", ["guildLeave"]);
                this.rootClass.ui.mcPopup.onClose();
            };
        }

        private function leaveGuild():void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id == 1)
            {
                this.rootClass.chatF.pushMsg("warning", "You are not allowed to leave the guild, use guild delete instead.", "SERVER", "", 0);
                return;
            };
            MainController.modal("Do you really want to leave the guild?", this.leaveGuildPop, {}, "red,medium", "dual");
        }

        private function deleteGuildPop(obj:Object):void
        {
            if (obj.accept)
            {
                this.rootClass.network.send("guild", ["deleteGuild"]);
                this.rootClass.ui.mcPopup.onClose();
            };
        }

        private function deleteGuild():void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id != 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Only the Owner can create a new rank.", "SERVER", "", 0);
                return;
            };
            MainController.modal("Do you really want to delete the guild?", this.deleteGuildPop, {}, "red,medium", "dual");
        }

        private function editDescription():void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id != 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Only the Owner can create a new rank.", "SERVER", "", 0);
                return;
            };
            if (this.txtGuildDescriptionButton.text == "Edit")
            {
                this.txtGuildDescriptionButton.text = "Save";
                this.txtGuildDescription.mouseEnabled = true;
            }
            else
            {
                this.txtGuildDescriptionButton.text = "Edit";
                this.txtGuildDescription.mouseEnabled = false;
                if (this.txtGuildDescription.text == this.guildData.Description)
                {
                    return;
                };
                this.rootClass.world.setGuildDescription(this.txtGuildDescription.text);
            };
        }

        private function editMOTD():void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id != 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Only the Owner can create a new rank.", "SERVER", "", 0);
                return;
            };
            if (this.txtGuildMOTDButton.text == "Edit")
            {
                this.txtGuildMOTDButton.text = "Save";
                this.txtGuildMOTD.mouseEnabled = true;
            }
            else
            {
                this.txtGuildMOTDButton.text = "Edit";
                this.txtGuildMOTD.mouseEnabled = false;
                if (this.txtGuildMOTD.text == this.guildData.MOTD)
                {
                    return;
                };
                this.rootClass.world.setGuildMOTD(this.txtGuildMOTD.text);
            };
        }

        private function declareAlliance():void
        {
            var name:String = this.txtAllianceName.text;
            if (name.length < 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Please specify a guild name.", "SERVER", "", 0);
                return;
            };
            if (!this.rootClass.world.myAvatar.objData.guildRank.InvitePlayers)
            {
                this.rootClass.chatF.pushMsg("warning", "You do not have the permission to declare alliance to the guild.", "SERVER", "", 0);
                return;
            };
            this.rootClass.world.declareAlliance(name);
        }

        private function invitePlayer():void
        {
            var name:String = this.txtPlayerName.text;
            if (name.length < 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Please specify a player name.", "SERVER", "", 0);
                return;
            };
            if (!this.rootClass.world.myAvatar.objData.guildRank.InvitePlayers)
            {
                this.rootClass.chatF.pushMsg("warning", "You do not have the permission to invite players to the guild.", "SERVER", "", 0);
                return;
            };
            this.rootClass.world.guildInvite(name);
        }

        private function renameGuild():void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id != 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Only the Owner can create a new rank.", "SERVER", "", 0);
                return;
            };
            var name:String = this.txtGuildRename.text;
            if (name.length < 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Please specify a name for your guild.", "SERVER", "", 0);
                return;
            };
            if (name.length > 25)
            {
                this.rootClass.chatF.pushMsg("warning", "Guild names must be 25 characters or less.", "SERVER", "", 0);
                return;
            };
            if (this.rootClass.world.myAvatar.objData.intCoins < Config.getInt("guild_rename_cost"))
            {
                this.rootClass.chatF.pushMsg("warning", (((((("You do not have enough " + Config.getString("coins_name")) + ", Guild rename cost ") + Config.getInt("guild_rename_cost")) + " ") + Config.getString("coins_name_short")) + "."), "SERVER", "", 0);
                return;
            };
            MainController.modal((((((("Do you want to rename the guild to " + name) + "? This will cost ") + Config.getInt("guild_rename_cost")) + " ") + Config.getString("coins_name_short")) + "."), this.rootClass.world.renameGuild, {"guildName":name}, "red,medium", "dual");
        }

        private function buildGuildRecruitmentList():void
        {
            var user:Object;
            var element:GuildElementRecruitment;
            this.rootClass.onRemoveChildrens(this.listRecruitment);
            var position:int;
            var count:int = 1;
            for each (user in this.recruitmentData)
            {
                element = new GuildElementRecruitment(user.id, user.Date, user.Username, user.Level);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementRecruitment";
                element.btnApprove.addEventListener(MouseEvent.CLICK, this.onClick);
                element.btnDecline.addEventListener(MouseEvent.CLICK, this.onClick);
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                element.bg.alpha = 0;
                position = (position + 36);
                this.listRecruitment.addChild(element);
            };
            this.configureScroll(this.listRecruitment, this.maskRecruitment, this.scrollRecruitment);
        }

        private function buildGuildAllianceList():void
        {
            var alliance:Object;
            var element:GuildElementAlliance;
            this.rootClass.onRemoveChildrens(this.listAlliance);
            var position:int;
            var count:int = 1;
            for each (alliance in this.allianceData)
            {
                element = new GuildElementAlliance(alliance.id, alliance.Date, alliance.Alliance.Name, alliance.Alliance.Level);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementAlliance";
                element.btnApprove.visible = false;
                element.btnDecline.x = (element.btnDecline.x - 10);
                element.btnDecline.addEventListener(MouseEvent.CLICK, this.onClick);
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                element.bg.alpha = 0;
                position = (position + 36);
                this.listAlliance.addChild(element);
            };
            this.configureScroll(this.listAlliance, this.maskAlliance, this.scrollAlliance);
        }

        private function buildGuildPendingAllianceList():void
        {
            var alliance:Object;
            var element:GuildElementAlliance;
            this.rootClass.onRemoveChildrens(this.listPendingAlliance);
            var position:int;
            var count:int = 1;
            for each (alliance in this.pendingAllianceData)
            {
                element = new GuildElementAlliance(alliance.id, alliance.Date, alliance.Guild.Name, alliance.Guild.Level);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementPendingAlliance";
                element.btnApprove.addEventListener(MouseEvent.CLICK, this.onClick);
                element.btnDecline.addEventListener(MouseEvent.CLICK, this.onClick);
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                element.bg.alpha = 0;
                position = (position + 36);
                this.listPendingAlliance.addChild(element);
            };
            this.configureScroll(this.listPendingAlliance, this.maskPendingAlliance, this.scrollPendingAlliance);
        }

        private function buildGuildRankList():void
        {
            var rank:Object;
            var element:GuildElementRank;
            this.rootClass.onRemoveChildrens(this.listRank);
            var position:int;
            var count:int = 1;
            for each (rank in this.rankData)
            {
                element = new GuildElementRank(count, rank.id, rank.Name);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementRank";
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                element.bg.alpha = 0;
                position = (position + 36);
                count++;
                this.listRank.addChild(element);
            };
            this.configureScroll(this.listRank, this.maskRank, this.scrollRank);
        }

        private function buildExpBar():void
        {
            var textDisplay:String;
            var total:int = int(int(((this.guildData.intExp / this.guildData.intExpToLevel) * 100)));
            var level:int = this.guildData.Level;
            this.guildExpBar.mcXP.scaleX = (this.guildData.intExp / this.guildData.intExpToLevel);
            if (((total >= 100) || (total <= 0)))
            {
                textDisplay = "100%";
            }
            else
            {
                textDisplay = (((((this.rootClass.strNumWithCommas(this.guildData.intExp) + " / ") + this.rootClass.strNumWithCommas(this.guildData.intExpToLevel)) + " (") + this.rootClass.coeffToPct((this.guildData.intExp / this.guildData.intExpToLevel))) + "%)");
            };
            this.guildExpBar.strXP.text = textDisplay;
        }

        private function buildGuildLogList():void
        {
            var log:Object;
            var element:GuildElementLog;
            this.rootClass.onRemoveChildrens(this.listLog);
            var position:int;
            for each (log in this.logData)
            {
                element = new GuildElementLog(log.Date, log.Details);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementLog";
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.bg.alpha = 0;
                position = (position + 36);
                this.listLog.addChild(element);
            };
            this.configureScroll(this.listLog, this.maskLog, this.scrollLog);
        }

        private function buildGuildMemberList():void
        {
            var member:Object;
            var element:GuildElement;
            this.rootClass.onRemoveChildrens(this.listMember);
            var position:int;
            for each (member in this.guildData.ul)
            {
                element = new GuildElement(member.ID, this.getPlayerRank(member.Rank), ((member.Server.toLowerCase() == "online") ? "<font color='#39FF35'>Online</font>" : member.Server), member.userName, member.Level);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementMember";
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                element.bg.alpha = 0;
                position = (position + 36);
                this.listMember.addChild(element);
            };
            this.configureScroll(this.listMember, this.maskMember, this.scrollMember);
        }

        private function kickMember():void
        {
            var user:Object;
            if (!this.rootClass.world.myAvatar.objData.guildRank.RemovePlayers)
            {
                this.rootClass.chatF.pushMsg("warning", "You do not have the permission to kick members from the guild.", "SERVER", "", 0);
                return;
            };
            var users:Array = ["gr"];
            var names:String = "";
            for each (user in this.selectedUser)
            {
                names = (names + (", " + user.username));
                users.push(user.username);
            };
            MainController.modal((("Would you like to kick all the members listed:<br>" + names.substr(2)) + "?"), this.rootClass.world.guildKick, users, "red,medium", "dual");
        }

        private function setRank():void
        {
            var user:Object;
            if (this.selectedRank == null)
            {
                this.rootClass.chatF.pushMsg("warning", "You must select a rank to do that.", "SERVER", "", 0);
                return;
            };
            if (this.selectedUser == null)
            {
                this.rootClass.chatF.pushMsg("warning", "You must select a member to do that.", "SERVER", "", 0);
                return;
            };
            var users:Array = ["setGuildRank", this.selectedRank.dbId];
            for each (user in this.selectedUser)
            {
                users.push(user.id);
            };
            if (this.rootClass.world.myAvatar.objData.guildRank.PromotePlayers)
            {
                this.rootClass.network.send("guild", users);
            }
            else
            {
                this.rootClass.chatF.pushMsg("warning", "You do not have the permission to do that.", "SERVER", "", 0);
            };
        }

        private function createRank():void
        {
            if (this.rootClass.world.myAvatar.objData.guildRank.id != 1)
            {
                this.rootClass.chatF.pushMsg("warning", "Only the Owner can create a new rank.", "SERVER", "", 0);
                return;
            };
            var rankName:String = this.txtRankName.text;
            var packet:Array = ["createGuildRank", rankName, this.chkPermissionGuildWar.bitChecked, this.chkPermissionGuildFinances.bitChecked, this.chkPermissionGuildInvite.bitChecked, this.chkPermissionGuildAccept.bitChecked, this.chkPermissionGuildRemove.bitChecked, this.chkPermissionGuildPromote.bitChecked, this.chkPermissionGuildRaid.bitChecked];
            if (rankName.length > 0)
            {
                this.rootClass.network.send("guild", packet);
            }
            else
            {
                this.rootClass.chatF.pushMsg("warning", "Type a valid name for the rank.", "SERVER", "", 0);
            };
        }

        private function getStatusId(sStatus:String):int
        {
            switch (sStatus)
            {
                case "Close":
                    return (0);
                case "Open":
                    return (1);
                case "Request":
                    return (2);
            };
            return (0);
        }

        private function getStatusText(statusId:int):String
        {
            switch (statusId)
            {
                case 0:
                default:
                    return ("Close");
                case 1:
                    return ("Open");
                case 2:
                    return ("Request");
            };
        }

        private function getPlayerRank(rankId:int):String
        {
            var i:int;
            switch (rankId)
            {
                case 0:
                    return ("None");
                case 1:
                    return ("Owner");
                default:
                    i = 0;
                    while (i < this.rankData.length)
                    {
                        if (this.rankData[i].id == rankId)
                        {
                            return (this.rankData[i].Name);
                        };
                        i++;
                    };
            };
            return ("");
        }

        private function getPlayerRankId(rankName:String):int
        {
            var i:int;
            while (i < this.rankData.length)
            {
                if (this.rankData[i].Name == rankName)
                {
                    return (this.rankData[i].id);
                };
                i++;
            };
            return (0);
        }

        private function configureScroll(list:MovieClip, Mask:MovieClip, scroll:MovieClip):void
        {
            list.mask = Mask;
            list.y = 102.3;
            scroll.hit.height = scroll.b.height;
            scroll.hit.alpha = 0;
            scroll.fOpen({
                "subject":list,
                "subjectMask":Mask,
                "reset":true
            });
            if (!list.hasEventListener(MouseEvent.MOUSE_WHEEL))
            {
                list.addEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel(scroll));
            };
            if (!scroll.hasEventListener(MouseEvent.MOUSE_WHEEL))
            {
                scroll.addEventListener(MouseEvent.MOUSE_WHEEL, this.onWheel(scroll));
            };
        }

        private function onWheel(scroll:MovieClip):Function
        {
            return (function (e:MouseEvent):void
            {
                var j:*;
                if (e.delta <= 0)
                {
                    j = 0;
                    while (j < (e.delta * -1))
                    {
                        MovieClip(scroll).a2.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        j++;
                    };
                    return;
                };
                var oldY:* = scroll.h.y;
                var i:* = 0;
                while (i < e.delta)
                {
                    MovieClip(scroll).a1.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    i++;
                };
                if (oldY == scroll.h.y)
                {
                    scroll.h.y = (scroll.h.y - (e.delta * 1.1));
                    if ((scroll.h.y + scroll.h.height) > scroll.b.height)
                    {
                        scroll.h.y = int((scroll.b.height - scroll.h.height));
                    };
                    if (scroll.h.y < 0)
                    {
                        scroll.h.y = 0;
                    };
                };
            });
        }

        public function onClick(event:MouseEvent):void
        {
            var panelRecruitment:MovieClip;
            var buttonRecruitment:SimpleButton;
            var panelPendingAlliance:MovieClip;
            var buttonPendingAlliance:SimpleButton;
            var panelAlliance:MovieClip;
            var techId:int;
            switch (event.currentTarget.parent.name)
            {
                case "btnGuildElementRecruitment":
                    panelRecruitment = MovieClip(event.currentTarget.parent);
                    buttonRecruitment = SimpleButton(event.currentTarget);
                    if ((buttonRecruitment.name == "btnApprove"))
                    {
                        this.rootClass.world.approveGuildRecruitment(panelRecruitment.ID);
                    }
                    else
                    {
                        this.rootClass.world.declineGuildRecruitment(panelRecruitment.ID);
                    };
                    break;
                case "btnGuildElementPendingAlliance":
                    panelPendingAlliance = MovieClip(event.currentTarget.parent);
                    buttonPendingAlliance = SimpleButton(event.currentTarget);
                    if ((buttonPendingAlliance.name == "btnApprove"))
                    {
                        this.rootClass.world.acceptGuildAlliance(panelPendingAlliance.ID);
                    }
                    else
                    {
                        this.rootClass.world.declineGuildAlliance(panelPendingAlliance.ID);
                    };
                    break;
                case "btnGuildElementAlliance":
                    panelAlliance = MovieClip(event.currentTarget.parent);
                    this.rootClass.world.disbandGuildAlliance(panelAlliance.ID);
                    break;
            };
            switch (event.currentTarget.name)
            {
                case "btnGuildTech1":
                case "btnGuildTech2":
                case "btnGuildTech3":
                    techId = parseInt(event.currentTarget.name.replace("btnGuildTech", ""));
                    gotoAndStop("Tech");
                    this.rootClass.world.loadAttriute(techId);
                    break;
                case "btnDeclareAlliance":
                    this.declareAlliance();
                    break;
                case "btnInvitePlayer":
                    this.invitePlayer();
                    break;
                case "btnStatusRight":
                case "btnStatusLeft":
                    this.statusId = ((event.currentTarget.name == "btnStatusLeft") ? ((--this.statusId < 0) ? (this.arrStatus.length - 1) : this.statusId) : ((++this.statusId > (this.arrStatus.length - 1)) ? 0 : this.statusId));
                    this.txtGuildStatus.text = this.getStatusText(this.statusId);
                    break;
                case "btnUpdateStatus":
                    if (this.getStatusId(this.txtGuildStatus.text) == this.guildData.Status)
                    {
                        this.rootClass.chatF.pushMsg("warning", (("Guild status is already set to " + this.txtGuildStatus.text) + "."), "SERVER", "", 0);
                        return;
                    };
                    this.rootClass.world.updateGuildStatus(this.getStatusId(this.txtGuildStatus.text));
                    break;
                case "btnClose":
                    this.rootClass.ui.mcPopup.onClose();
                    break;
                case "btnBack":
                    gotoAndStop("Statistics");
                    break;
                case "btnMenu":
                    this.txtTitle2.text = event.currentTarget.title;
                    gotoAndStop(event.currentTarget.frame);
                    break;
                case "btnGuildElementMember":
                    this.selectMember(event);
                    break;
                case "btnGuildElementRank":
                    this.selectRank(event);
                    break;
                case "btnCreateRank":
                    this.createRank();
                    break;
                case "btnSetRank":
                    this.setRank();
                    break;
                case "btnKickOut":
                    this.kickMember();
                    break;
                case "btnSetGuildName":
                    this.renameGuild();
                    break;
                case "btnGuildMOTDEdit":
                    this.editMOTD();
                    break;
                case "btnGuildDescriptionEdit":
                    this.editDescription();
                    break;
                case "btnLeaveGuild":
                    this.leaveGuild();
                    break;
                case "btnDeleteGuild":
                    this.deleteGuild();
                    break;
                case "btnGuildSlots":
                    this.toggleGuildSlot();
                    break;
            };
        }

        private function selectMember(event:MouseEvent):void
        {
            var target:MovieClip;
            var param:Object;
            var display:Object;
            target = MovieClip(event.currentTarget);
            switch (currentLabel)
            {
                case "Members":
                    param = {
                        "ID":target.id,
                        "strUsername":target.username
                    };
                    if (target.username != this.rootClass.world.myAvatar.objData.strUsername)
                    {
                        this.rootClass.ui.cMenu.fOpenWith("guild", param);
                    }
                    else
                    {
                        this.rootClass.ui.cMenu.fOpenWith("selfguild", param);
                    };
                    break;
                case "Management":
                    display = event.currentTarget;
                    if (this.selectedUser.indexOf(display) == -1)
                    {
                        display.bg.alpha = 0.3;
                        display.removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                        display.removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                        this.selectedUser.push(display);
                    }
                    else
                    {
                        display.bg.alpha = 0;
                        display.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                        display.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                        this.selectedUser.splice(this.selectedUser.indexOf(display), 1);
                    };
            };
        }

        private function selectRank(event:MouseEvent):void
        {
            var target:MovieClip;
            var param:Object;
            var display:MovieClip;
            target = MovieClip(event.currentTarget);
            switch (currentLabel)
            {
                case "Ranks":
                    param = {
                        "ID":this.rootClass.world.myAvatar.objData.CharID,
                        "strUsername":this.rootClass.world.myAvatar.objData.strUsername,
                        "name":target.Name
                    };
                    this.rootClass.ui.cMenu.fOpenWith("guildrank", param);
                    break;
                case "Management":
                    display = MovieClip(event.currentTarget);
                    switch (true)
                    {
                        case (this.selectedRank == null):
                            display.bg.alpha = 0.3;
                            display.removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                            display.removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                            this.selectedRank = display;
                            break;
                        case (!(this.selectedRank.dbId == target.dbId)):
                            this.selectedRank.bg.alpha = 0;
                            this.selectedRank.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                            this.selectedRank.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                            display.bg.alpha = 0.3;
                            display.removeEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                            display.removeEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                            this.selectedRank = display;
                            break;
                        case (this.selectedRank.dbId == target.dbId):
                            display.bg.alpha = 0;
                            display.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                            display.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                            this.selectedRank = null;
                            break;
                    };
                    break;
            };
        }

        private function onOver(event:MouseEvent):void
        {
            var color:Color;
            switch (event.currentTarget.name)
            {
                case "btnGuildTech1":
                case "btnGuildTech2":
                case "btnGuildTech3":
                    color = new Color();
                    color.brightness = 0.3;
                    event.currentTarget.transform.colorTransform = color;
                    break;
                case "btnGuildElementLog":
                case "btnGuildElementRank":
                case "btnGuildElementMember":
                case "btnGuildElementAlliance":
                case "btnGuildElementPendingAlliance":
                    event.currentTarget.bg.alpha = 0.3;
                    break;
            };
        }

        private function onOut(event:MouseEvent):void
        {
            var color:Color;
            switch (event.currentTarget.name)
            {
                case "btnGuildTech1":
                case "btnGuildTech2":
                case "btnGuildTech3":
                    color = new Color();
                    color.brightness = 0;
                    event.currentTarget.transform.colorTransform = color;
                    break;
                case "btnGuildElementLog":
                case "btnGuildElementRank":
                case "btnGuildElementMember":
                case "btnGuildElementAlliance":
                case "btnGuildElementPendingAlliance":
                    event.currentTarget.bg.alpha = 0;
                    break;
            };
        }

        public function buildTech(data:Object):void
        {
            var attribute:Object;
            var mcMenu:DisplayObject;
            var nextX:int = 30;
            var nextY:int = 20;
            var displayCount:int;
            for each (attribute in data.attributes)
            {
                mcMenu = this.listTech.addChild(new CoreButton(attribute.Name, "FFFFFF", ("Level " + attribute.ProgressLevel), "FF9933", "ShowAttribute", attribute));
                if ((((displayCount % 2) == 0) && (!(displayCount == 0))))
                {
                    nextY = 20;
                    nextX = (nextX + (mcMenu.width + 30));
                };
                mcMenu.x = nextX;
                mcMenu.y = nextY;
                nextY = (nextY + (mcMenu.height + 20));
                displayCount++;
            };
            this.mcTechPreloader.visible = false;
            this.scrollTech.visible = true;
            this.configureScroll(this.listTech, this.maskTech, this.scrollTech);
        }

        public function showAttribute(attribute:Object):void
        {
            var level:Object;
            var element:GuildElementTechLevel;
            this.txtTechTitle.text = attribute.Name;
            this.txtTechDescription.text = attribute.Description;
            this.rootClass.onRemoveChildrens(this.listTechLevels);
            var position:int;
            for each (level in attribute.Levels)
            {
                element = new GuildElementTechLevel(level.Level, level.Value);
                element.x = 0;
                element.y = position;
                element.name = "btnGuildElementTechLevel";
                element.addEventListener(MouseEvent.MOUSE_OVER, this.onOver);
                element.addEventListener(MouseEvent.MOUSE_OUT, this.onOut);
                element.addEventListener(MouseEvent.CLICK, this.onClick);
                position = (position + element.height);
                this.listTechLevels.addChild(element);
            };
        }


    }
}//package 

