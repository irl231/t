﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//hitDisplay

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

    public dynamic class hitDisplay extends MovieClip 
    {

        public var t:MovieClip;

        public function hitDisplay()
        {
            addFrameScript(19, this.frame20);
        }

        internal function frame20():*
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

