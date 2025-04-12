// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//iconFlare

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class iconFlare extends MovieClip 
    {

        public var bg:MovieClip;

        public function iconFlare()
        {
            addFrameScript(8, this.frame9);
        }

        internal function frame9():*
        {
            MovieClip(parent).removeChild(this);
            stop();
        }


    }
}//package 

