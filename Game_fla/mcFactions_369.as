// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcFactions_369

package Game_fla
{
    import flash.display.MovieClip;

    public dynamic class mcFactions_369 extends MovieClip 
    {

        public var fList:MovieClip;
        public var aMask:MovieClip;
        public var bMask:MovieClip;
        public var bg:MovieClip;
        public var scr:MovieClip;

        public function mcFactions_369()
        {
            addFrameScript(4, this.frame5, 9, this.frame10, 17, this.frame18);
        }

        private function frame5():void
        {
            stop();
        }

        private function frame10():void
        {
            FactionsMC(parent).showFactionList();
        }

        private function frame18():void
        {
            stop();
        }


    }
}//package Game_fla

