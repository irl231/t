// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//coinsDisplay

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class coinsDisplay extends MovieClip 
    {

        public var tMask:MovieClip;
        public var t:MovieClip;

        public function coinsDisplay()
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

