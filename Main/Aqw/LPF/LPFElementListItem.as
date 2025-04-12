// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFElementListItem

package Main.Aqw.LPF
{
    import flash.display.Sprite;
    import Main.Model.Item;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class LPFElementListItem extends Sprite 
    {

        public var fData:Item;
        public var fParent:LPFFrame;
        public var state:int = 0;
        protected var eventType:String = "";
        protected var sMode:String;


        public function fOpen(_arg1:Object):void
        {
            this.fData = _arg1.fData;
            if (("eventType" in _arg1))
            {
                this.eventType = _arg1.eventType;
            };
        }

        public function fClose():void
        {
            this.fData = null;
            removeEventListener(MouseEvent.CLICK, this.onClick);
            parent.removeChild(this);
        }

        public function subscribeTo(lpfFrame:LPFFrame):void
        {
            this.fParent = lpfFrame;
        }

        public function select():void
        {
        }

        public function deselect():void
        {
        }

        protected function update():void
        {
            this.fParent.update({
                "fData":this.fData,
                "eventType":this.eventType,
                "fCaller":this.fParent.sName
            });
        }

        protected function fDraw():void
        {
        }

        protected function onClick(_arg1:MouseEvent):void
        {
            this.update();
        }

        protected function onMouseOver(_arg1:MouseEvent):void
        {
        }

        protected function onMouseOut(_arg1:MouseEvent):void
        {
        }


    }
}//package Main.Aqw.LPF

