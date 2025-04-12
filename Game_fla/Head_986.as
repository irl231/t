// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Head_986

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Head_986 extends MovieClip 
    {

        public function Head_986()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            try
            {
                MovieClip(this.stage.getChildAt(0)).mcSetColor(this, "Eye", "None");
            }
            catch(e:Error)
            {
            };
        }


    }
}//package Game_fla

