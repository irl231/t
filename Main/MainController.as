// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.MainController

package Main
{
    import flash.geom.ColorTransform;
    import __AS3__.vec.Vector;
    import Main.Model.Item;
    import flash.display.MovieClip;
    import flash.events.Event;
    import __AS3__.vec.*;
    import Main.Model.*;
    import flash.display.*;
    import flash.geom.*;

    public class MainController 
    {

        public static const defaultCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        public static const darkCT:ColorTransform = new ColorTransform(0.4, 0.4, 0.4, 1, -20, -20, -20, 0);
        public static const stats:Array = ["STR", "END", "DEX", "INT", "WIS", "LCK"];
        public static const orderedStats:Array = ["STR", "INT", "DEX", "WIS", "END", "LCK"];
        public static var colorCT:Object = {
            "redCT":new ColorTransform(1, 1, 1, 1, 96, 0, 0, 0),
            "greenCT":new ColorTransform(1, 1, 1, 1, 0, 96, 0, 0),
            "blueCT":new ColorTransform(1, 1, 1, 1, 0, 0, 96, 0),
            "whiteCT":new ColorTransform(1, 1, 1, 1, 64, 64, 64, 0),
            "orangeCT":new ColorTransform(1, 1, 1, 1, 96, 36, 0, 0),
            "yellowCT":new ColorTransform(1, 1, 1, 1, 96, 64, 24, 0),
            "purpleCT":new ColorTransform(1, 1, 1, 1, 96, 0, 96, 0),
            "greyCT":new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0),
            "blackoutCT":new ColorTransform(0, 0, 0, 1, 0, 0, 0, 0),
            "greyoutCT":new ColorTransform(0, 0, 0, 1, 40, 40, 40, 0)
        };
        public static const tips:Array = ["Never give you password to ANYONE. AQW staff will never ask for it.", "Never share your password or your account with anyone.", "Sharing accounts is against the rules and might get you banned!", "Strength improves your chance of a critical strike for melee classes.", "Keep your enhancements up to date!", "Remember to rest in between battles!", "Intellect increases Magic Power and boosts magical damage and crit for caster classes.", "Wisdom only increases evasion for melee classes.", "Make sure yo read your tool tips for each skill you unlock!", "Mayonnaise should never be heated. It might make you ill!", "We were all noobs once. Help out new players!", "Hero get access to special Hero-only areas, classes and items!", "Don't stare at the sun.", "If someone is misbehaving, click on their character portrait to report them!", "Go easy on the carbs unless you move a lot.", '"A lot" is two words, not one.', "You can get more item storage from the BANK!", "You can store items you got with coins for FREE in the bank!", "Try having breakfast for dinner. You can thank me later.", "Clown pants are not heroic.", "Lost? You can always /join Yulgar", "Trying to catch up with a friend? Type /goto <player name>", "You can hide the chat panel by clicking on the arrow on your interface.", "If someone is being rude you can IGNORE them by clicking on their character portrait.", "To Reply to a private message, just type /r and hit ENTER!", "Gain experience, gold and rep by completing quests.", "You can buy more space in your backpack.", "You can use potions or food in battle if you equip it!", "Always read the News to find out what's coming next!", "Game Moderators, Developers and Staff always have a Administrator/Moderator name above their head.", "Do not share your account information with ANYONE, no matter what they promise you.", "Never give your email password to anyone!", "Hael's left sock might be in your backpack right now!", "Don't give up now, you're just about to win!", "YOU are the only Hero who can save us. You must return to battle!", "Never leave home without an extra HP potion!"];


        public static function contains(value:String, required:String):Boolean
        {
            return (value.indexOf(required) >= 0);
        }

        public static function arrToVectorItem(items:Array):Vector.<Item>
        {
            var vectorItems:Vector.<Item> = new Vector.<Item>();
            var i:int;
            while (i < items.length)
            {
                vectorItems.push(((items[i] is Item) ? items[i] : new Item(items[i])));
                i++;
            };
            return (vectorItems);
        }

        public static function getCatCT(category:String):ColorTransform
        {
            switch (category)
            {
                case "M1":
                    return (colorCT.redCT);
                case "M2":
                    return (colorCT.greenCT);
                case "M3":
                    return (colorCT.yellowCT);
                case "C1":
                    return (colorCT.blueCT);
                case "C2":
                    return (colorCT.whiteCT);
                case "C3":
                    return (colorCT.orangeCT);
                case "S1":
                    return (colorCT.purpleCT);
                default:
                    return (colorCT.greyCT);
            };
        }

        public static function modal(body:String, callback:Function, params:Object, glow:String=null, btns:String="dual", greedy:Boolean=false, qtySel:Object=null):void
        {
            ModalMC(Game.root.ui.ModalStack.addChild(new ModalMC())).init({
                "strBody":body,
                "callback":callback,
                "params":params,
                "glow":glow,
                "btns":btns,
                "greedy":greedy,
                "qtySel":qtySel
            });
        }

        public static function getFullStatName(stat:String):String
        {
            switch (stat)
            {
                case "STR":
                    return ("Strength");
                case "INT":
                    return ("Intellect");
                case "DEX":
                    return ("Dexterity");
                case "WIS":
                    return ("Wisdom");
                case "END":
                    return ("Endurance");
                case "LCK":
                    return ("Luck");
                default:
                    return ("");
            };
        }

        public static function formatNumber(value:Number):String
        {
            return (String(value).replace(((String(value).indexOf(".") > -1) ? /(?<=\d)(?=(\d\d\d)+(?!\d)\.\d*)/g : /(?<=\d)(?=(\d\d\d)+(?!\d))/g), ",").replace(/,{2,}/g, ","));
        }

        public static function setCT(mc:MovieClip, color:uint):void
        {
            var ct:ColorTransform = mc.transform.colorTransform;
            ct.color = color;
            mc.transform.colorTransform = ct;
        }

        public static function linearTween(val1:Number, val2:Number, val3:Number, val4:Number):Number
        {
            return (((val3 * val1) / val4) + val2);
        }

        public static function dEF(event:Event):void
        {
            var list:MovieClip;
            var scr:MovieClip;
            var main:MovieClip;
            list = MovieClip(event.currentTarget);
            scr = MovieClip(list.parent).scr;
            main = MovieClip(list.parent.parent);
            var number:Number = (int(((-(scr.h.y) / main.hRun) * main.dRun)) + list.oy);
            list.y = ((Math.abs((number - list.y)) > 0.2) ? (list.y + ((number - list.y) / 1.1)) : number);
        }

        public static function hasLabel(label:String, movieClip:MovieClip):Boolean
        {
            var currentLabels:Array = movieClip.currentLabels;
            var labelLength:int = movieClip.currentLabels.length;
            var i:int;
            while (i < labelLength)
            {
                if (currentLabels[i].name == label)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public static function lookAtValue(value:String, index:int):Number
        {
            return (parseInt(value.charAt(index), 36));
        }

        public static function updateValue(value:String, index:int, newValue:Number):String
        {
            var updatedChar:String;
            if (((newValue >= 0) && (newValue < 10)))
            {
                updatedChar = String(newValue);
            }
            else
            {
                if (((newValue >= 10) && (newValue < 36)))
                {
                    updatedChar = String.fromCharCode((newValue + 55));
                }
                else
                {
                    updatedChar = "0";
                };
            };
            return (setCharAt(value, index, updatedChar));
        }

        private static function setCharAt(value:String, index:int, newChar:String):String
        {
            return ((value.substring(0, index) + newChar) + value.substring((index + 1), value.length));
        }

        public static function formatNumberWithSuffix(number:Number):String
        {
            var suf:String;
            var formattedNumber:String;
            var scale:Number;
            if (number < 100000)
            {
                return (String(number));
            };
            var suffix:String = "";
            var suffixes:Object = {
                "E":1000000000000000000,
                "P":1000000000000000,
                "T":1000000000000,
                "B":0x3B9ACA00,
                "M":1000000,
                "K":1000
            };
            for each (suf in ["E", "P", "T", "B", "M", "K"])
            {
                scale = suffixes[suf];
                if (number >= scale)
                {
                    number = (number / scale);
                    suffix = suf;
                    break;
                };
            };
            switch (suffix)
            {
                case "E":
                case "P":
                case "T":
                case "B":
                    formattedNumber = number.toFixed(2);
                    break;
                case "M":
                    formattedNumber = number.toFixed(1);
                    break;
                case "K":
                default:
                    formattedNumber = number.toFixed(0);
            };
            formattedNumber = rtrim(formattedNumber, "0");
            formattedNumber = rtrim(formattedNumber, ".");
            return (formattedNumber + suffix);
        }

        private static function rtrim(input:String, trimChar:String):String
        {
            var endIndex:int = (input.length - 1);
            while (((endIndex >= 0) && (input.charAt(endIndex) == trimChar)))
            {
                endIndex--;
            };
            return (input.slice(0, (endIndex + 1)));
        }


    }
}//package Main

