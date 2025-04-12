// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Model.Item

package Main.Model
{
    import __AS3__.vec.Vector;
    import flash.filters.GlowFilter;
    import __AS3__.vec.*;
    import Main.*;

    public class Item extends Model 
    {

        public var ItemID:int;
        public var iQty:int = 1;
        public var bCoins:Boolean;
        public var bHouse:Boolean = false;
        public var bPTR:Boolean;
        public var bStaff:Boolean;
        public var bTemp:Boolean;
        public var bUpg:Boolean;
        public var bSpecial:Boolean;
        public var bTrade:Boolean;
        public var bSellable:Boolean;
        public var iCost:int;
        public var iDPS:int = -1;
        public var iLvl:int = -1;
        public var iQSindex:int;
        public var iQSvalue:int;
        public var iRng:int = -1;
        public var iRty:int;
        public var iStk:int;
        public var sDesc:String;
        public var sES:String;
        public var sElmt:String;
        public var sFile:String;
        public var sIcon:String;
        public var sLink:String;
        public var sMeta:String;
        public var sName:String;
        public var sReqQuests:String;
        public var sType:String;
        public var effects:String = "";
        public var iEnhLvl:int = -1;
        public var PatternID:int = -1;
        public var EnhID:int = -1;
        public var iEnh:int = -1;
        public var EnhLvl:int = -1;
        public var EnhPatternID:int = -1;
        public var EnhRty:int = -1;
        public var EnhRng:int;
        public var EnhDPS:int = -1;
        public var bWear:Boolean = false;
        public var bBank:Boolean = false;
        public var CharItemID:int;
        public var Qty:int;
        public var iQtyRemain:int;
        public var iHrs:int = -1;
        public var bEquip:Boolean = false;
        public var iClass:int;
        public var iReqCP:int;
        public var iReqGuildLevel:int;
        public var iReqRep:int;
        public var FactionID:int;
        public var sRank:String;
        public var sClass:String;
        public var sFaction:String;
        public var sQuest:String;
        public var ShopItemID:int;
        public var dPurchase:String;
        public var turnin:Vector.<Item> = new Vector.<Item>();
        public var AuctionID:int = 0;
        public var Duration:String;
        public var Player:String;
        public var Gold:Number;
        public var Coins:Number;
        public var auctionGold:int;
        public var auctionCoins:int;
        public var Quantity:int;
        public var bSold:Boolean = false;
        public var color:Object = new Object();
        public var iHue:int = 0;
        public var iBrightness:int = 0;
        public var iContrast:int = 0;
        public var iSaturation:int = 0;
        public var iReset:int = 0;
        public var TradeID:int;
        public var iType:int;
        public var iRate:int;
        public var c:*;
        private var _rarity:String;

        public function Item(obj:Object=null)
        {
            var itemObj:Object;
            super(obj);
            for each (itemObj in obj.turnin)
            {
                this.turnin.push(new Item(itemObj));
            };
            this._rarity = Rarity.rarities[this.iRty].Name;
        }

        public function get rarityGlow():GlowFilter
        {
            return ((Rarity.raritiesGlow[this.iRty] != undefined) ? Rarity.raritiesGlow[this.iRty] : Rarity.raritiesGlow[0]);
        }

        public function get rarity():String
        {
            return (this._rarity);
        }

        public function get iconBySlot():String
        {
            switch (this.sES.toLowerCase())
            {
                case "weapon":
                    return ("iwsword");
                case "back":
                case "ba":
                    return ("iicape");
                case "head":
                case "he":
                    return ("iihelm");
                case "armor":
                case "ar":
                    return ("iiclass");
                case "class":
                    return ("iiclass");
                case "pet":
                case "pe":
                    return ("iipet");
                default:
                    return ("iibag");
            };
        }

        public function get iconClass():*
        {
            var icon:String;
            switch (this.sType.toLowerCase())
            {
                case "enhancement":
                    icon = this.iconBySlot;
                    break;
                case "serveruse":
                case "clientuse":
                    icon = (((this.sFile.length > 0) && (!(Game.root.world.getClass(this.sFile) == null))) ? this.sFile : this.sIcon);
                    break;
                default:
                    switch (this.sIcon)
                    {
                        case null:
                        case "":
                        case "none":
                            icon = ((this.sLink.toLowerCase() != "none") ? "iidesign" : "iibag");
                            break;
                        default:
                            icon = this.sIcon;
                    };
            };
            var iconClass:Class = Game.root.world.getClass(icon);
            return ((iconClass == null) ? new (Game.root.world.getClass("iibag"))() : new (iconClass)());
        }

        public function get cost():Number
        {
            var cost:int;
            if (this.iHrs < 24)
            {
                cost = int(Math.ceil(((this.iCost * 9) / 10)));
            }
            else
            {
                cost = int(Math.ceil((this.iCost / 4)));
            };
            return (cost);
        }


    }
}//package Main.Model

