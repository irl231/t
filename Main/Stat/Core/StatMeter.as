// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Stat.Core.StatMeter

package Main.Stat.Core
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.FocusEvent;
    import flash.events.*;

    public class StatMeter extends MovieClip 
    {

        public var txtTitle:TextField;
        public var txtValue:TextField;
        public var txtInput:TextField;
        public var btnLeft:SimpleButton;
        public var btnRight:SimpleButton;
        public var mcBar:MovieClip;
        public var mcParent:MovieClip = parent;
        public var strAttribute:String;
        public var intIncreaseValue:int = 0;
        public var intValue:int = 0;
        public var oldValue:int = 0;

        public function StatMeter()
        {
            this.btnRight.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.btnLeft.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.txtInput.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut, false, 0, true);
            this.txtInput.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn, false, 0, true);
            this.txtInput.restrict = "0-9";
        }

        public function load(attribute:String):void
        {
            this.strAttribute = attribute;
            this.intValue = Game.root.world.myAvatar.objData.stats[attribute];
            this.intIncreaseValue = 0;
            this.txtTitle.text = attribute.toUpperCase();
            this.txtInput.text = 0;
            this.txtValue.text = this.intValue.toString();
            this.mcBar.bg.scaleX = (this.intValue / this.mcParent.intValueMax);
            this.mcBar.bgAdd.scaleX = (this.intValue / this.mcParent.intValueMax);
        }

        public function modify(value:int, isPermanent:Boolean):void
        {
            this.intIncreaseValue = value;
            var total:* = (this.intValue + this.intIncreaseValue);
            this.txtInput.text = total.toString();
            this.mcBar.bgAdd.scaleX = (total / this.mcParent.intValueMax);
            if (isPermanent)
            {
                this.mcBar.bg.scaleX = (total / this.mcParent.intValueMax);
            };
            this.mcParent.computeStat();
        }

        private function onClick(event:MouseEvent):void
        {
            var valueAdd:*;
            var valueReduce:*;
            switch (event.currentTarget.name)
            {
                case "btnRight":
                    valueAdd = (this.intIncreaseValue + 1);
                    if (this.validate(valueAdd, true))
                    {
                        this.modify(valueAdd, false);
                    };
                    break;
                case "btnLeft":
                    valueReduce = (this.intIncreaseValue - 1);
                    if (this.validate(valueReduce, false))
                    {
                        this.modify(valueReduce, false);
                    };
                    break;
            };
        }

        private function validate(value:int, isAdd:Boolean):Boolean
        {
            var total:* = (this.intValue + value);
            if (isAdd)
            {
                if (total > this.mcParent.intValueMax)
                {
                    Game.root.MsgBox.notify("You have already maxed out this stat point.");
                    return (false);
                };
                if (this.mcParent.intStatTotal <= 0)
                {
                    Game.root.MsgBox.notify("You don't have enough stat point.");
                    return (false);
                };
            }
            else
            {
                if (this.intIncreaseValue <= 0)
                {
                    Game.root.MsgBox.notify("You don't have an added stat point.");
                    return (false);
                };
            };
            return (true);
        }

        private function onFocusIn(event:FocusEvent):void
        {
            this.oldValue = this.txtInput.text;
        }

        private function onFocusOut(event:FocusEvent):void
        {
            var value:* = this.txtInput.text;
            if (this.oldValue == value)
            {
                return;
            };
            if (((value > this.oldValue) && ((this.mcParent.intStatTotal <= 0) || (this.mcParent.validateStat(value, this.strAttribute) < 0))))
            {
                Game.root.MsgBox.notify("You don't have enough stat point.");
                this.modify(0, false);
                return;
            };
            this.modify(((this.validate(value, (value >= this.oldValue))) ? value : 0), false);
        }


    }
}//package Main.Stat.Core

