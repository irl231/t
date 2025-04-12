// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcQFrame_1033

package Game_fla
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class mcQFrame_1033 extends MovieClip 
    {

        public var aMask:MovieClip;
        public var bMask:MovieClip;
        public var qList:MovieClip;
        public var strTitle:TextField;
        public var bg:mcQFrame_523;
        public var core:MovieClip;
        public var scr:MovieClip;
        public var btns:MovieClip;
        public var mc:*;
        private var qFrameMC:QFrameMC = QFrameMC(parent);

        public function mcQFrame_1033()
        {
            addFrameScript(4, this.frame5, 9, this.frame10, 10, this.frame11, 14, this.frame15, 21, this.frame22, 35, this.frame36, 46, this.frame47, 52, this.frame53, 57, this.frame58, 66, this.frame67);
        }

        private function frame5():void
        {
            stop();
        }

        private function frame10():void
        {
            this.qFrameMC.showQuestList();
            this.bg.resizeTo(326, 379);
        }

        private function frame11():void
        {
            stop();
        }

        private function frame15():void
        {
            this.qFrameMC.showQuestList();
        }

        private function frame22():void
        {
            stop();
        }

        private function frame36():void
        {
            this.qFrameMC.showQuestDetail();
            this.bg.resizeTo(326, 379);
        }

        private function frame47():void
        {
            stop();
        }

        private function frame53():void
        {
            stop();
        }

        private function frame58():void
        {
            this.qFrameMC.killDetailUI();
        }

        private function frame67():void
        {
            gotoAndPlay(((this.qFrameMC.qData != null) ? "detail" : "list"));
        }


    }
}//package Game_fla

