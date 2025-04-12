// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.Outfit.OutfitUnlock

package Main.Aqw.Outfit
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.*;

    public class OutfitUnlock extends Sprite 
    {

        public var tl3:MovieClip;
        public var bl1:MovieClip;
        public var btnClose:SimpleButton;
        public var btn2:SimpleButton;
        public var bg:MovieClip;
        public var tr1:MovieClip;
        public var tr2:MovieClip;
        public var tl1:MovieClip;
        public var tr3:MovieClip;
        public var br1:MovieClip;
        public var tl2:MovieClip;
        public var outfitCost:TextField;

        public function OutfitUnlock()
        {
            this.outfitCost.htmlText = (((Config.getInt("slot_outfit_cost") + " <font color='#FFCC33'>") + Config.getString("coins_name_short")) + "</font>");
            this.outfitCost.mouseEnabled = false;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onHide, false, 0, true);
        }

        public function onHide(mouseEvent:MouseEvent):void
        {
            this.visible = false;
        }


    }
}//package Main.Aqw.Outfit

