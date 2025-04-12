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
            if (this.isBank)
            {
                if (fData.avatar.objData.iBankDays >= 0)
                {
                    this.ti.htmlText = (((("<font color='#FFFFFF'>" + ((fData.avatar.objData.iBankDays < 1) ? 0 : fData.avatar.objData.iBankDays)) + " </font><font color='#CCCCCC'>Bank Days</font> - <font color='#FFFFFF'>") + this.rootClass.world.bankController.iBankCount) + "</font> <font color='#CCCCCC'>Bank Items</font>");
                }
                else
                {
                    this.ti.htmlText = "<b><font color='#ff0000'>Expired</font></b>";
                };
                return;
            };
            this.ti.htmlText = ((((("<font color='#FFFFFF'>" + fData.list.length) + "</font><font color='#CCCCCC'> / </font>") + "<font color='#FFFFFF'>") + fData.iBagSlots) + " </font><font color='#CCCCCC'>Backpack Spaces</font>");
        }


    }
}//package Main.Aqw.LPF

