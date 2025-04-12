// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcPadName

package 
{
    import flash.display.MovieClip;

    public dynamic class mcPadName extends MovieClip 
    {

        public var cnt:MovieClip;
        public var isOn:*;

        public function mcPadName()
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 9, this.frame10, 19, this.frame20);
        }

        internal function frame1():*
        {
            visible = false;
            this.isOn = false;
            stop();
        }

        internal function frame5():*
        {
            visible = true;
        }

        internal function frame10():*
        {
            stop();
        }

        internal function frame20():*
        {
            visible = false;
            stop();
        }


    }
}//package 

