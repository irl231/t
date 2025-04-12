// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.Achievement

package Main.Aqw
{
    public class Achievement 
    {


        public static function getAchievement(value:String, index:int):int
        {
            if (((index < 0) || (index > 31)))
            {
                return (-1);
            };
            var playerValue:* = Game.root.world.myAvatar.objData[value];
            if (playerValue == null)
            {
                return (-1);
            };
            return (((playerValue & Math.pow(2, index)) == 0) ? 0 : 1);
        }

        public static function updateAchievement(valueToSet:int, index:int, value:int):int
        {
            if (value == 0)
            {
                return (valueToSet & (~(int(Math.pow(2, index)))));
            };
            if (value == 1)
            {
                return (valueToSet | int(Math.pow(2, index)));
            };
        }


    }
}//package Main.Aqw

