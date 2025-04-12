// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.mcSkillUp_527

package Game_fla
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;

    public dynamic class mcSkillUp_527 extends MovieClip 
    {

        public var rootClass:MovieClip;
        public var c:int;
        public var t:int;
        private var arrStats:Array = ["Strength", "Intellect", "Endurance", "Dexterity", "Wisdom", "Luck"];

        public function mcSkillUp_527()
        {
            addFrameScript(0, this.frame1, 1, this.frame2, 10, this.frame11, 41, this.frame42);
        }

        public function computeStat():int
        {
            var statName:String;
            var totalAddedStats:int;
            var intStatMax:int = (this.rootClass.world.myAvatar.objData.intLevel * this.rootClass.world.myAvatar.objData.stats.StatPerLevel);
            for each (statName in this.arrStats)
            {
                if (this.rootClass.world.myAvatar.objData.stats.hasOwnProperty(statName))
                {
                    totalAddedStats = (totalAddedStats + this.rootClass.world.myAvatar.objData.stats[statName]);
                };
            };
            return (intStatMax - totalAddedStats);
        }

        public function fOpen():void
        {
            if (this.computeStat() > 0)
            {
                this.gotoAndPlay("in");
            };
        }

        public function fClose():void
        {
            this.gotoAndStop("reset");
        }

        public function onSkillUpClick(_arg1:MouseEvent):void
        {
            this.rootClass.toggleCoreStatPanel();
            this.fClose();
        }

        internal function frame1():*
        {
            this.visible = false;
            this.rootClass = Game.root;
            this.c = 0;
            this.t = 60;
            this.addEventListener(MouseEvent.CLICK, this.onSkillUpClick, false, 0, true);
            this.buttonMode = true;
            stop();
        }

        internal function frame2():*
        {
            this.visible = false;
            stop();
        }

        internal function frame11():*
        {
            this.visible = true;
            this.c = 0;
        }

        internal function frame42():*
        {
            stop();
        }


    }
}//package Game_fla

