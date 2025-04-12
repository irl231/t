// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcLevelup

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class mcLevelup extends MovieClip 
    {

        public var cnt:MovieClip;

        public function mcLevelup()
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

