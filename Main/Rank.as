// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Rank

package Main
{
    public class Rank 
    {

        public static const RANKS:Array = [];


        public static function init():void
        {
            var rankExp:int;
            RANKS[0] = 0;
            var i:int = 1;
            while (i < 10)
            {
                rankExp = (Math.pow((i + 1), 3) * 100);
                if (i > 1)
                {
                    RANKS[i] = (rankExp + RANKS[(i - 1)]);
                }
                else
                {
                    RANKS[i] = (rankExp + 100);
                };
                i++;
            };
        }

        public static function getRankFromPoints(points:int):int
        {
            var i:int = 1;
            while (i < RANKS.length)
            {
                if (points < RANKS[i])
                {
                    return (i);
                };
                i++;
            };
            return (10);
        }

        public static function getPointsFromRank(rank:int):int
        {
            switch (rank)
            {
                case 1:
                    return (0);
                case 2:
                    return (900);
                case 3:
                    return (3600);
                case 4:
                    return (10000);
                case 5:
                    return (22500);
                case 6:
                    return (44100);
                case 7:
                    return (78400);
                case 8:
                    return (129600);
                case 9:
                    return (202500);
                case 10:
                    return (302500);
                default:
                    return (-1);
            };
        }


    }
}//package Main

