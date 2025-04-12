// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcQuestpopup

package 
{
    import flash.display.MovieClip;
    import Main.Controller.*;

    public dynamic class mcQuestpopup extends MovieClip 
    {

        public var fx2:MovieClip;
        public var cnt:MovieClip;

        public function mcQuestpopup()
        {
            addFrameScript(124, this.frameEnd);
            this.x = 360;
            this.y = 392;
        }

        public function frameEnd():void
        {
            UIController.close("quest_popup");
            stop();
        }


    }
}//package 

