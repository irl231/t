// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//cutsceneHandler

package 
{
    import flash.utils.Timer;
    import flash.display.MovieClip;
    import flash.events.TimerEvent;
    import flash.events.*;
    import flash.utils.*;

    public class cutsceneHandler 
    {

        private var rootClass:Game;
        private var strMap:String;
        private var strFrame:String = "";
        private var strPad:String;
        private var changeMap:Boolean = false;
        private var strFile:String;
        private var cutFrame:String;
        private var cutPad:String;
        private var cutTimer:Timer;

        public function cutsceneHandler(_arg1:MovieClip)
        {
            this.rootClass = _arg1;
        }

        public function setCutsceneTarget(_arg1:String, _arg2:String, _arg3:String=""):void
        {
            this.strFrame = _arg1;
            this.strPad = _arg2;
            this.strMap = _arg3;
            this.changeMap = (!(_arg3 == ""));
        }

        public function transfer():void
        {
            if (this.changeMap)
            {
                this.rootClass.world.gotoTown(this.strMap, this.strFrame, this.strPad);
            }
            else
            {
                if (this.strFrame != "")
                {
                    this.rootClass.world.moveToCell(this.strFrame, this.strPad);
                };
            };
            this.rootClass.clearExternamSWF();
        }

        public function showCutscene(_arg1:String, _arg2:Boolean=false, _arg3:String="Cut1", _arg4:String="Left"):void
        {
            this.strFile = _arg1;
            this.cutFrame = _arg3;
            this.cutPad = _arg4;
            if (_arg2)
            {
                this.cutTimer = new Timer(3000, 1);
                this.cutTimer.addEventListener(TimerEvent.TIMER, this.onCutTimer, false, 0, true);
                this.cutTimer.start();
            }
            else
            {
                this.rootClass.loadExternalSWF(this.strFile);
                this.rootClass.world.moveToCell(this.cutFrame, this.cutPad);
            };
        }

        private function onCutTimer(_arg1:TimerEvent):void
        {
            this.cutTimer.stop();
            this.cutTimer.removeEventListener(TimerEvent.TIMER, this.onCutTimer);
            this.rootClass.loadExternalSWF(this.strFile);
            this.rootClass.world.moveToCell(this.cutFrame, this.cutPad);
        }


    }
}//package 

