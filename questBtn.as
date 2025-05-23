﻿// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//questBtn

package 
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import fl.motion.Color;
    import flash.display.DisplayObject;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.events.*;
    import fl.motion.*;

    public class questBtn extends Sprite 
    {

        public var txtQuest:TextField;
        public var qFill:MovieClip;
        private var sceneID:int;
        private var core:apopCore;
        private var colorData:Color;
        private var available:Boolean;
        private var accepted:Boolean;
        private var iconClass:Class;
        private var rootClass:Game;
        internal var iconMC:DisplayObject;
        internal var trans:ColorTransform;
        private var questText:String;

        public function questBtn(_arg1:apopCore, _arg2:Object, _arg3:MovieClip)
        {
            this.colorData = new Color();
            super();
            this.rootClass = _arg3;
            this.core = _arg1;
            this.sceneID = _arg2.sceneID;
            this.accepted = _arg2.accepted;
            this.available = _arg2.available;
            this.questText = _arg2.strText;
            this.update(_arg2.accepted, _arg2.available, _arg2.complete);
            this.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onOver, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onOut, false, 0, true);
        }

        public function update(_arg1:Boolean, _arg2:Boolean, _arg3:Boolean):void
        {
            this.txtQuest.text = this.questText;
            if (this.iconMC != null)
            {
                this.removeChild(this.iconMC);
            };
            if (_arg1)
            {
                this.txtQuest.appendText(" - In Progress");
                this.txtQuest.textColor = 0xFFFFFF;
                this.qFill.visible = true;
                this.trans = this.qFill.transform.colorTransform;
                this.trans.color = 0xA300;
                this.qFill.transform.colorTransform = this.trans;
                this.iconClass = this.rootClass.world.getClass("iwd1");
                this.iconMC = this.addChild(new this.iconClass());
                this.iconMC.scaleX = (this.iconMC.scaleX * 0.3);
                this.iconMC.scaleY = (this.iconMC.scaleY * 0.3);
                this.iconMC.x = ((30 - this.iconMC.width) >> 1);
                this.iconMC.y = ((18 - this.iconMC.height) >> 1);
            }
            else
            {
                if (_arg2)
                {
                    this.txtQuest.textColor = 239875;
                    this.qFill.visible = false;
                    this.iconClass = this.rootClass.world.getClass("ime1");
                    this.iconMC = this.addChild(new this.iconClass());
                    this.iconMC.scaleX = (this.iconMC.scaleX * 0.3);
                    this.iconMC.scaleY = (this.iconMC.scaleY * 0.3);
                    this.iconMC.x = ((30 - this.iconMC.width) >> 1);
                    this.iconMC.y = ((18 - this.iconMC.height) >> 1);
                }
                else
                {
                    if (_arg3)
                    {
                        this.txtQuest.appendText(" - Complete");
                        this.txtQuest.textColor = 0xFFFFFF;
                        this.qFill.visible = true;
                        this.trans = this.qFill.transform.colorTransform;
                        this.trans.color = 0xA300;
                        this.qFill.transform.colorTransform = this.trans;
                        this.iconClass = this.rootClass.world.getClass("iCheck");
                        this.iconMC = this.addChild(new this.iconClass());
                        this.iconMC.scaleX = (this.iconMC.scaleX * 0.3);
                        this.iconMC.scaleY = (this.iconMC.scaleY * 0.3);
                        this.iconMC.x = ((30 - this.iconMC.width) >> 1);
                        this.iconMC.y = ((18 - this.iconMC.height) >> 1);
                    }
                    else
                    {
                        this.txtQuest.textColor = 0xFFFFFF;
                        this.iconClass = this.rootClass.world.getClass("iLock");
                        this.qFill.visible = true;
                        this.trans = this.qFill.transform.colorTransform;
                        this.trans.color = 15601937;
                        this.qFill.transform.colorTransform = this.trans;
                        this.iconMC = this.addChild(new this.iconClass());
                        this.iconMC.scaleX = (this.iconMC.scaleX * 0.3);
                        this.iconMC.scaleY = (this.iconMC.scaleY * 0.3);
                        this.iconMC.x = ((30 - this.iconMC.width) >> 1);
                        this.iconMC.y = ((18 - this.iconMC.height) >> 1);
                    };
                };
            };
        }

        private function onClick(_arg1:MouseEvent):void
        {
            if (this.available)
            {
                this.core.showScene(this.sceneID, false, true);
            };
        }

        private function onOver(_arg1:MouseEvent):void
        {
            this.colorData.brightness = -0.28;
            this.transform.colorTransform = this.colorData;
        }

        private function onOut(_arg1:MouseEvent):void
        {
            this.colorData.brightness = 0;
            this.transform.colorTransform = this.colorData;
        }

        public function get ID():int
        {
            return (this.sceneID);
        }


    }
}//package 

