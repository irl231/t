// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.AbstractPanel

package Main.UI
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import Main.Drag;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.events.*;
    import flash.errors.*;

    public class AbstractPanel extends MovieClip 
    {

        public var btnClose:SimpleButton;
        public var tTitle:MovieClip;
        public var hit:MovieClip;
        public var preview:DropMenuPreview;
        public var iListB:MovieClip;
        public var iListA:MovieClip;
        public var fxmask:MovieClip;
        public var bg:MovieClip;
        protected var drag:Drag;
        protected var game:Game = Game.root;

        public function AbstractPanel(game:Game):void
        {
            this.game = game;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        }

        protected static function onMouseOverProto(mouseEvent:MouseEvent):void
        {
            var proto:hProto;
            var targetParent:DisplayObjectContainer;
            proto = hProto(mouseEvent.currentTarget);
            targetParent = proto.parent;
            var targetParentNumChildren:int = targetParent.numChildren;
            var i:int;
            while (i < targetParentNumChildren)
            {
                hProto(proto.parent.getChildAt(i)).bg.visible = false;
                i++;
            };
            if (!proto.bg.visible)
            {
                proto.bg.visible = true;
                proto.bg.alpha = 0.33;
            };
        }


        public function onShow():void
        {
            this.visible = true;
        }

        public function onHide():void
        {
            this.visible = false;
        }

        public function onDestroy():void
        {
            this.drag.destroy();
            this.parent.removeChild(this);
        }

        public function onClickClose(event:MouseEvent):void
        {
            this.onHide();
        }

        protected function onAddedToStage(event:Event):void
        {
            throw (new IllegalOperationError("Must override onAddedToStage Function"));
        }

        protected function buildA():void
        {
            throw (new IllegalOperationError("Must override buildA Function"));
        }

        protected function buildB(proto:hProto):void
        {
            throw (new IllegalOperationError("Must override buildB Function"));
        }

        protected function resizeMe(list:MovieClip=null, maxWidth:int=0):void
        {
            if (list)
            {
                maxWidth = (maxWidth + 10);
                list.iList.y = ((list.imask.height >> 1) - (list.iList.height >> 1));
                list.imask.width = (maxWidth - 1);
                list.divider.x = maxWidth;
                list.scr.x = maxWidth;
                if (list.scr.visible)
                {
                    list.w = (maxWidth + list.scr.width);
                }
                else
                {
                    list.w = (maxWidth + 1);
                };
            };
            if (this.iListA.visible)
            {
                this.bg.width = ((this.iListA.x + this.iListA.w) + 5);
            };
            if (this.iListB.visible)
            {
                this.iListB.x = ((this.iListA.x + this.iListA.w) + 1);
                this.bg.width = (this.bg.width + (this.iListB.w + 1));
                this.iListA.divider.visible = (!(this.iListA.scr.visible));
            }
            else
            {
                this.iListA.divider.visible = false;
            };
            if (this.preview.visible)
            {
                this.preview.x = ((this.iListB.x + this.iListB.w) + 4);
                this.bg.width = (this.bg.width + 150);
                this.iListB.divider.visible = (!(this.iListB.scr.visible));
            }
            else
            {
                this.iListB.divider.visible = false;
            };
            var minWidth:Number = ((((this.tTitle.x + this.tTitle.width) + 4) + this.btnClose.width) + 4);
            if (this.bg.width < minWidth)
            {
                this.bg.width = minWidth;
            };
            this.btnClose.x = (this.bg.width - 19);
            this.fxmask.width = this.bg.width;
        }

        protected function onClickProtoA(mouseEvent:MouseEvent):void
        {
            var proto:hProto;
            var targetParent:DisplayObjectContainer;
            proto = hProto(mouseEvent.currentTarget);
            targetParent = proto.parent;
            var targetParentNumChildren:int = targetParent.numChildren;
            var i:int;
            while (i < targetParentNumChildren)
            {
                hProto(targetParent.getChildAt(i)).bg.visible = false;
                i++;
            };
            proto.bg.visible = true;
            this.buildB(proto);
        }

        protected function onClickProtoB(mouseEvent:MouseEvent):void
        {
            throw (new IllegalOperationError("Must override onClickProtoB Function"));
        }


    }
}//package Main.UI

