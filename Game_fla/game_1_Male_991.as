// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.game_1_Male_991

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class game_1_Male_991 extends MovieClip 
    {

        public function game_1_Male_991()
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

