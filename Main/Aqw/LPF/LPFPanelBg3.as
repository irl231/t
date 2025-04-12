// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelBg3

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    public dynamic class LPFPanelBg3 extends MovieClip 
    {

        public var mcSearch:MovieClip;
        public var btnClose:SimpleButton;
        public var tPane1:TextField;
        public var tTitle:TextField;
        public var tPane2:TextField;
        public var bg:MovieClip;
        public var tSearch:TextField;
        public var tPane3:TextField;
        public var rootClass:Game;

        public function LPFPanelBg3()
        {
            addFrameScript(1, this.frame2);
            super();
        }

        private function frame2():void
        {
            this.tSearch.visible = false;
            this.mcSearch.visible = false;
            Game.root.world.sendLoadBankRequest(["All"]);
            stop();
        }


    }
}//package Main.Aqw.LPF

