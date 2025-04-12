// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.Weather.Afternoon2MC

package FoM.Weather
{
    import flash.display.MovieClip;

    public dynamic class Afternoon2MC extends MovieClip 
    {

        public var rootClass:Game;

        public function Afternoon2MC(game:Game)
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

