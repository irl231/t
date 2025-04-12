// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Eyebrow_989

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Eyebrow_989 extends MovieClip 
    {

        public function Eyebrow_989()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            try
            {
                MovieClip(this.stage.getChildAt(0)).mcSetColor(this, "Skin", "None");
            }
            catch(e:Error)
            {
            };
        }


    }
}//package Game_fla

