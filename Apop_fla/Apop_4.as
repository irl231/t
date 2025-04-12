// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Apop_fla.Apop_4

package Apop_fla
{
    import flash.display.MovieClip;

    public dynamic class Apop_4 extends MovieClip 
    {

        public var npc:MovieClip;

        public function Apop_4():void
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 9, this.frame10, 27, this.frame28, 30, this.frame31, 37, this.frame38, 45, this.frame46, 53, this.frame54, 56, this.frame57, 63, this.frame64, 71, this.frame72);
        }

        private function frame1():void
        {
            this.npc.visible = false;
        }

        private function frame2():void
        {
            stop();
        }

        private function frame10():void
        {
            this.npc.visible = true;
        }

        private function frame28():void
        {
            stop();
        }

        private function frame31():void
        {
            this.npc.visible = true;
        }

        private function frame38():void
        {
            gotoAndPlay("init");
        }

        private function frame46():void
        {
            this.npc.visible = true;
        }

        private function frame54():void
        {
            stop();
        }

        private function frame57():void
        {
            this.npc.visible = true;
        }

        private function frame64():void
        {
            gotoAndPlay("init");
        }

        private function frame72():void
        {
            gotoAndStop("hold");
        }


    }
}//package Apop_fla

