// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.game_1_mcNotificationWrapper_2

package Game_fla
{
    import flash.display.MovieClip;

    public dynamic class game_1_mcNotificationWrapper_2 extends MovieClip 
    {

        public var mcNoticeBubble:MovieClip;

        public function game_1_mcNotificationWrapper_2()
        {
            addFrameScript(0, this.frame, 59, this.frame);
        }

        public function notify(message:String):void
        {
            this.mcNoticeBubble.strNotice.htmlText = message;
            gotoAndPlay(3);
            visible = true;
        }

        private function frame():void
        {
            visible = false;
            stop();
        }


    }
}//package Game_fla

