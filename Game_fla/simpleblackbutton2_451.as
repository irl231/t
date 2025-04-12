// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.simpleblackbutton2_451

package Game_fla
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;

    public dynamic class simpleblackbutton2_451 extends MovieClip 
    {

        public var bg:MovieClip;
        public var fx:MovieClip;
        public var isSelected:Boolean;

        public function simpleblackbutton2_451()
        {
            addFrameScript(0, this.frame1);
        }

        public function select():*
        {
            this.isSelected = true;
            this.setCT(this.bg, 18278);
        }

        public function unselect():*
        {
            this.isSelected = false;
            this.setCT(this.bg, 65793);
        }

        public function onMouseOver(_arg1:MouseEvent):*
        {
            if (!this.isSelected)
            {
                this.fx.visible = true;
            };
        }

        public function onMouseOut(_arg1:MouseEvent):*
        {
            this.fx.visible = false;
        }

        public function setCT(_arg1:*, _arg2:*):*
        {
            var _local3:* = _arg1.transform.colorTransform;
            _local3.color = _arg2;
            _arg1.transform.colorTransform = _local3;
        }

        internal function frame1():*
        {
            this.buttonMode = true;
            this.fx.visible = false;
            this.isSelected = false;
            this.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut, false, 0, true);
            stop();
        }


    }
}//package Game_fla

