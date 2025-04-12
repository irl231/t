// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcAreaList_253

package Game_fla
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class mcAreaList_253 extends MovieClip 
    {

        public var t1:TextField;
        public var bMinMax:MovieClip;

        public function mcAreaList_253()
        {
            addFrameScript(0, this.frame1, 9, this.frame10);
        }

        internal function frame1():*
        {
            this.t1.mouseEnabled = false;
            this.bMinMax.a1.visible = false;
            this.bMinMax.a2.visible = true;
            stop();
        }

        internal function frame10():*
        {
            this.bMinMax.a1.visible = true;
            this.bMinMax.a2.visible = false;
            stop();
        }


    }
}//package Game_fla

