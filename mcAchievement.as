// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcAchievement

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class mcAchievement extends MovieClip 
    {

        public var fx2:MovieClip;
        public var cnt:MovieClip;

        public function mcAchievement()
        {
            addFrameScript(122, this.frame123);
        }

        internal function frame123():*
        {
            MovieClip(parent).removeChild(this);
            stop();
        }


    }
}//package 

