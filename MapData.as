// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//MapData

package 
{
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.*;
    import flash.utils.*;

    public class MapData 
    {

        private var qID:int;
        private var qAccepted:Boolean;
        private var qTimer:Timer;


        private static function isOneTimeQuestDone(quest:*):Boolean
        {
            return ((quest.bOnce == 1) && ((quest.iSlot < 0) || (Game.root.world.getQuestValue(quest.iSlot) >= quest.iValue)));
        }


        public function initSession(sessionName:String):void
        {
            if (Game.root.world.objSession[Game.root.world.strMapName] == null)
            {
                Game.root.world.objSession[Game.root.world.strMapName] = [];
            };
            Game.root.world.objSession[Game.root.world.strMapName][sessionName] = false;
        }

        public function initObjSess(sessionNames:Array, sessionQuantities:Array):void
        {
            var namesLength:int;
            var i:int;
            var j:int;
            if (Game.root.world.objSession[Game.root.world.strMapName] == null)
            {
                Game.root.world.objSession[Game.root.world.strMapName] = [];
                namesLength = sessionNames.length;
                i = 0;
                while (i < namesLength)
                {
                    j = 0;
                    while (j < sessionQuantities[i])
                    {
                        this.initSession((sessionNames[i] + j));
                        j++;
                    };
                    i++;
                };
            };
        }

        public function updateSessArray(sessionName:String, sessionKey:int=0):void
        {
            Game.root.world.objSession[Game.root.world.strMapName][(sessionName + sessionKey)] = true;
        }

        public function checkSess(sessionName:String, sessionKey:int=0):*
        {
            return ((Game.root.world.objSession.hasOwnProperty(Game.root.world.strMapName)) && (Game.root.world.objSession[Game.root.world.strMapName][(sessionName + sessionKey)]));
        }

        public function checkSessArr(sessionName:String, sessionKeys:Array):Boolean
        {
            var checkSess:Boolean = this.checkSess(sessionName, (sessionKeys[0] - 1));
            var arrLength:int = sessionKeys.length;
            var i:int = 1;
            while (i < arrLength)
            {
                checkSess = ((checkSess) && (this.checkSess(sessionName, (sessionKeys[i] - 1))));
                i++;
            };
            return (checkSess);
        }

        public function completeQuest(questId:int, accepted:Boolean=false):void
        {
            var quest:*;
            if (accepted)
            {
                if (Game.root.world.isQuestInProgress(questId))
                {
                    quest = Game.root.world.questTree[questId];
                    if (quest == null)
                    {
                        Game.root.world.tryQuestComplete(questId);
                    }
                    else
                    {
                        if ((((!(isOneTimeQuestDone(quest))) && (!(quest.status == null))) && (quest.status == "c")))
                        {
                            Game.root.world.tryQuestComplete(questId);
                        };
                    };
                };
            }
            else
            {
                Game.root.world.tryQuestComplete(questId);
            };
        }

        public function delayedTurnin(questId:int, accepted:Boolean=false):void
        {
            this.qID = questId;
            this.qAccepted = accepted;
            this.qTimer = new Timer(3000, 1);
            this.qTimer.addEventListener(TimerEvent.TIMER, this.onQuestTimer, false, 0, true);
            this.qTimer.start();
        }

        private function onQuestTimer(_arg1:TimerEvent):void
        {
            this.qTimer.stop();
            this.qTimer.removeEventListener(TimerEvent.TIMER, this.onQuestTimer);
            this.completeQuest(this.qID, this.qAccepted);
        }


    }
}//package 

