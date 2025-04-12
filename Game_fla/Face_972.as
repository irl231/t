// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Face_972

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Face_972 extends MovieClip 
    {

        public function Face_972()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            try
            {
                MovieClip(this.stage.getChildAt(0)).mcSetColor(this, "Skin", "Dark");
            }
            catch(e:Error)
            {
            };
        }


    }
}//package Game_fla

