// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.Weather.SnowMC

package FoM.Weather
{
    import flash.display.MovieClip;

    public dynamic class SnowMC extends MovieClip 
    {

        public var rootClass:Game;

        public function SnowMC(game:Game)
        {
            this.rootClass = game;
            addFrameScript(0, this.frame1);
        }

        private function frame1():void
        {
            var snowflake:SnowFlakeMC;
            var i:int;
            while (i < 200)
            {
                snowflake = new SnowFlakeMC();
                this.addChild(snowflake);
                snowflake.SetInitialProperties();
                i++;
            };
            stop();
        }


    }
}//package FoM.Weather

