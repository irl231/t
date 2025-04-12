// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//avoidDisplay

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public class avoidDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function avoidDisplay()
        {
            addFrameScript(19, this.frame20);
        }

        private function frame20():void
        {
            if (((parent) && (parent.contains(this))))
            {
                MovieClip(parent).removeChild(this);
            };
            stop();
        }


    }
}//package 

