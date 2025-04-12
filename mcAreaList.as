// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcAreaList

package 
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class mcAreaList extends MovieClip 
    {

        public var cntMask:MovieClip;
        public var cnt:MovieClip;
        public var title:MovieClip;

        public function mcAreaList()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 4, this.frame5, 19, this.frame20, 24, this.frame25);
        }

        internal function frame1():*
        {
            this.title.gotoAndStop(1);
        }

        internal function frame2():*
        {
            stop();
        }

        internal function frame5():*
        {
            this.title.gotoAndPlay("in");
            MovieClip(Game.root).areaListGet();
        }

        internal function frame20():*
        {
            stop();
        }

        internal function frame25():*
        {
            this.title.gotoAndPlay("out");
        }


    }
}//package 

