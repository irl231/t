// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Rarity

package Main
{
    import flash.filters.*;

    public class Rarity 
    {

        public static var rarities:Object = {};
        public static var raritiesGlow:Array = null;


        public static function init(data:Object):void
        {
            var rarity:Object;
            rarities = data;
            raritiesGlow = null;
            raritiesGlow = [];
            raritiesGlow.push(new GlowFilter(0, 1, 8, 8, 2, 1, false, false));
            for each (rarity in rarities)
            {
                raritiesGlow.push(new GlowFilter(rarity.ColorDecimal, 1, 8, 8, 2, 1, false, false));
            };
        }

        public static function HTML(rarity:int):String
        {
            return ((rarities[rarity] == undefined) ? "" : rarities[rarity].HTML);
        }

        public static function ColorDecimal(rarity:int):Number
        {
            return ((rarities[rarity] == undefined) ? 0xFFFFFF : rarities[rarity].ColorDecimal);
        }


    }
}//package Main

