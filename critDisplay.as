// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//critDisplay

package 
{
    import flash.display.MovieClip;
    import flash.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.filters.*;
    import flash.utils.*;
    import flash.net.*;
    import flash.errors.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.net.drm.*;
    import flash.text.ime.*;

    public dynamic class critDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function critDisplay()
        {
            addFrameScript(24, this.frame25);
        }

        internal function frame25():*
        {
            try
            {
                MovieClip(parent).removeChild(this);
            }
            catch(e)
            {
            };
            stop();
        }


    }
}//package 

