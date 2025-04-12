// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.Weather.Afternoon1MC

package FoM.Weather
{
    import flash.display.MovieClip;

    public dynamic class Afternoon1MC extends MovieClip 
    {

        public var rootClass:Game;

        public function Afternoon1MC(game:Game)
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

