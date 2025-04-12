// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Face_971

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Face_971 extends MovieClip 
    {

        public function Face_971()
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

