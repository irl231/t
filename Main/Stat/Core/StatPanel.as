// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Stat.Core.StatPanel

package Main.Stat.Core
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Avatar.*;
    import flash.net.*;
    import Main.Controller.*;
    import Main.*;

    public class StatPanel extends MovieClip 
    {

        public var avatarMC:AvatarMC;
        public var intStatMax:int = (Game.root.world.myAvatar.objData.intLevel * Game.root.world.myAvatar.objData.stats.StatPerLevel);
        public var intValueMax:int = Game.root.world.myAvatar.objData.stats.MaxStatCap;
        public var intStatTotal:int = 0;
        public var txtStatPoints:TextField;
        public var btnSubmit:SimpleButton;
        public var btnReset:SimpleButton;
        public var btnClose:SimpleButton;
        public var mcStatStrength:StatMeter;
        public var mcStatIntellect:StatMeter;
        public var mcStatEndurance:StatMeter;
        public var mcStatWisdom:StatMeter;
        public var mcStatDexterity:StatMeter;
        public var mcStatLuck:StatMeter;
        private var arrStats:Array = ["Strength", "Intellect", "Endurance", "Dexterity", "Wisdom", "Luck"];

        public function StatPanel()
        {
            this.loadCharacter();
            this.buildStat();
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnSubmit.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
        }

        public function buildStat():*
        {
            this.loadStat();
            this.computeStat();
        }

        public function animateCharacter():void
        {
            Game.root.mixer.playSound("Heal");
            var spEh1:sp_eh1 = sp_eh1(this.avatarMC.addChild(new sp_eh1()));
            spEh1.x = (this.avatarMC.x - 250);
            spEh1.y = this.avatarMC.y;
            spEh1.scaleX = 5;
            spEh1.scaleY = 5;
            Game.animateAndExecute(this.avatarMC.mcChar, "Psychic2", function ():void
            {
                avatarMC.mcChar.gotoAndStop("SternLoop");
            });
        }

        public function loadCharacter():void
        {
            var urlRequest:URLRequest = new URLRequest(((Config.serverApiURL + "user/character/data/") + Game.root.world.myAvatar.objData.CharID));
            urlRequest.method = URLRequestMethod.GET;
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, this.onAvatarComplete);
            urlLoader.load(urlRequest);
        }

        public function loadStat():void
        {
            var stat:String;
            var meter:StatMeter;
            for each (stat in this.arrStats)
            {
                meter = (this.getChildByName(("mcStat" + stat)) as StatMeter);
                if (meter)
                {
                    meter.load(stat);
                };
            };
        }

        public function computeStat():void
        {
            var stat:String;
            var meter:StatMeter;
            var totalAddedStats:int;
            for each (stat in this.arrStats)
            {
                meter = (this.getChildByName(("mcStat" + stat)) as StatMeter);
                if (meter)
                {
                    totalAddedStats = (totalAddedStats + meter.intValue);
                    totalAddedStats = (totalAddedStats + meter.intIncreaseValue);
                };
            };
            this.intStatTotal = (this.intStatMax - totalAddedStats);
            this.txtStatPoints.htmlText = (("Stat Points Left: <font color='#FFFFFF'>" + this.intStatTotal) + "</font>");
        }

        public function validateStat(value:int, attribute:String):int
        {
            var stat:String;
            var intStatTotal:*;
            var meter:StatMeter;
            var totalAddedStats:int;
            for each (stat in this.arrStats)
            {
                if (attribute != stat)
                {
                    meter = (this.getChildByName(("mcStat" + stat)) as StatMeter);
                    if (meter)
                    {
                        totalAddedStats = (totalAddedStats + meter.intValue);
                        totalAddedStats = (totalAddedStats + meter.intIncreaseValue);
                    };
                };
            };
            intStatTotal = ((this.intStatMax - totalAddedStats) - value);
            return (intStatTotal);
        }

        public function onAvatarComplete(event:Event):void
        {
            this.onAvatarDestroy();
            this.avatarMC = AvatarUtil.createAvatar("login_character", this, JSON.parse(event.target.data));
            this.avatarMC.scale(5);
            this.avatarMC.x = 230;
            this.avatarMC.y = 560;
            this.avatarMC.mcChar.gotoAndStop("SternLoop");
            this.avatarMC.mouseEnabled = false;
            this.avatarMC.mouseChildren = false;
            setChildIndex(this.avatarMC, 1);
        }

        public function onAvatarDestroy():void
        {
            if (((!(this.avatarMC == null)) && (this.contains(this.avatarMC))))
            {
                removeChild(this.avatarMC);
                LoadController.singleton.clearLoaderByType("avatar");
            };
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnSubmit":
                    if (this.arrStats.every(function (stat:String, index:int, array:Array):Boolean
                    {
                        var meter:* = (Game.root.ui.mcPopup.CoreStatPanelMC.getChildByName(("mcStat" + stat)) as StatMeter);
                        return ((meter) ? (meter.intIncreaseValue == 0) : true);
                    }))
                    {
                        Game.root.MsgBox.notify("You don't have anything to save.");
                        return;
                    };
                    Game.root.network.send("coreStatUpdate", [this.mcStatStrength.intIncreaseValue, this.mcStatIntellect.intIncreaseValue, this.mcStatEndurance.intIncreaseValue, this.mcStatDexterity.intIncreaseValue, this.mcStatWisdom.intIncreaseValue, this.mcStatLuck.intIncreaseValue]);
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }


    }
}//package Main.Stat.Core

