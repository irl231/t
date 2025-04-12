// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Space.SpacePanel

package Main.Space
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.*;

    public class SpacePanel extends MovieClip 
    {

        private var game:Game = Game.root;
        public var btnInventory:SimpleButton;
        public var btnHouse:SimpleButton;
        public var btnClose:SimpleButton;
        public var btnBuyOne:SimpleButton;
        public var btnBuyAll:SimpleButton;
        public var txtInventorySpace:TextField;
        public var txtHouseSpace:TextField;
        public var txtTitle:TextField;
        public var txtDescription:TextField;
        public var txtRemaining:TextField;
        public var txtPriceOne:TextField;
        public var txtPriceAll:TextField;
        private var intBagSlots:int;
        private var intBagCost:int;
        private var intBagMax:int;
        private var intBagRemaining:int;
        private var intHouseSlots:int;
        private var intHouseCost:int;
        private var intHouseMax:int;
        private var intHouseRemaining:int;
        public var mcHouse:MovieClip;
        public var mcBag:MovieClip;
        public var lastOption:String = "Inventory";

        public function SpacePanel()
        {
            addFrameScript(0, this.display, 1, stop);
        }

        private function display():void
        {
            this.configureTextFields();
            this.initializeListeners();
            this.updateSlotsInfo();
            this.updateUI(this.lastOption);
            stop();
        }

        private function configureTextFields():void
        {
            this.txtInventorySpace.mouseEnabled = false;
            this.txtHouseSpace.mouseEnabled = false;
            this.txtPriceOne.mouseEnabled = false;
            this.txtPriceAll.mouseEnabled = false;
            this.txtRemaining.mouseEnabled = false;
        }

        private function initializeListeners():void
        {
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnInventory.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnHouse.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnBuyOne.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnBuyAll.addEventListener(MouseEvent.CLICK, this.onClick);
            this.game.world.addEventListener("buyBagSlots", this.onResetFrame, false, 0, true);
            this.game.world.addEventListener("buyHouseSlots", this.onResetFrame, false, 0, true);
        }

        private function updateSlotsInfo():void
        {
            this.intBagSlots = this.game.world.myAvatar.objData.iBagSlots;
            this.intBagCost = Config.getInt("slot_bag_cost");
            this.intBagMax = Config.getInt("slot_bag_max");
            this.intBagRemaining = (this.intBagMax - this.intBagSlots);
            this.intHouseSlots = this.game.world.myAvatar.objData.iHouseSlots;
            this.intHouseCost = Config.getInt("slot_house_cost");
            this.intHouseMax = Config.getInt("slot_house_max");
            this.intHouseRemaining = (this.intHouseMax - this.intHouseSlots);
        }

        private function updateUI(section:String):void
        {
            var isInventory:Boolean;
            this.lastOption = section;
            this.txtTitle.text = section;
            isInventory = (section == "Inventory");
            this.txtDescription.text = ((isInventory) ? ("Increase your backpack space to carry more items permanently.") : ("Increase your house inventory space to store more furniture permanently."));
            this.txtRemaining.text = ("Buy +" + ((isInventory) ? this.intBagRemaining : this.intHouseRemaining));
            this.txtPriceOne.text = ((((isInventory) ? this.intBagCost : this.intHouseCost) + " ") + Config.getString("coins_name_short"));
            this.txtPriceAll.text = ((((isInventory) ? (this.intBagRemaining * this.intBagCost) : (this.intHouseRemaining * this.intHouseCost)) + " ") + Config.getString("coins_name_short"));
            this.txtInventorySpace.text = ((this.intBagSlots + "/") + this.intBagMax);
            this.txtHouseSpace.text = ((this.intHouseSlots + "/") + this.intHouseMax);
            this.mcBag.visible = isInventory;
            this.mcHouse.visible = (!(isInventory));
        }

        private function onResetFrame(event:Event):void
        {
            gotoAndStop("Display");
        }

        private function onClick(event:MouseEvent):void
        {
            var isInventory1:Boolean;
            var costOne:int;
            var isInventory2:Boolean;
            var costAll:int;
            var quantity:int;
            switch (event.currentTarget.name)
            {
                case "btnBuyOne":
                    isInventory1 = (this.txtTitle.text == "Inventory");
                    costOne = ((isInventory1) ? this.intBagCost : this.intHouseCost);
                    this.handleBuy(1, costOne, isInventory1);
                    break;
                case "btnBuyAll":
                    isInventory2 = (this.txtTitle.text == "Inventory");
                    costAll = ((isInventory2) ? (this.intBagRemaining * this.intBagCost) : (this.intHouseRemaining * this.intHouseCost));
                    quantity = ((isInventory2) ? this.intBagRemaining : this.intHouseRemaining);
                    this.handleBuy(quantity, costAll, isInventory2);
                    break;
                case "btnInventory":
                    this.updateUI("Inventory");
                    break;
                case "btnHouse":
                    this.updateUI("House");
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }

        private function handleBuy(quantity:int, cost:int, isInventory:Boolean):void
        {
            var coins:int = this.game.world.myAvatar.objData.intCoins;
            if (coins < cost)
            {
                this.game.MsgBox.notify((("You do not have sufficient " + Config.getString("coins_name_short")) + " to make this purchase."));
                return;
            };
            if ((((isInventory) && (this.intBagSlots == this.intBagMax)) || ((!(isInventory)) && (this.intHouseSlots == this.intHouseMax))))
            {
                this.game.MsgBox.notify("There is nothing to buy.");
                return;
            };
            if (isInventory)
            {
                this.game.world.buyBagSlots(quantity);
            }
            else
            {
                this.game.world.buyHouseSlots(quantity);
            };
            gotoAndStop("Spinner");
        }


    }
}//package Main.Space

