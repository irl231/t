// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameSlotDisplay

package Main.Aqw.LPF
{
    import flash.text.TextField;

    public class LPFFrameSlotDisplay extends LPFFrame 
    {

        public var ti:TextField;
        private var isBank:Boolean = false;


        override public function fOpen(data:Object):void
        {
            if (data.eventTypes != undefined)
            {
                eventTypes = data.eventTypes;
            };
            if (data.isBank != undefined)
            {
                this.isBank = ((Boolean(data.isBank)) || (data.isBank == 1));
            };
            super.fOpen(data);
            this.fDraw();
        }

        override public function notify(_arg1:Object):void
        {
            this.fDraw();
        }

        private function fDraw():void
        {
            this.ti.htmlText = ((this.isBank) ? (((((("<font color='#FFFFFF'>" + this.rootClass.world.bankController.iBankCount) + "</font><font color='#CCCCCC'> / </font>") + "<font color='#FFFFFF'>") + fData.avatar.objData.iBankSlots) + " </font><font color='#CCCCCC'>Bank Spaces</font>")) : (((((("<font color='#FFFFFF'>" + fData.list.length) + "</font><font color='#CCCCCC'> / </font>") + "<font color='#FFFFFF'>") + fData.iBagSlots) + " </font><font color='#CCCCCC'>Backpack Spaces</font>")));
        }


    }
}//package Main.Aqw.LPF

