// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameEnhText

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import Main.Model.Item;
    import flash.display.DisplayObject;
    import Main.Model.Skill;
    import flash.events.MouseEvent;
    import Main.Model.*;
    import flash.display.*;
    import flash.events.*;
    import Main.*;
    import Main.Aqw.Boost.*;

    public class LPFFrameEnhText extends LPFFrame 
    {

        public var mcStats:MovieClip;
        public var tDesc:TextField;
        public var mcTag:MovieClip;
        internal var mcContainer:MovieClip;
        internal var boostsObj:Object;
        private var iSel:Item;
        private var eSel:Item;
        private var iEnh:Object;
        private var eEnh:Object;
        private var curItem:Object;
        private var isEquip:Boolean = false;

        public function LPFFrameEnhText():void
        {
            this.mcStats.sproto.visible = false;
        }

        override public function fOpen(data:Object):void
        {
            positionBy(data.r);
            this.iEnh = null;
            this.eEnh = null;
            if (data.eventTypes != undefined)
            {
                eventTypes = data.eventTypes;
            };
            if (data.isEquip != undefined)
            {
                this.isEquip = data.isEquip;
            };
            this.fDraw();
            getLayout().registerForEvents(this, eventTypes);
        }

        override public function fClose():void
        {
            var dio:DisplayObject;
            super.fClose();
            while (this.mcStats.numChildren > 1)
            {
                dio = this.mcStats.getChildAt(1);
                dio.removeEventListener(MouseEvent.MOUSE_OVER, this.onTTFieldMouseOver);
                dio.removeEventListener(MouseEvent.MOUSE_OUT, this.onTTFieldMouseOut);
                this.mcStats.removeChildAt(1);
            };
        }

        override public function notify(_arg1:Object):void
        {
            if (_arg1.eventType != "showItemListB")
            {
                switch (_arg1.eventType)
                {
                    case "refreshItems":
                        if (((!(this.iSel == _arg1.fData.iSel)) && (!(this.iSel == _arg1.fData.eSel))))
                        {
                            this.iSel = null;
                            this.eSel = null;
                        };
                        break;
                    case "clearState":
                        this.iSel = null;
                        this.eSel = null;
                        break;
                    default:
                        this.iSel = _arg1.fData.iSel;
                        this.eSel = _arg1.fData.eSel;
                        if (((this.iSel == null) && (!(this.eSel == null))))
                        {
                            this.iSel = this.eSel;
                            this.eSel = null;
                        };
                };
            };
            if (this.isEquip)
            {
                if (this.iSel != null)
                {
                    this.iSel = rootClass.world.myAvatar.getEquippedItemBySlot(this.iSel.sES);
                };
                if (this.eSel != null)
                {
                    this.eSel = rootClass.world.myAvatar.getEquippedItemBySlot(this.eSel.sES);
                };
            };
            this.fDraw();
        }

        protected function fDraw():void
        {
            var item:Item;
            var isEnh:Boolean;
            var dps:Number;
            var range:Number;
            var rarity:int;
            var level:int;
            var health:int;
            var dpsFinal:int;
            var autoAttack:Skill;
            var damageFinal:int;
            var damageMin:int;
            var damageMax:int;
            var desc:String = "";
            var _local2:String = "#00CCFF";
            this.mcTag.visible = false;
            if (this.iSel != null)
            {
                desc = "<font size='12' color='#999999'>Enhancement</font><br>";
                if (["Weapon", "he", "ar", "ba"].indexOf(this.iSel.sES) > -1)
                {
                    this.iEnh = null;
                    this.eEnh = null;
                    if (this.iSel.PatternID != -1)
                    {
                        this.iEnh = rootClass.world.enhPatternTree[this.iSel.PatternID];
                    };
                    if (this.iSel.EnhPatternID != -1)
                    {
                        this.iEnh = rootClass.world.enhPatternTree[this.iSel.EnhPatternID];
                    };
                    if (this.eSel != null)
                    {
                        if (this.eSel.sES == this.iSel.sES)
                        {
                            if (this.eSel.PatternID != -1)
                            {
                                this.eEnh = rootClass.world.enhPatternTree[this.eSel.PatternID];
                            };
                            if (this.eSel.EnhPatternID != -1)
                            {
                                this.eEnh = rootClass.world.enhPatternTree[this.eSel.EnhPatternID];
                            };
                            desc = (desc + ((("<font size='11' color='" + _local2) + "'>") + this.eEnh.sName));
                            if (this.eSel.iRty > 1)
                            {
                                desc = (desc + (" +" + (this.eSel.iRty - 1)));
                            };
                            desc = (desc + "</font>");
                            desc = (desc + "<font size='11' color='#FFFFFF'> vs. </font>");
                            _local2 = "#999999";
                            if (this.iEnh != null)
                            {
                                desc = (desc + ((("<font size='11' color='" + _local2) + "'>") + this.iEnh.sName));
                                if (this.iSel.EnhRty > 1)
                                {
                                    desc = (desc + (" +" + (this.iSel.EnhRty - 1)));
                                };
                                desc = (desc + "</font>");
                            }
                            else
                            {
                                desc = (desc + "<font size='11' color='#00CCFF'>No enhancement</font>");
                            };
                        }
                        else
                        {
                            desc = (desc + "<font size='11' color='#00CCFF'>Enhancement type must match item slot!</font>");
                        };
                    }
                    else
                    {
                        if (this.iEnh != null)
                        {
                            desc = (desc + ((("<font size='11' color='" + _local2) + "'>") + this.iEnh.sName));
                            if (this.iSel.EnhRty > 1)
                            {
                                desc = (desc + (" +" + (this.iSel.EnhRty - 1)));
                            }
                            else
                            {
                                if (((this.iSel.iRty < 10) && (this.iSel.iRty > 1)))
                                {
                                    desc = (desc + (" +" + (this.iSel.iRty - 1)));
                                };
                            };
                            desc = (desc + "</font>");
                        }
                        else
                        {
                            desc = (desc + "<font size='11' color='#00CCFF'>No enhancement</font>");
                        };
                    };
                    if (this.iSel.sType.toLowerCase() == "enhancement")
                    {
                        desc = (desc + " <font size='11' color='#FFFFFF'>imbues an item with: </font>");
                    };
                    item = new Item(rootClass.copyObj(this.iSel));
                    if (this.eSel != null)
                    {
                        item = new Item(rootClass.copyObj(this.eSel));
                        if (this.iSel != null)
                        {
                            item.sType = this.iSel.sType;
                            if (this.iSel.EnhRty != -1)
                            {
                                item.EnhRty = this.iSel.EnhRty;
                            };
                            item.iRng = (("iRng" in this.iSel) ? this.iSel.iRng : 10);
                        };
                    };
                    if (item.sES.toLowerCase() == "weapon")
                    {
                        isEnh = (item.sType.toLowerCase() == "enhancement");
                        dps = ((isEnh) ? item.iDPS : ((item.EnhDPS != -1) ? item.EnhDPS : (((!(this.eSel == null)) && (!(this.eSel.iDPS == -1))) ? this.eSel.iDPS : -1)));
                        if (((dps === 0) || (dps === -1)))
                        {
                            dps = 100;
                        };
                        dps = (dps / 100);
                        range = ((item.iRng != -1) ? item.iRng : 0);
                        range = (range / 100);
                        rarity = 0;
                        if (item.iRty != -1)
                        {
                            rarity = (item.iRty - 1);
                        };
                        if (item.EnhRty != -1)
                        {
                            rarity = (item.EnhRty - 1);
                        };
                        level = ((isEnh) ? item.iLvl : ((item.EnhLvl != -1) ? item.EnhLvl : (((!(this.eSel == null)) && (!(this.eSel.iLvl == -1))) ? this.eSel.iLvl : this.iSel.iLvl)));
                        health = rootClass.getBaseHPByLevel((level + rarity));
                        dpsFinal = Math.round((((health / 20) * dps) * rootClass.PCDPSMod));
                        autoAttack = rootClass.world.getAutoAttack();
                        damageFinal = Math.round((dpsFinal << 1));
                        damageFinal = (damageFinal * autoAttack.damage);
                        damageMin = Math.floor((damageFinal - (damageFinal * range)));
                        damageMax = Math.ceil((damageFinal + (damageFinal * range)));
                        if ((((item.sType.toLowerCase() == "enhancement") || (!(item.EnhLvl == -1))) || (!(this.eSel == null))))
                        {
                            desc = (desc + (("<br><font color='#FFFFFF'>" + dpsFinal) + " DPS"));
                        };
                        if (((!(item.sType.toLowerCase() == "enhancement")) && ((!(item.EnhLvl == -1)) || (!(this.eSel == null)))))
                        {
                            desc = (desc + ((((((" ( <font color='#999999'>" + damageMin) + "-") + damageMax) + ", ") + rootClass.numToStr((autoAttack.cd / 1000), 1)) + " speed</font> )</font>"));
                        };
                    };
                }
                else
                {
                    desc = (desc + "<font size='11' color='#00CCFF'>This item cannot be enhanced.</font>");
                };
                this.tDesc.htmlText = desc;
                if (rootClass.ui.mcPopup.currentLabel == "AuctionPanel")
                {
                    this.mcTag.visible = false;
                }
                else
                {
                    this.mcTag.visible = true;
                    this.mcTag.y = 98;
                    this.mcTag.tTag.htmlText = ((this.iSel.bTrade) ? "<font color='#00FF00'>Marketable</font>, " : "Not-Marketable, ");
                    this.mcTag.tTag.htmlText = (this.mcTag.tTag.htmlText + ((this.iSel.bSellable) ? " <font color='#00FF00'>Sellable</font> " : " Not-Sellable "));
                };
                this.showStats();
            }
            else
            {
                if (((!(getLayout().iSel == null)) && (!(rootClass.doIHaveEnhancements()))))
                {
                    this.tDesc.htmlText = ((this.isEquip) ? "<font color='#FF0000'>Select an Item!</font><br>" : "<font color='#00C264'>You need a Fortification!</font><br><font color='#FFFFFF'>No fortification for this type of item were found in your backpack. Fortifications are used to power up your item. You can buy at shops or find them on monsters.</font>");
                }
                else
                {
                    this.tDesc.htmlText = "No item selected.";
                };
                this.showStats();
            };
        }

        private function showStats():void
        {
            var stat1:Object;
            var stat2:Object;
            var i:int;
            var i1:int;
            var itemCopy:Object;
            var orderedStat:String;
            var i2:int;
            var mcStatCopy:MovieClip;
            var _local6:int;
            var effect:String;
            var position:int;
            var boostType:String;
            var value:Number;
            var boost:MovieClip;
            rootClass.onRemoveChildrens(this.mcStats);
            this.mcStats.visible = false;
            this.mcStats.sproto.x = 0;
            this.mcStats.sproto.y = (this.tDesc.textHeight + 8);
            var isItemNull:* = (!(this.eSel == null));
            var mcStatClass:Class = (this.mcStats.sproto.constructor as Class);
            if (((!(this.iSel == null)) && ((((!(this.iEnh == null)) || (!(this.eEnh == null))) && ((this.eSel == null) || (this.eSel.sES == this.iSel.sES))) || ((isItemNull) && (this.eSel.sES == this.iSel.sES)))))
            {
                if (((isItemNull) && (!(this.iEnh == null))))
                {
                    stat1 = rootClass.getStatsA(this.eSel, this.iSel.sES);
                    stat2 = rootClass.getStatsA(this.iSel, this.iSel.sES);
                }
                else
                {
                    itemCopy = rootClass.copyObj(this.iSel);
                    if (isItemNull)
                    {
                        itemCopy.EnhPatternID = this.eSel.PatternID;
                        itemCopy.EnhLvl = this.eSel.iLvl;
                        itemCopy.EnhRty = this.eSel.iRty;
                        isItemNull = false;
                    };
                    stat1 = rootClass.getStatsA(itemCopy, this.iSel.sES);
                };
                i = 0;
                i1 = 0;
                while (i < MainController.orderedStats.length)
                {
                    orderedStat = MainController.orderedStats[i];
                    i2 = 0;
                    if ((((isItemNull) && (!(stat2[("$" + orderedStat)] == null))) && (stat1[("$" + orderedStat)] == null)))
                    {
                        stat1[("$" + orderedStat)] = 0;
                    };
                    if (stat1[("$" + orderedStat)] != null)
                    {
                        mcStatCopy = new (mcStatClass)();
                        _local6 = stat1[("$" + orderedStat)];
                        mcStatCopy.tSta.text = MainController.getFullStatName(orderedStat).toUpperCase();
                        mcStatCopy.tOldval.visible = false;
                        if (isItemNull)
                        {
                            if (stat2[("$" + orderedStat)] != null)
                            {
                                i2 = stat2[("$" + orderedStat)];
                            };
                            mcStatCopy.tOldval.text = (("(" + i2) + ")");
                            mcStatCopy.tOldval.visible = true;
                            if (_local6 > i2)
                            {
                                mcStatCopy.tVal.htmlText = (("<font color='#33FF66'>" + _local6) + "</font>");
                            }
                            else
                            {
                                if (_local6 == i2)
                                {
                                    mcStatCopy.tVal.htmlText = (("<font color='#FFFFFF'>" + _local6) + "</font>");
                                }
                                else
                                {
                                    mcStatCopy.tVal.htmlText = (("<font color='#FF6633'>" + _local6) + "</font>");
                                };
                            };
                        }
                        else
                        {
                            mcStatCopy.tVal.htmlText = (('<font color="0xFFFFFF">' + _local6) + "</font>");
                        };
                        mcStatCopy.tOldval.x = ((mcStatCopy.tVal.x + mcStatCopy.tVal.textWidth) + 3);
                        mcStatCopy.x = (this.mcStats.sproto.x + ((i1 % 3) * 100));
                        mcStatCopy.y = (this.mcStats.sproto.y + (Math.floor((i1 / 3)) << 4));
                        mcStatCopy.hit.alpha = 0;
                        mcStatCopy.addEventListener(MouseEvent.MOUSE_OVER, this.onTTFieldMouseOver, false, 0, true);
                        mcStatCopy.addEventListener(MouseEvent.MOUSE_OUT, this.onTTFieldMouseOut, false, 0, true);
                        mcStatCopy.name = ("t" + orderedStat);
                        this.mcStats.addChild(mcStatCopy);
                        i1++;
                    };
                    i++;
                };
                this.mcStats.visible = true;
            };
            if (((this.mcContainer) && (getChildByName("mcContainer"))))
            {
                removeChild(getChildByName("mcContainer"));
            };
            if (((this.mcContainer) && (this.mcStats.getChildByName("mcContainer"))))
            {
                this.mcStats.removeChild(this.mcStats.getChildByName("mcContainer"));
            };
            if (((!(this.iSel == null)) && (!(this.iSel.effects == ""))))
            {
                this.boostsObj = {};
                this.mcContainer = new MovieClip();
                this.mcContainer.name = "mcContainer";
                this.mcContainer.x = 1;
                this.mcContainer.y = 75;
                addChild(this.mcContainer);
                for each (effect in this.iSel.effects.split(","))
                {
                    value = Math.round((Number(effect.split(":")[1]) * 100));
                    switch (effect.split(":")[0].toLowerCase())
                    {
                        case "dmgall":
                            this.boostsObj["dmgBoost"] = (("Damage increase " + value) + "%");
                            break;
                        case "dmgdecrease":
                            this.boostsObj["dmgDecrease"] = (("Damage reduction " + value) + "%");
                            break;
                        case "cp":
                            this.boostsObj["classBoost"] = (("Class Point " + value) + "%");
                            break;
                        case "gold":
                            this.boostsObj["goldBoost"] = (("Coins " + value) + "%");
                            break;
                        case "rep":
                            this.boostsObj["repBoost"] = (("Reputation " + value) + "%");
                            break;
                        case "exp":
                            this.boostsObj["xpBoost"] = (("Experience " + value) + "%");
                            break;
                    };
                };
                position = 0;
                for (boostType in this.boostsObj)
                {
                    switch (boostType)
                    {
                        case "dmgBoost":
                            boost = new BoostDamageIncrease();
                            break;
                        case "dmgDecrease":
                            boost = new BoostDamageDecrease();
                            break;
                        case "classBoost":
                            boost = new BoostClassPoint();
                            break;
                        case "goldBoost":
                            boost = new BoostCoins();
                            break;
                        case "repBoost":
                            boost = new BoostReputation();
                            break;
                        case "xpBoost":
                            boost = new BoostExperience();
                            break;
                    };
                    boost.width = 25;
                    boost.height = 25;
                    boost.name = boostType;
                    boost.addEventListener(MouseEvent.MOUSE_DOWN, this.onBoostGet, false, 0, true);
                    boost.addEventListener(MouseEvent.MOUSE_OVER, this.onBoostGet, false, 0, true);
                    boost.addEventListener(MouseEvent.MOUSE_OUT, this.onBoostOut, false, 0, true);
                    boost.x = position;
                    position = (position + 25);
                    this.mcContainer.addChild(boost);
                };
            };
        }

        private function onBoostGet(mouseEvent:MouseEvent):void
        {
            rootClass.ui.ToolTip.openWith({"str":this.boostsObj[mouseEvent.currentTarget.name]});
        }

        private function onBoostOut(mouseEvent:MouseEvent):void
        {
            rootClass.ui.ToolTip.close();
        }

        private function onTTFieldMouseOver(e:MouseEvent):void
        {
            var fieldName:String = e.currentTarget.name;
            var ttStr:String = "";
            switch (fieldName)
            {
                case "tAP":
                    ttStr = "Attack Power increases the effectiveness of your physical damage attacks.";
                    break;
                case "tSP":
                    ttStr = "Magic Power increases the effectiveness of your magical damage attacks.";
                    break;
                case "tDmg":
                    ttStr = "This is the damage you would expect to see on a normal melee hit, before any other modifiers.";
                    break;
                case "tHP":
                    ttStr = "Your total Hit Points.  When these reach zero, you will need to wait a short time before being able to continue playing.";
                    break;
                case "tHitTF":
                    ttStr = "Hit chance determines how likely you are to hit a target, before any other modifiers.";
                    break;
                case "tHasteTF":
                    ttStr = "Haste reduces the cooldown on all of your attacks and spells, including Auto Attack, by a certain percentage (hard capped at 50%).";
                    break;
                case "tCritTF":
                    ttStr = "Critical Strike chance increases the likelihood of dealing additional damage on a any attack.";
                    break;
                case "tDodgeTF":
                    ttStr = "Evasion chance allows you to completely avoid incoming damage.";
                    break;
                case "tSTR":
                case "sl1":
                    ttStr = "Strength increases Attack Power, which boosts physical damage. It also improves Critical Strike chance for melee classes.";
                    break;
                case "tINT":
                case "sl2":
                    ttStr = "Intellect increases Magic Power, which boosts magical damage. It also improve Critical Strike chance for caster classes.";
                    break;
                case "tEND":
                case "sl3":
                    ttStr = "Endurance directly contributes to your total Hit Points.  While very useful for all classes, some abilities work best with very high or very low total HP.";
                    break;
                case "tDEX":
                case "sl4":
                    ttStr = "Dexterity is valuable to melee classes. It increases Haste, Hit chance, and Evasion chance. It increases only Evasion chance for caster classes.";
                    break;
                case "tWIS":
                case "sl5":
                    ttStr = "Wisdom is valuable to caster classes. It increases Hit chance, Crit chance, and Evasion chance. It improves only Evasion chance for melee classes.";
                    break;
                case "tLCK":
                case "sl6":
                    ttStr = "Luck increases your Critical Strike modifier value directly, and may have effects outside of combat.";
                    break;
            };
            rootClass.ui.ToolTip.openWith({"str":ttStr});
        }

        private function onTTFieldMouseOut(_arg1:MouseEvent):void
        {
            rootClass.ui.ToolTip.close();
        }


    }
}//package Main.Aqw.LPF

