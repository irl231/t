// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.cMenu_536

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class cMenu_536 extends MovieClip 
    {

        public var bg:MovieClip;
        public var mHi:MovieClip;
        public var iproto:cProto;

        public function cMenu_536()
        {
            addFrameScript(0, this.frame1, 19, this.frame20);
        }

        private function frame1():void
        {
            stop();
        }

        private function frame20():void
        {
            MovieClip(parent).gotoAndPlay("out");
            gotoAndStop("hold");
        }


    }
}//package Game_fla

