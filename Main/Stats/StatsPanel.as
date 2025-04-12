// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Stats.StatsPanel

package Main.Stats
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import Main.Model.Item;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import Main.*;
    import Main.Aqw.Boost.*;

    public class StatsPanel extends MovieClip 
    {

        private static const tStatVals:Array = ["STR", "INT", "DEX", "END", "WIS", "LCK"];
        private static const tValues:Array = ["$cai", "$cao", "$cpi", "$cpo", "$cmi", "$cmo", "$chi", "$cho", "$cdi", "$cdo", "$cmc"];
        private static const tCombat1Vals:Array = ["$ap", "$sp", "$thi", "$tha"];
        private static const tCombat2Vals:Array = ["$tcr", "$scm", "$tdo"];

        public var btnHelp:MovieClip;
        public var tName:TextField;
        public var bContainer:MovieClip;
        public var tCombat2:TextField;
        public var tCombat1:TextField;
        public var btnExit:MovieClip;
        public var bg:MovieClip;
        public var btnHelp2:MovieClip;
        public var tCat:TextField;
        public var btnHelp3:MovieClip;
        public var tMod:TextField;
        public var tStats:TextField;
        public var tCore:TextField;
        internal var tt:ToolTipMC;
        private var allocated:Object;
        private var nextMode:String;
        private var uoLeaf:Object;
        private var uoData:Object;
        private var stp:Object;
        private var stg:Object;

        internal var tStatFormats:Array = [];
        internal var tFormats:Array = [];
        internal var tCombatFormats1:Array = [];
        internal var tCombatFormats2:Array = [];
        internal var boostsObj:Object = {};
        private const game:Game = Game.root;

        public function StatsPanel()
        {
            this.uoLeaf = this.game.world.myLeaf();
            this.uoData = this.game.world.myAvatar.objData;
            this.stp = {};
            this.stg = {};
            this.addEventListener(Event.ADDED_TO_STAGE, this.onStage, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onDrag, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.onStop, false, 0, true);
            this.btnHelp.addEventListener(MouseEvent.CLICK, this.onHelp, false, 0, true);
            this.btnHelp2.addEventListener(MouseEvent.CLICK, this.onHelp, false, 0, true);
            this.btnHelp3.addEventListener(MouseEvent.CLICK, this.onHelp, false, 0, true);
            this.btnExit.addEventListener(MouseEvent.CLICK, this.onExit, false, 0, true);
            this.tName.mouseEnabled = false;
            this.tCat.mouseEnabled = false;
            this.updateBoosts();
        }

        public function cleanup():void
        {
            var _local_1:MovieClip;
            if (parent != null)
            {
                _local_1 = MovieClip(parent);
                _local_1.removeChild(this);
                this.game.stage.focus = null;
            };
        }

        public function updateBase():void
        {
            this.tName.htmlText = this.uoData.strClassName;
            this.tCat.text = this.getCatDefinition();
            this.allocateBaseValues();
        }

        public function update():void
        {
            var lengthTotal:int;
            var tStatVal:String;
            var combatStat1Value:String;
            var tCombat1Val:String;
            var tCombat2Val:String;
            var tValue:String;
            var textFormat:TextFormat;
            var tStatFormat:Array;
            var thaValues:Array;
            var statValue:Number;
            var formattedValues:Array;
            this.buildStu();
            var sta:Object = this.game.world.uoTree[this.game.network.myUserName].sta;
            var weaponRange:int = Math.floor((100 - this.game.world.myAvatar.getEquippedItemBySlot("Weapon").iRng));
            var weaponRange2:int = (100 + this.game.world.myAvatar.getEquippedItemBySlot("Weapon").iRng);
            var enhances:Object = this.getEnhances();
            this.tCore.text = ((((((((((((((((((weaponRange + "% - ") + weaponRange2) + "%\n") + enhances["Weapon"][0]) + enhances["Weapon"][1]) + ((enhances["Weapon"][2] != "") ? (", " + enhances["Weapon"][2]) : "")) + "\n") + enhances["ar"][0]) + enhances["ar"][1]) + "\n") + enhances["ba"][0]) + enhances["ba"][1]) + ((enhances["ba"][2] != "") ? (", " + enhances["ba"][2]) : "")) + "\n") + enhances["he"][0]) + enhances["he"][1]) + ((enhances["he"][2] != "") ? (", " + enhances["he"][2]) : "")) + "\n");
            this.tStats.text = "";
            var i:int;
            for each (tStatVal in tStatVals)
            {
                this.tStats.appendText(((((this.stp[("_" + tStatVal)] + this.stg[("^" + tStatVal)]) + " (") + ((sta[("$" + tStatVal)]) ? sta[("$" + tStatVal)] : 0)) + ")\n"));
                this.tStatFormats[i] = [(this.tStats.text.lastIndexOf("(") + 1), this.tStats.text.lastIndexOf(")"), this.determineStatColor(tStatVal, sta[("$" + tStatVal)])];
                i++;
            };
            this.tCombat1.text = "";
            i = 0;
            for each (tCombat1Val in tCombat1Vals)
            {
                if (((tCombat1Val == "$ap") || (tCombat1Val == "$sp")))
                {
                    combatStat1Value = String(sta[tCombat1Val]);
                };
                if (tCombat1Val == "$thi")
                {
                    combatStat1Value = (this.game.coeffToPct(Number(((1 - this.game.baseMiss) + sta["$thi"]))) + "%");
                };
                if (tCombat1Val == "$tha")
                {
                    thaValues = this.fixValues("$tha", sta["$tha"]);
                    combatStat1Value = ((((thaValues.length == 2) ? thaValues[1] : "") + thaValues[0]) + "%");
                };
                lengthTotal = this.tCombat1.length;
                this.tCombat1.appendText((combatStat1Value + "\n"));
                this.tCombatFormats1[i] = [lengthTotal, this.tCombat1.length, this.determineColor(tCombat1Val, sta[tCombat1Val])];
                i++;
            };
            this.tCombat2.text = "";
            i = 0;
            for each (tCombat2Val in tCombat2Vals)
            {
                lengthTotal = this.tCombat2.length;
                this.tCombat2.appendText((this.game.coeffToPct(sta[tCombat2Val]) + "%\n"));
                this.tCombatFormats2[i] = [lengthTotal, this.tCombat2.length, this.determineColor(tCombat2Val, sta[tCombat2Val])];
                i++;
            };
            lengthTotal = this.tCombat2.length;
            this.tCombat2.appendText(this.uoData.intHPMax);
            this.tCombatFormats2[i] = [lengthTotal, this.tCombat2.length, this.determineColor("intHPMax", this.uoData.intHPMax)];
            this.tMod.text = "";
            i = 0;
            for each (tValue in tValues)
            {
                statValue = ((this.stg[("^" + tValue)] != null) ? (sta[tValue] + this.stg[("^" + tValue)]) : sta[tValue]);
                formattedValues = this.fixValues(tValue, statValue);
                lengthTotal = this.tMod.length;
                this.tMod.appendText((((formattedValues.length == 2) ? (formattedValues[1] + formattedValues[0]) : formattedValues[0]) + "%\n"));
                this.tFormats[i] = [lengthTotal, this.tMod.length, this.determineColor(tValue, statValue)];
                i++;
            };
            for each (tStatFormat in this.tStatFormats)
            {
                textFormat = this.tStats.getTextFormat(tStatFormat[0], tStatFormat[1]);
                textFormat.color = tStatFormat[2];
                textFormat.leading = 5.5;
                this.tStats.setTextFormat(textFormat, tStatFormat[0], tStatFormat[1]);
            };
            for each (tStatFormat in this.tFormats)
            {
                textFormat = this.tMod.getTextFormat(tStatFormat[0], tStatFormat[1]);
                textFormat.color = tStatFormat[2];
                textFormat.leading = 5.5;
                this.tMod.setTextFormat(textFormat, tStatFormat[0], tStatFormat[1]);
            };
            for each (tStatFormat in this.tCombatFormats1)
            {
                textFormat = this.tCombat1.getTextFormat(tStatFormat[0], tStatFormat[1]);
                textFormat.color = tStatFormat[2];
                textFormat.leading = 5.5;
                this.tCombat1.setTextFormat(textFormat, tStatFormat[0], tStatFormat[1]);
            };
            for each (tStatFormat in this.tCombatFormats2)
            {
                textFormat = this.tCombat2.getTextFormat(tStatFormat[0], tStatFormat[1]);
                textFormat.color = tStatFormat[2];
                textFormat.leading = 5.5;
                this.tCombat2.setTextFormat(textFormat, tStatFormat[0], tStatFormat[1]);
            };
        }

        public function updateBoosts():void
        {
            var item:Item;
            var boostType:String;
            var key:String;
            var effectValue:Number;
            var effect:String;
            var value:Number;
            var boost:MovieClip;
            while (this.bContainer.numChildren > 1)
            {
                if (!(this.bContainer.getChildAt(1) is Graphics))
                {
                    this.bContainer.removeChildAt(1);
                };
            };
            var dmgBoost:Number = 0;
            var dmgDecrease:Number = 0;
            var classBoost:Number = 0;
            var goldBoost:Number = 0;
            var repBoost:Number = 0;
            var xpBoost:Number = 0;
            this.boostsObj = {};
            var title:* = this.game.world.myAvatar.objData.title;
            if (((!(title == null)) && (!(title.Effect == null))))
            {
                for (key in title.Effect)
                {
                    effectValue = title.Effect[key];
                    if (effectValue == 0)
                    {
                    }
                    else
                    {
                        effectValue = Math.round(Number((effectValue * 100)));
                        switch (key)
                        {
                            case "DamageIncrease":
                                dmgBoost = (dmgBoost + effectValue);
                                this.boostsObj["dmgBoost"] = "";
                                break;
                            case "DamageReduction":
                                dmgDecrease = (dmgDecrease + effectValue);
                                this.boostsObj["dmgDecrease"] = "";
                                break;
                            case "ClassPoint":
                                classBoost = (classBoost + effectValue);
                                this.boostsObj["classBoost"] = "";
                                break;
                            case "Coins":
                                goldBoost = (goldBoost + effectValue);
                                this.boostsObj["goldBoost"] = "";
                                break;
                            case "Reputation":
                                repBoost = (repBoost + effectValue);
                                this.boostsObj["repBoost"] = "";
                                break;
                            case "Experience":
                                xpBoost = (xpBoost + effectValue);
                                this.boostsObj["xpBoost"] = "";
                                break;
                        };
                    };
                };
            };
            for each (item in this.game.world.myAvatar.items)
            {
                if (item.bEquip)
                {
                    for each (effect in item.effects.split(","))
                    {
                        value = Math.round((Number(effect.split(":")[1]) * 100));
                        switch (effect.split(":")[0].toLowerCase())
                        {
                            case "dmgall":
                                dmgBoost = (dmgBoost + value);
                                this.boostsObj["dmgBoost"] = "";
                                break;
                            case "dmgdecrease":
                                dmgDecrease = (dmgDecrease + value);
                                this.boostsObj["dmgDecrease"] = "";
                                break;
                            case "cp":
                                classBoost = (classBoost + value);
                                this.boostsObj["classBoost"] = "";
                                break;
                            case "gold":
                                goldBoost = (goldBoost + value);
                                this.boostsObj["goldBoost"] = "";
                                break;
                            case "rep":
                                repBoost = (repBoost + value);
                                this.boostsObj["repBoost"] = "";
                                break;
                            case "exp":
                                xpBoost = (xpBoost + value);
                                this.boostsObj["xpBoost"] = "";
                                break;
                        };
                    };
                };
            };
            if (this.boostsObj.length == 0)
            {
                this.bContainer.visible = false;
                return;
            };
            var position:int = 5;
            var centerY:* = ((this.bContainer.height - 25) >> 1);
            for (boostType in this.boostsObj)
            {
                switch (boostType)
                {
                    case "dmgBoost":
                        boost = new BoostDamageIncrease();
                        this.boostsObj["dmgBoost"] = (("Damage increase " + dmgBoost) + "%");
                        break;
                    case "dmgDecrease":
                        boost = new BoostDamageDecrease();
                        this.boostsObj["dmgDecrease"] = (("Damage reduction " + dmgDecrease) + "%");
                        break;
                    case "classBoost":
                        boost = new BoostClassPoint();
                        this.boostsObj["classBoost"] = (("Class Point " + classBoost) + "%");
                        break;
                    case "goldBoost":
                        boost = new BoostCoins();
                        this.boostsObj["goldBoost"] = (("Coins " + goldBoost) + "%");
                        break;
                    case "repBoost":
                        boost = new BoostReputation();
                        this.boostsObj["repBoost"] = (("Reputation " + repBoost) + "%");
                        break;
                    case "xpBoost":
                        boost = new BoostExperience();
                        this.boostsObj["xpBoost"] = (("Experience " + xpBoost) + "%");
                        break;
                };
                boost.width = 25;
                boost.height = 25;
                boost.name = boostType;
                boost.addEventListener(MouseEvent.MOUSE_DOWN, this.onBoostGet, false, 0, true);
                boost.addEventListener(MouseEvent.MOUSE_OVER, this.onBoostGet, false, 0, true);
                boost.addEventListener(MouseEvent.MOUSE_OUT, this.onBoostOut, false, 0, true);
                boost.x = position;
                boost.y = centerY;
                position = (position + 25);
                this.bContainer.addChild(boost);
            };
        }

        private function getCatDefinition():String
        {
            switch (this.uoData.sClassCat)
            {
                case "M1":
                    return ("Tank Melee");
                case "M2":
                    return ("Dodge Melee");
                case "M3":
                    return ("Full Hybrid");
                case "M4":
                    return ("Power Melee");
                case "C1":
                    return ("Offensive Caster");
                case "C2":
                    return ("Defensive Caster");
                case "C3":
                    return ("Power Caster");
                case "S1":
                    return ("Luck Hybrid");
                default:
                    return ("Adventurer");
            };
        }

        private function buildStu():void
        {
            var categoryName:String;
            var statName:String;
            var statIndex:int;
            var statValue:Number;
            var categoryStats:Object = this.game.getCategoryStats(this.uoData.sClassCat, this.uoLeaf.intLevel);
            statIndex = 0;
            while (statIndex < MainController.stats.length)
            {
                statName = MainController.stats[statIndex];
                this.stg[("^" + statName)] = 0;
                this.stp[("_" + statName)] = Math.floor(categoryStats[statName]);
                statIndex++;
            };
            var userTempStats:Object = this.game.world.uoTree[this.game.network.myUserName];
            for (categoryName in userTempStats.tempSta)
            {
                if (categoryName != "innate")
                {
                    for (statName in userTempStats.tempSta[categoryName])
                    {
                        if (this.stg[("^" + statName)] == null)
                        {
                            this.stg[("^" + statName)] = 0;
                        };
                        statValue = int(userTempStats.tempSta[categoryName][statName]);
                        this.stg[("^" + statName)] = (this.stg[("^" + statName)] + statValue);
                    };
                };
            };
        }

        private function fixValues(stat:String, value:Number):Array
        {
            var arr:Array = [((((stat == "$chi") || (stat == "$cmc")) || (stat == "$tha")) ? this.game.coeffToPct(value) : this.game.coeffToPct((value - 1)))];
            switch (stat)
            {
                case "$cai":
                    arr[0] = (arr[0] * -1);
                    return ((value <= 0.2) ? [this.game.coeffToPct((1 - 0.2)), "*"] : arr);
                case "$cao":
                    return ((value <= 0.1) ? [this.game.coeffToPct((0.1 - 1)), "*"] : arr);
                case "$tha":
                    return ((value >= 0.5) ? [this.game.coeffToPct((1 - 0.15)), "*"] : arr);
                case "$cpi":
                    arr[0] = (arr[0] * -1);
                    return ((value <= 0.2) ? [this.game.coeffToPct((1 - 0.2)), "*"] : arr);
                case "$cmi":
                    arr[0] = (arr[0] * -1);
                    return ((value <= 0.2) ? [this.game.coeffToPct((1 - 0.2)), "*"] : arr);
                case "$cmo":
                    return ((value <= 0.2) ? [this.game.coeffToPct((1 - 0.1)), "*"] : arr);
                case "$cdi":
                    arr[0] = (arr[0] * -1);
                    return (arr);
            };
            return (arr);
        }

        private function determineColor(statName:String, statValue:Number):*
        {
            if (!this.allocated[statName])
            {
                this.allocated[statName] = statValue;
                return (0xCCCCCC);
            };
            var currentValue:Number = (this.fixValues(statName, statValue)[0] - 1);
            var allocatedValue:Number = (this.fixValues(statName, this.allocated[statName])[0] - 1);
            if (statName == "$cmc")
            {
                currentValue = (currentValue * -1);
                allocatedValue = (allocatedValue * -1);
            };
            if (currentValue < allocatedValue)
            {
                return (0x666666);
            };
            if (currentValue > allocatedValue)
            {
                return (0xCC9900);
            };
            return (0xCCCCCC);
        }

        private function determineStatColor(statName:String, statValue:Number):*
        {
            var totalStatPoints:Number = (this.stp[("_" + statName)] + this.stg[("^" + statName)]);
            var currentValue:Number = statValue;
            if (totalStatPoints > currentValue)
            {
                return (0x666666);
            };
            if (totalStatPoints < currentValue)
            {
                return (0xCC9900);
            };
            return (0xCCCCCC);
        }

        private function allocateBaseValues():void
        {
            var _local_2:*;
            var _local_3:*;
            if (!this.allocated)
            {
                this.allocated = {};
            };
            if (this.game.baseClassStats)
            {
                for (_local_3 in this.game.baseClassStats)
                {
                    this.allocated[_local_3] = this.game.baseClassStats[_local_3];
                };
                this.allocated["intHPMax"] = this.uoData.intHPMax;
                this.game.baseClassStats = null;
                return;
            };
            var _local_1:* = this.game.world.uoTree[this.game.network.myUserName].sta;
            for each (_local_2 in tValues)
            {
                this.allocated[_local_2] = _local_1[_local_2];
            };
            for each (_local_2 in tCombat1Vals)
            {
                this.allocated[_local_2] = _local_1[_local_2];
            };
            for each (_local_2 in tCombat2Vals)
            {
                this.allocated[_local_2] = _local_1[_local_2];
            };
            this.allocated["intHPMax"] = this.uoData.intHPMax;
        }

        private function getProc(_arg_1:Object):String
        {
            var _local_2:* = "";
            if (((_arg_1) && (_arg_1.hasOwnProperty("ProcID"))))
            {
                switch (_arg_1.ProcID)
                {
                    case 2:
                        _local_2 = "Spiral Carve";
                        break;
                    case 3:
                        _local_2 = "Awe Blast";
                        break;
                    case 4:
                        _local_2 = "Health Vamp";
                        break;
                    case 5:
                        _local_2 = "Mana Vamp";
                        break;
                    case 6:
                        _local_2 = "Powerword DIE";
                        break;
                    case 7:
                        _local_2 = "Lacerate";
                        break;
                    case 8:
                        _local_2 = "Smite";
                        break;
                    case 9:
                        _local_2 = "Valiance";
                        break;
                    case 10:
                        _local_2 = "Arcana's Concerto";
                        break;
                    case 11:
                        _local_2 = "Acheron";
                        break;
                    case 12:
                        _local_2 = "Elysium";
                        break;
                    case 13:
                        _local_2 = "Praxis";
                        break;
                    case 14:
                        _local_2 = "Dauntless";
                        break;
                    case 15:
                        _local_2 = "Ravenous";
                        break;
                    default:
                        _local_2 = "None";
                };
            };
            return (_local_2);
        }

        private function getEnh(_arg_1:String):Array
        {
            var _local_4:*;
            var _local_2:Array = ["None", "", ""];
            var _local_3:Object = this.game.world.myAvatar.getEquippedItemBySlot(_arg_1);
            _local_2[2] = this.getProc(_local_3);
            if (!_local_3)
            {
                return (_local_2);
            };
            if (_local_3.PatternID != null)
            {
                _local_4 = this.game.world.enhPatternTree[_local_3.PatternID];
            };
            if (_local_3.EnhPatternID != null)
            {
                _local_4 = this.game.world.enhPatternTree[_local_3.EnhPatternID];
            };
            if (!_local_4)
            {
                return (_local_2);
            };
            _local_2[0] = _local_4.sName;
            _local_2[1] = ((_local_3.EnhRty > 1) ? (" +" + String((_local_3.EnhRty - 1))) : "");
            return (_local_2);
        }

        private function getEnhances():Object
        {
            var _local_2:*;
            var _local_1:Object = {
                "Weapon":[],
                "ar":[],
                "ba":[],
                "he":[]
            };
            for (_local_2 in _local_1)
            {
                _local_1[_local_2] = this.getEnh(_local_2);
            };
            return (_local_1);
        }

        public function onHelp(_arg_1:MouseEvent):void
        {
            navigateToURL(new URLRequest((Config.serverBaseURL + "help/stats")), "_blank");
        }

        public function onExit(_arg_1:MouseEvent):void
        {
            this.cleanup();
        }

        public function onStage(_arg_1:Event):void
        {
            this.updateBase();
            this.update();
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onStage);
            this.tt = new ToolTipMC();
            addChild(this.tt);
        }

        private function onDrag(_arg_1:MouseEvent):void
        {
            this.startDrag();
        }

        private function onStop(_arg_1:MouseEvent):void
        {
            this.stopDrag();
        }

        private function onBoostGet(mouseEvent:MouseEvent):void
        {
            this.game.ui.ToolTip.openWith({"str":this.boostsObj[mouseEvent.currentTarget.name]});
        }

        private function onBoostOut(_arg_1:MouseEvent):void
        {
            this.game.ui.ToolTip.close();
        }


    }
}//package Main.Stats

