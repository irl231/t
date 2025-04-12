// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.actBar_312

package Game_fla
{
    import flash.display.MovieClip;

    public dynamic class actBar_312 extends MovieClip 
    {

        public var shp:MovieClip;

        public function actBar_312()
        {
            addFrameScript(1, this.frame2, 29, this.frame30);
        }

        internal function frame2():*
        {
            stop();
        }

        internal function frame30():*
        {
            gotoAndPlay("pulse");
        }


    }
}//package Game_fla

