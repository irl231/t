// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//DFrameMCcnt

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.display.SimpleButton;

    public dynamic class DFrameMCcnt extends MovieClip 
    {

        public var strQ:TextField;
        public var icon:MovieClip;
        public var fx1:MovieClip;
        public var strRate:TextField;
        public var bg:MovieClip;
        public var fadedAC:Sprite;
        public var strName:TextField;
        public var strType:TextField;
        public var btnEye:SimpleButton;

        public function DFrameMCcnt()
        {
            addFrameScript(0, this.frame1);
        }

        private function frame1():void
        {
            if (this.strRate.text == "vendor trash")
            {
                this.strRate.visible = false;
            };
        }


    }
}//package 

