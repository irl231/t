// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Option.MeterMC

package Main.Option
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;

    public class MeterMC extends MovieClip 
    {

        public var game:Game = Game.root;
        public var txtName:TextField;
        public var objData:Object;
        public var mcBar:MovieClip;
        public var mcHandle:MovieClip;
        public var mcBackground:MovieClip;
        public var txtLeft:TextField;
        public var txtRight:TextField;
        public var txtValue:TextField;
        public var isMouseDown:Boolean = false;
        public var p:Point = new Point();
        public var w:int;
        public var dx:int = 0;
        public var _min:int;
        public var _max:int;

        public function MeterMC()
        {
            addEventListener(Event.ENTER_FRAME, this.onEF, false, 0, true);
            this.addTooltipListeners();
            this.mcHandle.buttonMode = true;
            this.mcHandle.addEventListener(MouseEvent.MOUSE_DOWN, this.onDn, false, 0, true);
            this.game.stage.addEventListener(MouseEvent.MOUSE_UP, this.onUp, false, 0, true);
        }

        private function addTooltipListeners():void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverTooltip, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutTooltip, false, 0, true);
        }

        private function removeTooltipListeners():void
        {
            this.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOverTooltip, false);
            this.removeEventListener(MouseEvent.MOUSE_OUT, this.onMouseOutTooltip, false);
        }

        private function onMouseOverTooltip(event:MouseEvent):void
        {
            if (!this.isMouseDown)
            {
                this.game.ui.ToolTip.openWith({"str":this.objData.strDescription});
            };
        }

        private function onMouseOutTooltip(event:MouseEvent):void
        {
            this.game.ui.ToolTip.close();
        }

        private function onEF(event:Event):void
        {
            var ratio:Number;
            if (this.isMouseDown)
            {
                this.p.x = (stage.mouseX - this.dx);
                this.p.x = Math.max(this.mcBar.x, Math.min(this.p.x, (this.mcBar.x + this.w)));
                this.mcHandle.x = this.p.x;
                ratio = ((this.p.x - this.mcBar.x) / this.w);
                this.objData.value = (Math.round((ratio * (this._max - this._min))) + this._min);
                this.objData.callback(this.txtValue, this.objData.value);
            };
        }

        private function onDn(mouseEvent:MouseEvent):void
        {
            this.isMouseDown = true;
            this.p.x = stage.mouseX;
            this.dx = (this.p.x - this.mcHandle.x);
            this.removeTooltipListeners();
        }

        private function onUp(mouseEvent:MouseEvent):void
        {
            this.isMouseDown = false;
            this.addTooltipListeners();
        }

        public function set(data:Object, width:Number):*
        {
            this.objData = data;
            this.txtName.text = this.objData.strName;
            this.mcBackground.width = width;
            this.mcBar.width = ((this.mcBackground.width - 7.5) - 5.8);
            this.mcHandle.x = ((this.mcBar.width - this.mcHandle.width) - 12);
            this.txtRight.x = ((this.mcBar.width - this.txtRight.width) + 8);
            this.txtValue.x = ((this.mcBar.width - this.txtRight.width) + 8);
            this._min = data.minimum.value;
            this._max = data.maximum.value;
            this.txtLeft.text = data.minimum.text;
            this.txtRight.text = data.maximum.text;
            this.w = (this.mcBar.width - this.mcHandle.width);
            this.updateHandle();
        }

        private function updateHandle():void
        {
            if (this.objData.value == this._min)
            {
                this.mcHandle.x = this.mcBar.x;
            }
            else
            {
                if (this.objData.value == this._max)
                {
                    this.mcHandle.x = ((this.mcBar.width - this.mcHandle.width) + 6);
                }
                else
                {
                    this.mcHandle.x = (this.mcBar.x + (this.w * (this.objData.value / this._max)));
                };
            };
            this.objData.callback(this.txtValue, this.objData.value);
        }


    }
}//package Main.Option

