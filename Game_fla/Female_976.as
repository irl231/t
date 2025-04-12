// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Female_976

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Female_976 extends MovieClip 
    {

        public function Female_976()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            try
            {
                MovieClip(this.stage.getChildAt(0)).mcSetColor(this, "Eye", "Light");
            }
            catch(e:Error)
            {
            };
        }


    }
}//package Game_fla

