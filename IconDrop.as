﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//IconDrop

package 
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.filters.GlowFilter;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.UI.*;
    import flash.filters.*;
    import flash.utils.*;

    public class IconDrop extends MovieClip 
    {

        private var iconTimer:Timer;
        public var rootClass:Game;
        public var border:*;
        private var alertTimer:Timer;
        private var glowFilter:GlowFilter;
        private var alternate:Boolean = false;

        public function IconDrop()
        {
            this.rootClass = Game.root;
            this.buttonMode = true;
            this.addEventListener(MouseEvent.CLICK, this.onBtDrop, false, 0, true);
            this.glowFilter = new GlowFilter(0xFFFFFF, 1, 35, 35, 1, 1, true, false);
            this.alertTimer = new Timer(0);
            this.alertTimer.addEventListener(TimerEvent.TIMER, this.onGlow, false, 0, true);
        }

        public function onBtDrop(e:MouseEvent):void
        {
            if (this.alertTimer.running)
            {
                this.alertTimer.stop();
                this.border.filters = [];
            };
            e.stopPropagation();
            if (this.rootClass.ui.getChildByName("dropMenu") != null)
            {
                DropMenu(this.rootClass.ui.getChildByName("dropMenu")).onShow();
            };
        }

        public function onAlert():void
        {
            if (this.alertTimer.running)
            {
                return;
            };
            this.glowFilter.strength = 1;
            this.border.filters = [this.glowFilter];
            this.alternate = false;
            this.alertTimer.start();
        }

        public function onGlow(e:TimerEvent):void
        {
            this.glowFilter.strength = (this.glowFilter.strength + ((this.alternate) ? 0.05 : -0.05));
            this.border.filters = [this.glowFilter];
            if (((this.glowFilter.strength <= 0) || (this.glowFilter.strength >= 1)))
            {
                this.alternate = (this.glowFilter.strength <= 0);
            };
        }


    }
}//package 

