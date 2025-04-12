// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.Weather.NightMC

package FoM.Weather
{
    import flash.display.MovieClip;

    public dynamic class NightMC extends MovieClip 
    {

        public var rootClass:Game;

        public function NightMC(game:Game)
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

