﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//uProto

package 
{
    import flash.display.MovieClip;

    public dynamic class uProto extends MovieClip 
    {

        public var t1:MovieClip;

        public function uProto()
        {
            addFrameScript(0, this.frame1, 100, this.frame101);
        }

        internal function frame1():*
        {
            stop();
        }

        internal function frame101():*
        {
            try
            {
                if (parent != null)
                {
                    parent.removeChild(this);
                };
            }
            catch(e:Error)
            {
            };
            stop();
        }


    }
}//package 

