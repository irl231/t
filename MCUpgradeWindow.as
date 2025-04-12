// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MCUpgradeWindow

package 
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    public dynamic class MCUpgradeWindow extends MovieClip 
    {

        public var btnClose2:SimpleButton;
        public var btnBuy:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtBody:TextField;
        public var txtHrs:TextField;
        public var rootClass:Game;
        public var iDiff:Number;
        public var iHrs:int;
        public var renewDate:String;
        public var iRemain:int;

        public function MCUpgradeWindow()
        {
            addFrameScript(0, this.frame1);
        }

        internal function frame1():*
        {
            this.rootClass = stage.getChildAt(0);
            this.iDiff = ((this.rootClass.date_server.getTime() - this.rootClass.world.myAvatar.objData.dCreated.getTime()) / 1000);
            this.iHrs = (this.iDiff / (60 * 60));
            stop();
        }


    }
}//package 

