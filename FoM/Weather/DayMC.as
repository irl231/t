// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.Weather.DayMC

package FoM.Weather
{
    import flash.display.MovieClip;

    public dynamic class DayMC extends MovieClip 
    {

        public var rootClass:Game;

        public function DayMC(game:Game)
        {
            this.rootClass = game;
            addFrameScript(0, this.frame1);
        }

        private function frame1():void
        {
            stop();
        }


    }
}//package FoM.Weather

