// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFElementSimpleItem

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import Main.Model.Item;

    public class LPFElementSimpleItem extends MovieClip 
    {

        public var tQty:TextField;
        public var tName:TextField;
        public var fParent:LPFFrame;
        protected var eventType:String = "";
        protected var sMode:String;
        private var item:Item;
        private var rootClass:Game = Game.root;

        public function LPFElementSimpleItem():void
        {
            this.item = null;
            super();
        }

        public function fOpen(item:Item):void
        {
            this.item = item;
            this.fDraw();
        }

        public function fClose():void
        {
            this.item = null;
            parent.removeChild(this);
        }

        public function subscribeTo(_arg1:LPFFrame):void
        {
            this.fParent = _arg1;
        }

        protected function fDraw():void
        {
            this.tName.htmlText = this.item.sName;
            var itemObj:Object = this.rootClass.world.invTree[this.item.ItemID];
            var quantityTotal:int = ((itemObj != null) ? itemObj.iQty : 0);
            this.tQty.htmlText = ((quantityTotal >= this.item.iQty) ? ((((("<font color='#20f000'>" + quantityTotal) + "</font><font color='#FFD900'>/</font><font color='#FFFFFF'>") + this.item.iQty) + "</font>")) : ((((("<font color='#f00c00'>" + quantityTotal) + "</font><font color='#999999'>/</font><font color='#666666'>") + this.item.iQty) + "</font>")));
        }


    }
}//package Main.Aqw.LPF

