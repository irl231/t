// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//RandomNumber

package 
{
    public class RandomNumber 
    {

        internal const MAX_RATIO:Number = 4.6566128752458E-10;
        internal const NEGA_MAX_RATIO:Number = -(MAX_RATIO);

        private var r:int;
        private var randNum:Number;

        public function RandomNumber()
        {
            this.r = (Math.random() * int.MAX_VALUE);
            super();
        }

        public function rand(_arg1:Number=0, _arg2:Number=1):Number
        {
            this.randNum = ((this.XORandom() * (_arg2 - _arg1)) + _arg1);
            return ((this.randNum < _arg2) ? this.randNum : _arg2);
        }

        private function XORandom():Number
        {
            this.r = (this.r ^ (this.r << 21));
            this.r = (this.r ^ (this.r >>> 35));
            this.r = (this.r ^ (this.r << 4));
            if (this.r > 0)
            {
                return (this.r * this.MAX_RATIO);
            };
            return (this.r * this.NEGA_MAX_RATIO);
        }

        public function newSeed():void
        {
            this.r = (Math.random() * int.MAX_VALUE);
        }


    }
}//package 

