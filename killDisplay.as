// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//killDisplay

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public class killDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function killDisplay()
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

