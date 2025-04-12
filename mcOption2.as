// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcOption2

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.text.*;
    import flash.net.*;
    import Main.*;
    import Game_fla.*;
    import Main.Avatar.Auras.*;
    import Main.Option.*;

    public class mcOption2 extends MovieClip 
    {

        private const game:Game = Game.root;

        public var bg:MovieClip;
        public var btnGeneral:SimpleButton;
        public var btnMe:SimpleButton;
        public var btnNot:SimpleButton;
        public var btnGraphic:SimpleButton;
        public var mcAudio:MovieClip;
        public var mcAntiLag:MovieClip;
        public var mcHideMon:MovieClip;
        public var mcFPS:MovieClip;
        public var mcVis:MovieClip;
        public var mcServer:MovieClip;
        public var mcHidePet:MovieClip;
        public var mcShowHelm:MovieClip;
        public var mcShowCloak:MovieClip;
        public var mcGoto:MovieClip;
        public var mcOtherPet:MovieClip;
        public var mcOtherCloak:MovieClip;
        public var mcAllAnimation:MovieClip;
        public var mcAllDamage:MovieClip;
        public var mcAllEntity:MovieClip;
        public var mcAllGround:MovieClip;
        public var mcAllTitle:MovieClip;
        public var mcHideNPC:MovieClip;
        public var mcNewDrop:MovieClip;
        public var btnLogout:SimpleButton;
        public var btnIgnore:SimpleButton;
        public var btnGuild:SimpleButton;
        public var btnCharPage:SimpleButton;
        public var btnFriend:SimpleButton;
        public var notificationDisplay:MovieClip;
        public var notificationScroll:LPFElementScrollBar;
        public var notificationMask:Sprite;
        private var ptrQ:int = 0;
        private var seilaFps:int = 0;

        public function mcOption2()
        {
            addFrameScript(1, this.setupFrame, 10, this.setupFrame, 18, this.setupFrame, 26, this.setupFrame);
        }

        public function Init():void
        {
            if (this.currentLabel != "General")
            {
                this.gotoAndPlay("General");
            };
            this.btnGeneral.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnNot.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnGraphic.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnMe.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.bg.btnClose.addEventListener(MouseEvent.CLICK, this.onButtonClick, false, 0, true);
            this.setFrame("General");
        }

        private function setupFrame():void
        {
            this.setFrame(this.currentLabel);
            stop();
        }

        private function setFrame(frame:String):void
        {
            var mcVisQuality:String;
            var qualityArrLength:int;
            var i:int;
            switch (frame)
            {
                case "General":
                    this.handlerButtonInit(this.mcAntiLag, "antiLagEnabled");
                    this.handlerButtonInit(this.mcHideMon, "hideAllMon");
                    this.handlerButtonInit(this.mcHideNPC, "hideAllNpc");
                    this.mcAudio.txtMiddle.text = ((this.game.userPreference.data.bSoundOn) ? "ON" : "OFF");
                    this.mcFPS.txtMiddle.text = this.game.userPreference.data["videoSettingsFPS"];
                    this.mcVis.txtMiddle.text = this.game.userPreference.data["videoSettingsQuality"];
                    this.mcServer.txtServer.text = this.game.objServerInfo.Name;
                    this.mcServer.txtTime.text = this.game.date_server.toLocaleTimeString();
                    this.btnIgnore.addEventListener(MouseEvent.CLICK, this.onButtonClick, false, 0, true);
                    this.btnCharPage.addEventListener(MouseEvent.CLICK, this.onButtonClick, false, 0, true);
                    this.btnGuild.addEventListener(MouseEvent.CLICK, this.onButtonClick, false, 0, true);
                    this.btnFriend.addEventListener(MouseEvent.CLICK, this.onButtonClick, false, 0, true);
                    this.btnLogout.addEventListener(MouseEvent.CLICK, this.onButtonClick, false, 0, true);
                    if (!this.mcVis.btnRight.hasEventListener(MouseEvent.CLICK))
                    {
                        this.mcVis.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcAudio.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcFPS.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcVis.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcAudio.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcFPS.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        mcVisQuality = this.mcVis.txtMiddle.text;
                        qualityArrLength = this.game.arrQuality.length;
                        i = 0;
                        while (i < qualityArrLength)
                        {
                            if (mcVisQuality == this.game.arrQuality[i])
                            {
                                this.ptrQ = i;
                                return;
                            };
                            i++;
                        };
                    };
                    this.setQual();
                    this.setFPS();
                    if (this.game.userPreference.data["audioSettingsOverall"] == 0)
                    {
                        this.mcAudio.txtMiddle.text = "OFF";
                    }
                    else
                    {
                        this.mcAudio.txtMiddle.text = "ON";
                    };
                    return;
                case "Me":
                    this.mcHidePet.txtMiddle.text = ((this.game.uoPref.bPet) ? "OFF" : "ON");
                    this.mcShowHelm.txtMiddle.text = ((this.game.uoPref.bHelm) ? "OFF" : "ON");
                    this.mcShowCloak.txtMiddle.text = ((this.game.uoPref.bCloak) ? "OFF" : "ON");
                    this.mcGoto.txtMiddle.text = ((this.game.uoPref.bGoto) ? "OFF" : "ON");
                    if (!this.mcHidePet.btnRight.hasEventListener(MouseEvent.CLICK))
                    {
                        this.mcHidePet.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcShowHelm.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcShowCloak.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcGoto.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcHidePet.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcShowHelm.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcShowCloak.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcGoto.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                    };
                    return;
                case "Notification":
                    Game.configureScroll(this.notificationDisplay, this.notificationMask, this.notificationScroll);
                    this.handlerButtonInit(this.notificationDisplay.mcSelfAuras, "hideSelfAuras");
                    this.handlerButtonInit(this.notificationDisplay.mcTargetAuras, "hideTargetAuras");
                    this.handlerButtonInit(this.notificationDisplay.mcHideAuras, "hideAuras");
                    this.notificationDisplay.mcParty.txtMiddle.text = ((Boolean(this.game.uoPref.bParty)) ? "OFF" : "ON");
                    this.notificationDisplay.mcFriend.txtMiddle.text = ((Boolean(this.game.uoPref.bFriend)) ? "OFF" : "ON");
                    this.notificationDisplay.mcDuel.txtMiddle.text = ((Boolean(this.game.uoPref.bDuel)) ? "OFF" : "ON");
                    this.notificationDisplay.mcGuild.txtMiddle.text = ((Boolean(this.game.uoPref.bGuild)) ? "OFF" : "ON");
                    this.notificationDisplay.mcWhisper.txtMiddle.text = ((this.game.uoPref.bWhisper) ? "OFF" : "ON");
                    this.notificationDisplay.mcCross.txtMiddle.text = ((Boolean(this.game.uoPref.bCrossChat)) ? "OFF" : "ON");
                    this.notificationDisplay.mcTrade.txtMiddle.text = ((Boolean(this.game.uoPref.bTrade)) ? "OFF" : "ON");
                    this.notificationDisplay.mcWb.txtMiddle.text = ((Boolean(this.game.uoPref.bWorldBoss)) ? "OFF" : "ON");
                    this.notificationDisplay.mcTool.txtMiddle.text = ((Boolean(this.game.uoPref.bTT)) ? "OFF" : "ON");
                    this.notificationDisplay.mcGuildRaid.txtMiddle.text = ((Boolean(this.game.uoPref.bTT)) ? "OFF" : "ON");
                    if (!this.notificationDisplay.mcParty.btnRight.hasEventListener(MouseEvent.CLICK))
                    {
                        this.notificationDisplay.mcParty.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcFriend.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcDuel.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcGuild.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcWhisper.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcCross.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcTrade.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcWb.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcTool.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcGuildRaid.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcParty.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcFriend.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcDuel.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcGuild.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcWhisper.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcCross.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcTrade.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcWb.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcTool.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.notificationDisplay.mcGuildRaid.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                    };
                    return;
                case "Graphic":
                    this.handlerButtonInit(this.mcOtherPet, "hideOtherPets");
                    this.handlerButtonInit(this.mcOtherCloak, "hideOtherCapes");
                    this.handlerButtonInit(this.mcAllEntity, "hideAllEntity");
                    this.handlerButtonInit(this.mcAllGround, "hideAllGround");
                    this.handlerButtonInit(this.mcAllTitle, "hideAllTitle");
                    this.handlerButtonInit(this.mcAllAnimation, "hideAllAnimation");
                    this.handlerButtonInit(this.mcAllDamage, "hideAllDamage");
                    this.mcNewDrop.txtMiddle.text = ((this.game.uoPref.bDropInterface) ? "ON" : "OFF");
                    if (!this.mcNewDrop.btnRight.hasEventListener(MouseEvent.CLICK))
                    {
                        this.mcNewDrop.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                        this.mcNewDrop.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                    };
                    return;
            };
        }

        private function setQual():void
        {
            var qualityValue:Number = this.game.userPreference.data["videoSettingsQuality"];
            switch (qualityValue)
            {
                case 0:
                    this.mcVis.txtMiddle.text = "Auto";
                    break;
                case 1:
                    this.mcVis.txtMiddle.text = "Low";
                    break;
                case 2:
                    this.mcVis.txtMiddle.text = "Medium";
                    break;
                case 3:
                    this.mcVis.txtMiddle.text = "High";
                    break;
                case 4:
                    this.mcVis.txtMiddle.text = "Best";
                    break;
            };
            this.game.stage.quality = ((qualityValue == 0) ? "HIGH" : String(this.mcVis.txtMiddle.text).toLocaleUpperCase());
            OptionMC.preferenceCache("videoSettingsQuality", qualityValue);
            this.game.videoSettingsQualityCheck();
        }

        private function setFPS():void
        {
            this.mcFPS.txtMiddle.text = (this.game.userPreference.data.fps = this.game.arrFPS[this.game.userPreference.data["videoSettingsFPS"]]);
            this.game.videoSettingsFPSCheck();
        }

        private function onClick(mouseEvent:MouseEvent):void
        {
            if (this.currentLabel != mouseEvent.currentTarget.name)
            {
                switch (mouseEvent.currentTarget.name)
                {
                    case "btnGeneral":
                        this.gotoAndPlay("General");
                        return;
                    case "btnMe":
                        this.gotoAndPlay("Me");
                        return;
                    case "btnNot":
                        this.gotoAndPlay("Notification");
                        return;
                    case "btnGraphic":
                        this.gotoAndPlay("Graphic");
                        return;
                };
            };
        }

        private function onButtonClick(mouseEvent:MouseEvent):void
        {
            switch (mouseEvent.currentTarget.name)
            {
                case "btnIgnore":
                    Game.root.toggleOptionPanel();
                    return;
                case "btnCharPage":
                    navigateToURL(new URLRequest((Config.serverProfileCharacterURL + this.game.world.myAvatar.objData.strUsername)), "_blank");
                    return;
                case "btnGuild":
                    this.game.toggleGuildPanel();
                    return;
                case "btnFriend":
                    this.game.world.showFriendsList();
                    return;
                case "btnLogout":
                    this.game.logout();
                    return;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    parent.removeChild(this);
                    if (mcPopup_323(Game.root.ui.mcPopup).currentLabel != "Init")
                    {
                        mcPopup_323(Game.root.ui.mcPopup).gotoAndPlay("Init");
                    };
                    return;
            };
        }

        private function onArrowClick(mouseEvent:MouseEvent):void
        {
            if (!Game.root.world.coolDown("toggleOption"))
            {
                return;
            };
            switch (mouseEvent.currentTarget.parent.name)
            {
                case "mcVis":
                    this.ptrQ = ((mouseEvent.currentTarget.name == "btnLeft") ? ((--this.ptrQ < 0) ? 4 : this.ptrQ) : ((++this.ptrQ > 4) ? 0 : this.ptrQ));
                    switch (this.ptrQ)
                    {
                        case 0:
                            this.mcVis.txtMiddle.text = "Auto";
                            break;
                        case 1:
                            this.mcVis.txtMiddle.text = "Low";
                            break;
                        case 2:
                            this.mcVis.txtMiddle.text = "Medium";
                            break;
                        case 3:
                            this.mcVis.txtMiddle.text = "High";
                            break;
                        case 4:
                            this.mcVis.txtMiddle.text = "Best";
                            break;
                    };
                    this.game.stage.quality = ((this.ptrQ == 0) ? "HIGH" : String(this.mcVis.txtMiddle.text).toLocaleUpperCase());
                    OptionMC.preferenceCache("videoSettingsQuality", this.ptrQ);
                    this.game.videoSettingsQualityCheck();
                    return;
                case "mcAudio":
                    if (this.mcAudio.txtMiddle.text == "ON")
                    {
                        this.mcAudio.txtMiddle.text = "OFF";
                        OptionMC.preferenceCache("audioSettingsOverall", 0);
                        this.game.audioSettingsOverallCheck();
                    }
                    else
                    {
                        this.mcAudio.txtMiddle.text = "ON";
                        OptionMC.preferenceCache("audioSettingsOverall", 10);
                        this.game.audioSettingsOverallCheck();
                    };
                    return;
                case "mcAntiLag":
                    this.handlerButtonClick(this.mcAntiLag, "antiLagEnabled", function ():void
                    {
                        game.antiLagCheck();
                    });
                    return;
                case "mcHideMon":
                    this.handlerButtonClick(this.mcHideMon, "hideAllMon", function ():void
                    {
                        game.hideMonsterCheck();
                    });
                    return;
                case "mcHideNPC":
                    this.handlerButtonClick(this.mcHideNPC, "hideAllNpc", function ():void
                    {
                        game.hideNpcCheck();
                    });
                    return;
                case "mcFPS":
                    this.seilaFps = ((mouseEvent.currentTarget.name == "btnLeft") ? ((--this.seilaFps < 0) ? 4 : this.seilaFps) : ((++this.seilaFps > 4) ? 0 : this.seilaFps));
                    this.mcFPS.txtMiddle.text = this.game.arrFPS[this.seilaFps];
                    OptionMC.preferenceCache("videoSettingsFPS", this.seilaFps);
                    this.game.videoSettingsFPSCheck();
                    return;
                case "mcHidePet":
                    this.game.uoPref.bPet = (!(this.game.uoPref.bPet));
                    OptionMC.preferenceStore("bPet", this.game.uoPref.bPet);
                    AvatarMC(this.game.world.myAvatar.pMC).setPetVisibility(this.game.uoPref.bPet);
                    this.mcHidePet.txtMiddle.text = ((this.game.uoPref.bPet) ? "OFF" : "ON");
                    return;
                case "mcShowHelm":
                    this.game.uoPref.bHelm = (!(this.game.uoPref.bHelm));
                    OptionMC.preferenceStore("bHelm", this.game.uoPref.bHelm);
                    this.game.world.myAvatar.dataLeaf.showHelm = this.game.uoPref.bHelm;
                    AvatarMC(this.game.world.myAvatar.pMC).setHelmVisibility(this.game.uoPref.bHelm);
                    this.mcShowHelm.txtMiddle.text = ((this.game.uoPref.bHelm) ? "OFF" : "ON");
                    return;
                case "mcShowCloak":
                    this.game.uoPref.bCloak = (!(this.game.uoPref.bCloak));
                    OptionMC.preferenceStore("bCloak", this.game.uoPref.bCloak);
                    this.game.world.myAvatar.dataLeaf.showCloak = this.game.uoPref.bCloak;
                    AvatarMC(this.game.world.myAvatar.pMC).setCloakVisibility(this.game.uoPref.bCloak);
                    this.mcShowCloak.txtMiddle.text = ((this.game.uoPref.bCloak) ? "OFF" : "ON");
                    return;
                case "mcGoto":
                    this.mcGoto.txtMiddle.text = ((this.mcGoto.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bGoto = (!(this.game.uoPref.bGoto));
                    this.game.network.send("cmd", ["uopref", "bGoto", String(this.game.uoPref.bGoto)]);
                    return;
                case "mcSelfAuras":
                    this.handlerButtonClick(this.notificationDisplay.mcSelfAuras, "hideSelfAuras", function ():void
                    {
                        if (Game.root.userPreference.data.hideSelfAuras)
                        {
                            if (game.playerAuras != null)
                            {
                                game.playerAuras.onClose();
                                game.playerAuras = null;
                            };
                            return;
                        };
                        if (game.playerAuras == null)
                        {
                            game.playerAuras = new PlayerAuras();
                        };
                    });
                    return;
                case "mcTargetAuras":
                    this.handlerButtonClick(this.notificationDisplay.mcTargetAuras, "hideTargetAuras", function ():void
                    {
                        if (Game.root.userPreference.data.hideTargetAuras)
                        {
                            if (game.targetAuras != null)
                            {
                                game.targetAuras.onClose();
                                game.targetAuras = null;
                            };
                            return;
                        };
                        if (game.targetAuras == null)
                        {
                            game.targetAuras = new TargetAuras();
                        };
                    });
                    return;
                case "mcHideAuras":
                    this.handlerButtonClick(this.notificationDisplay.mcHideAuras, "hideAuras");
                    return;
                case "mcParty":
                    this.notificationDisplay.mcParty.txtMiddle.text = ((this.notificationDisplay.mcParty.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bParty = (!(this.game.uoPref.bParty));
                    this.game.network.send("cmd", ["uopref", "bParty", String(this.game.uoPref.bParty)]);
                    return;
                case "mcFriend":
                    this.notificationDisplay.mcFriend.txtMiddle.text = ((this.notificationDisplay.mcFriend.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bFriend = (!(this.game.uoPref.bFriend));
                    this.game.network.send("cmd", ["uopref", "bFriend", String(this.game.uoPref.bFriend)]);
                    return;
                case "mcDuel":
                    this.notificationDisplay.mcDuel.txtMiddle.text = ((this.notificationDisplay.mcDuel.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bDuel = (!(this.game.uoPref.bDuel));
                    this.game.network.send("cmd", ["uopref", "bDuel", String(this.game.uoPref.bDuel)]);
                    return;
                case "mcGuild":
                    this.notificationDisplay.mcGuild.txtMiddle.text = ((this.notificationDisplay.mcGuild.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bGuild = (!(this.game.uoPref.bGuild));
                    this.game.network.send("cmd", ["uopref", "bGuild", String(this.game.uoPref.bGuild)]);
                    return;
                case "mcWhisper":
                    this.game.uoPref.bWhisper = (!(this.game.uoPref.bWhisper));
                    OptionMC.preferenceStore("bWhisper", this.game.uoPref.bWhisper);
                    this.notificationDisplay.mcWhisper.txtMiddle.text = ((this.game.uoPref.bWhisper) ? "OFF" : "ON");
                    return;
                case "mcCross":
                    this.notificationDisplay.mcCross.txtMiddle.text = ((this.notificationDisplay.mcCross.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bCrossChat = (!(this.game.uoPref.bCrossChat));
                    this.game.network.send("cmd", ["uopref", "bCrossChat", String(this.game.uoPref.bCrossChat)]);
                    return;
                case "mcTrade":
                    this.notificationDisplay.mcTrade.txtMiddle.text = ((this.notificationDisplay.mcTrade.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bTrade = (!(this.game.uoPref.bTrade));
                    this.game.network.send("cmd", ["uopref", "bTrade", String(this.game.uoPref.bTrade)]);
                    return;
                case "mcWb":
                    this.notificationDisplay.mcWb.txtMiddle.text = ((this.notificationDisplay.mcWb.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bWorldBoss = (!(this.game.uoPref.bWorldBoss));
                    this.game.network.send("cmd", ["uopref", "bWorldBoss", String(this.game.uoPref.bWorldBoss)]);
                    return;
                case "mcTool":
                    this.notificationDisplay.mcTool.txtMiddle.text = ((this.notificationDisplay.mcTool.txtMiddle.text == "ON") ? "OFF" : "ON");
                    this.game.uoPref.bTT = (!(this.game.uoPref.bTT));
                    this.game.network.send("cmd", ["uopref", "bTT", String(this.game.uoPref.bTT)]);
                    return;
                case "mcGuildRaid":
                    this.game.uoPref.bGuildRaid = (!(this.game.uoPref.bGuildRaid));
                    OptionMC.preferenceStore("bGuildRaid", this.game.uoPref.bGuildRaid);
                    this.notificationDisplay.mcGuildRaid.txtMiddle.text = ((this.game.uoPref.bGuildRaid) ? "OFF" : "ON");
                    return;
                case "mcOtherPet":
                    this.handlerButtonClick(this.mcOtherPet, "hideOtherPets", function ():void
                    {
                        if (Game.root.userPreference.data.hideOtherPets)
                        {
                            game.world.showOthersPets();
                        }
                        else
                        {
                            game.world.hideOthersPets();
                        };
                    });
                    return;
                case "mcOtherCloak":
                    this.handlerButtonClick(this.mcOtherCloak, "hideOtherCapes", this.game.world.setAllCloakVisibility);
                    return;
                case "mcAllEntity":
                    this.handlerButtonClick(this.mcAllEntity, "hideAllEntity", this.game.world.setAllEntityVisibility);
                    return;
                case "mcAllGround":
                    this.handlerButtonClick(this.mcAllGround, "hideAllGround", this.game.world.setAllGroundVisibility);
                    return;
                case "mcAllTitle":
                    this.handlerButtonClick(this.mcAllTitle, "hideAllTitle", this.game.world.setAllTitleVisibility);
                    return;
                case "mcAllAnimation":
                    this.handlerButtonClick(this.mcAllAnimation, "hideAllAnimation");
                    return;
                case "mcAllDamage":
                    this.handlerButtonClick(this.mcAllDamage, "hideAllDamage");
                    return;
                case "mcNewDrop":
                    this.game.uoPref.bDropInterface = (!(this.game.uoPref.bDropInterface));
                    OptionMC.preferenceStore("bDropInterface", this.game.uoPref.bDropInterface);
                    this.game.toggleDropInterface();
                    this.mcNewDrop.txtMiddle.text = ((this.game.uoPref.bDropInterface) ? "ON" : "OFF");
                    return;
            };
        }

        private function handlerButtonInit(button:MovieClip, data:String):void
        {
            TextField(button.txtMiddle).htmlText = ((Game.root.userPreference.data[data]) ? "ON" : "OFF");
            if (!button.btnRight.hasEventListener(MouseEvent.CLICK))
            {
                button.btnRight.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
                button.btnLeft.addEventListener(MouseEvent.CLICK, this.onArrowClick, false, 0, true);
            };
        }

        private function handlerButtonClick(button:MovieClip, data:String, callback:Function=null):void
        {
            Game.root.userPreference.data[data] = (!(Game.root.userPreference.data[data]));
            Game.root.userPreference.flush();
            this.handlerButtonInit(button, data);
            if (callback != null)
            {
                (callback());
            };
        }


    }
}//package 

