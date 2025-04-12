// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//HouseItemHandleMC

package 
{
    import flash.display.MovieClip;

    public dynamic class HouseItemHandleMC extends MovieClip 
    {

        public var bCancel:MovieClip;
        public var frame:MovieClip;
        public var bDelete:MovieClip;
        public var mDown:Boolean;

        public function HouseItemHandleMC()
        {
            visible = false;
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.mDown = false;
        }


    }
}//package 

