// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildSlot

package 
{
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.MouseEvent;
    import flash.events.*;
    import Main.Controller.*;
    import Main.*;

    public class GuildSlot extends Sprite 
    {

        public var btnClose:SimpleButton;
        public var btnOne:SimpleButton;
        public var btnRest:SimpleButton;
        public var txtCost:TextField;
        public var txtSlots:TextField;
        public var txtHCs:TextField;
        private var maxGuildSlots:int = 200;
        private var max_members:int;
        private var hc:int;

        public function GuildSlot()
        {
            this.txtCost.mouseEnabled = false;
            this.hc = Game.root.world.myAvatar.objData.intCoins;
            this.setWindow();
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose);
            this.btnOne.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnRest.addEventListener(MouseEvent.CLICK, this.onClick);
        }

        public function setWindow(quantity:int=0, cost:int=0):void
        {
            this.hc = (this.hc - cost);
            this.max_members = Game.root.world.myAvatar.objData.guild.MaxMembers;
            var remainSlots:int = ((this.maxGuildSlots - this.max_members) + quantity);
            this.txtSlots.htmlText = (((((("Each slot costs 200 " + Config.getString("coins_name_short")) + ".</b>You have: ") + (this.max_members + quantity)) + "/") + this.maxGuildSlots) + "maximum slots.");
            this.txtHCs.text = String(this.hc);
            this.txtCost.text = (("Max (" + remainSlots) + ")");
        }

        private function addMemSlots(quantity_obj:Object):void
        {
            if (quantity_obj.accept)
            {
                Game.root.network.send("guild", ["slots", quantity_obj.quantity]);
                this.setWindow(quantity_obj.quantity, (quantity_obj.quantity * 200));
            };
        }

        public function onClick(event:MouseEvent):void
        {
            var quantity:int;
            switch (event.currentTarget.name)
            {
                case "btnOne":
                    quantity = 1;
                    break;
                case "btnRest":
                    quantity = (this.maxGuildSlots - this.max_members);
                    break;
            };
            if ((quantity * 200) > Game.root.world.myAvatar.objData.intCoins)
            {
                Game.root.chatF.pushMsg("warning", (("You do not have enough " + Config.getString("coins_name")) + " to purchase this."), "SERVER", "", 0);
                return;
            };
            MainController.modal((("This action will cost " + (quantity * 200)) + ", do you confirm it?"), this.addMemSlots, {"quantity":quantity}, null, "dual");
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            UIController.close("guild_slot");
        }


    }
}//package 

