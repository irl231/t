// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcPVPPanel_481

package Game_fla
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class mcPVPPanel_481 extends MovieClip 
    {

        public var bExit:MovieClip;
        public var msg:TextField;
        public var bJoin:MovieClip;
        public var title:TextField;
        private var panel:PVPPanelMC;

        public function mcPVPPanel_481()
        {
            addFrameScript(0, this.frame1, 9, this.frame10, 19, this.frame20, 29, this.frame30, 39, this.frame40, 49, this.frame50, 60, this.frame61);
            this.panel = PVPPanelMC(parent.parent);
        }

        private function frame1():void
        {
            stop();
        }

        private function frame10():void
        {
            this.panel.updateBody();
            stop();
        }

        private function frame20():void
        {
            this.panel.updateBody();
            stop();
        }

        private function frame30():void
        {
            this.panel.updateBody();
            stop();
        }

        private function frame40():void
        {
            this.panel.updateBody();
            stop();
        }

        private function frame50():void
        {
            this.panel.updateBody();
            stop();
        }

        private function frame61():void
        {
            this.panel.updateBody();
            stop();
        }


    }
}//package Game_fla

