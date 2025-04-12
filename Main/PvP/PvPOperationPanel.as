// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.PvP.PvPOperationPanel

package Main.PvP
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class PvPOperationPanel extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var btnPlayerVsPlayer:SimpleButton;
        public var btnPartyVsParty:SimpleButton;
        public var btnGuildVsGuild:SimpleButton;
        public var btnStart:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtMap:TextField;
        public var txtCoins:TextField;
        public var txtRedTeam:TextField;
        public var txtBlueTeam:TextField;
        public var bBoostedEquipments:MovieClip;
        public var bBoostedTitles:MovieClip;
        public var bPvPNecklace:MovieClip;
        public var bEquipmentSkills:MovieClip;
        public var bRankD:MovieClip;
        public var bRankC:MovieClip;
        public var bRankB:MovieClip;
        public var bRankA:MovieClip;
        public var bRankP:MovieClip;
        public var bRankS:MovieClip;
        public var bRankSS:MovieClip;
        public var bRankUnknown:MovieClip;
        public var bPotions:MovieClip;
        public var arrRanks:Array = [];
        public var arrMaps:Array = ["doomarenaa", "doomarenab", "doomarenac", "doomarenad"];
        public var intMode:int = 1;

        public function PvPOperationPanel()
        {
            addFrameScript(0, this.frame1);
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function frame1():void
        {
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnPlayerVsPlayer.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnPartyVsParty.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnGuildVsGuild.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnStart.addEventListener(MouseEvent.CLICK, this.onClick);
            this.txtCoins.restrict = "0-9";
            stop();
        }

        private function tournamentRequest(event:Object):void
        {
            if (event.accept)
            {
                Game.root.network.send("psri", [this.intMode, this.txtCoins.text, this.txtMap.text, this.txtRedTeam.text, this.txtBlueTeam.text, this.bBoostedEquipments.bitChecked, this.bBoostedTitles.bitChecked, this.bPvPNecklace.bitChecked, this.bPotions.bitChecked, this.bEquipmentSkills.bitChecked, this.arrRanks]);
            };
        }

        private function onClick(event:MouseEvent):void
        {
            var ranks:Array;
            var rankObj:Object;
            switch (event.currentTarget.name)
            {
                case "btnPlayerVsPlayer":
                    this.rootClass.MsgBox.notify("Mode is switched to Player Vs Player.");
                    this.intMode = 1;
                    break;
                case "btnPartyVsParty":
                    this.rootClass.MsgBox.notify("Mode is switched to Party Vs Party.");
                    this.intMode = 2;
                    break;
                case "btnGuildVsGuild":
                    this.rootClass.MsgBox.notify("Mode is switched to Guild Vs Guild.");
                    this.intMode = 3;
                    break;
                case "btnStart":
                    if (this.txtMap.text == "")
                    {
                        this.txtMap.text = this.arrMaps[int((Math.random() * this.arrMaps.length))];
                    };
                    if (this.txtCoins.text == "")
                    {
                        this.txtCoins.text = 0;
                    };
                    if (this.txtRedTeam.text == "")
                    {
                        this.rootClass.MsgBox.notify("Red Team cannot be empty.");
                        return;
                    };
                    if (this.txtBlueTeam.text == "")
                    {
                        this.rootClass.MsgBox.notify("Blue Team cannot be empty.");
                        return;
                    };
                    ranks = [{
                        "rank":"D",
                        "bitChecked":this.bRankD.bitChecked
                    }, {
                        "rank":"C",
                        "bitChecked":this.bRankC.bitChecked
                    }, {
                        "rank":"B",
                        "bitChecked":this.bRankB.bitChecked
                    }, {
                        "rank":"A",
                        "bitChecked":this.bRankA.bitChecked
                    }, {
                        "rank":"P",
                        "bitChecked":this.bRankP.bitChecked
                    }, {
                        "rank":"S",
                        "bitChecked":this.bRankS.bitChecked
                    }, {
                        "rank":"SS",
                        "bitChecked":this.bRankSS.bitChecked
                    }, {
                        "rank":"?",
                        "bitChecked":this.bRankUnknown.bitChecked
                    }];
                    this.arrRanks = [];
                    for each (rankObj in ranks)
                    {
                        if (rankObj.bitChecked)
                        {
                            this.arrRanks.push(rankObj.rank);
                        };
                    };
                    if (this.arrRanks.length == 0)
                    {
                        this.rootClass.MsgBox.notify("You must select at least one class rank.");
                        return;
                    };
                    MainController.modal("Would you like to start a challenge with these details?", this.tournamentRequest, {}, "red,medium", "dual", true);
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }


    }
}//package Main.PvP

