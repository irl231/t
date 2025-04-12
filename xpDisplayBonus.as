// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//xpDisplayBonus

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class xpDisplayBonus extends MovieClip 
    {

        public var t:MovieClip;

        public function xpDisplayBonus()
        {
            addFrameScript(39, this.frame40);
        }

        internal function frame40():*
        {
            MovieClip(parent).removeChild(this);
            stop();
        }


    }
}//package 

