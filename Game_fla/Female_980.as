// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Female_980

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Female_980 extends MovieClip 
    {

        public function Female_980()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            try
            {
                MovieClip(this.stage.getChildAt(0)).mcSetColor(this, "Skin", "Darker");
            }
            catch(e:Error)
            {
            };
        }


    }
}//package Game_fla

