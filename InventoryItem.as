// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//InventoryItem

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public dynamic class InventoryItem extends MovieClip 
    {

        public var icon:MovieClip;
        public var strLevel:TextField;
        public var bg:MovieClip;
        public var strName:TextField;
        public var strIndex:TextField;
        public var btnSelect:SimpleButton;
        public var isEq:Boolean;
        public var isSel:Boolean;

        public function InventoryItem()
        {
            addFrameScript(0, this.frame1);
        }

        public function select():void
        {
            this.bg.b.visible = true;
            this.isSel = true;
        }

        public function equip():void
        {
            this.isEq = true;
            this.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 30, 50, 0);
            this.bg.b.visible = false;
            this.bg.c.visible = true;
        }

        public function unequip():void
        {
            this.isEq = false;
            this.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            this.bg.c.visible = false;
            if (!this.isSel)
            {
                this.bg.b.visible = false;
            };
        }

        public function reset():void
        {
            if (!this.isEq)
            {
                this.bg.b.visible = false;
            };
            this.isSel = false;
        }

        public function clearText():void
        {
            this.strName.text = "";
            this.strLevel.text = "";
            this.icon.visible = false;
        }

        public function onItemSelect(event:Event):void
        {
            MovieClip(parent).selectItem(event.target.parent.intIndex);
        }

        private function frame1():void
        {
            this.isEq = false;
            this.isSel = false;
            this.btnSelect.addEventListener(MouseEvent.CLICK, this.onItemSelect);
            stop();
        }


    }
}//package 

