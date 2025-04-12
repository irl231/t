// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.TradeController

package Main.Controller
{
    import Main.Model.Item;
    import Main.Model.*;

    public class TradeController 
    {


        public function refresh():void
        {
            this.refreshA();
            this.refreshB();
            this.refreshC();
        }

        public function refreshA():void
        {
            Game.root.tradeTabs["offer"].fRefresh({"filter":"All"});
        }

        public function refreshB():void
        {
            Game.root.tradeTabs["their"].fRefresh({"filter":"All"});
        }

        public function refreshC():void
        {
            Game.root.tradeTabs["inventory"].fRefresh({"filter":"All"});
        }

        public function resetA():void
        {
            Game.root.world.tradeInfo.itemsA.splice(0, Game.root.world.tradeInfo.itemsA.length);
            this.refreshA();
        }

        public function resetB():void
        {
            Game.root.world.tradeInfo.itemsB.splice(0, Game.root.world.tradeInfo.itemsB.length);
            this.refreshB();
        }

        public function toTrade(itemID:int, quantity:int):void
        {
            var itemCopy:Item;
            var i:int;
            while (i < Game.root.world.myAvatar.items.length)
            {
                if (Game.root.world.myAvatar.items[i].ItemID == itemID)
                {
                    itemCopy = new Item(Game.root.copyObj(Game.root.world.myAvatar.items[i]));
                    itemCopy.iQty = quantity;
                    this.addItemsToTradeA([itemCopy]);
                    Game.root.world.myAvatar.removeItemByID(itemID, quantity);
                    return;
                };
                i++;
            };
        }

        public function toInventory_A(itemID:int):void
        {
            var i:int;
            while (i < Game.root.world.tradeInfo.itemsA.length)
            {
                if (Game.root.world.tradeInfo.itemsA[i].ItemID == itemID)
                {
                    Game.root.world.myAvatar.addItem(Game.root.world.tradeInfo.itemsA[i]);
                    Game.root.world.tradeInfo.itemsA.removeAt(i);
                    return;
                };
                i++;
            };
        }

        public function tradeToInvB(_arg1:int):void
        {
            var i:int;
            while (i < Game.root.world.tradeInfo.itemsB.length)
            {
                if (Game.root.world.tradeInfo.itemsB[i].ItemID == _arg1)
                {
                    Game.root.world.tradeInfo.itemsB.splice(i, 1)[0];
                    return;
                };
                i++;
            };
        }

        public function tradeSwapInv(_arg1:int, _arg2:int):void
        {
            var item:Object;
            var item2:Item;
            var i:int;
            while (i < Game.root.world.myAvatar.items.length)
            {
                if (Game.root.world.myAvatar.items[i].ItemID == _arg1)
                {
                    item2 = Game.root.world.myAvatar.items.splice(i, 1)[0];
                    break;
                };
                i++;
            };
            i = 0;
            while (i < Game.root.world.tradeInfo.itemsA.length)
            {
                if (Game.root.world.tradeInfo.itemsA[i].ItemID == _arg2)
                {
                    item = Game.root.world.tradeInfo.itemsA.splice(i, 1)[0];
                    break;
                };
                i++;
            };
            if (((!(item == null)) && (!(item2 == null))))
            {
                Game.root.world.tradeInfo.itemsA.push(item2);
                Game.root.world.invTree[_arg1].iQty = 0;
                Game.root.world.myAvatar.items.push(item);
                Game.root.world.invTree[_arg2] = item;
            };
        }

        public function tradeToInvReset():void
        {
            var item:Item;
            var _local4:int;
            var i:int;
            while (i < Game.root.world.tradeInfo.itemsA.length)
            {
                item = Game.root.world.tradeInfo.itemsA[i];
                if (Game.root.world.myAvatar.isItemInInventory(item.ItemID))
                {
                    item.iQty = (item.iQty + Game.root.world.invTree[item.ItemID].iQty);
                    _local4 = 0;
                    while (_local4 < Game.root.world.myAvatar.items.length)
                    {
                        if (Game.root.world.myAvatar.items[_local4].ItemID == item.ItemID)
                        {
                            Game.root.world.myAvatar.items[_local4].iQty = item.iQty;
                            break;
                        };
                        _local4++;
                    };
                }
                else
                {
                    Game.root.world.myAvatar.items.push(item);
                };
                Game.root.world.invTree[item.ItemID] = item;
                i++;
            };
        }

        public function sendLoadOfferRequest(_arg1:Array=null):void
        {
            var key:String;
            for each (key in _arg1)
            {
                Game.root.world.tradeInfo.hasRequested[key] = true;
            };
            Game.root.network.send("loadOffer", _arg1);
        }

        public function addItemsToTradeA(itemsArr:Array):void
        {
            var itemObj:Object;
            var b:Boolean;
            var item:Item;
            for each (itemObj in itemsArr)
            {
                b = true;
                for each (item in Game.root.world.tradeInfo.itemsA)
                {
                    if (item.ItemID == itemObj.ItemID)
                    {
                        item.iQty = itemObj.iQty;
                        b = false;
                        break;
                    };
                };
                if (b)
                {
                    Game.root.world.tradeInfo.itemsA.push(((itemObj is Item) ? Item(itemObj) : new Item(itemObj)));
                };
            };
        }

        public function addItemsToTradeB(itemsArr:Array):void
        {
            var itemObj:Object;
            var b:Boolean;
            var item:Item;
            for each (itemObj in itemsArr)
            {
                b = true;
                for each (item in Game.root.world.tradeInfo.itemsB)
                {
                    if (item.ItemID == itemObj.ItemID)
                    {
                        b = false;
                        break;
                    };
                };
                if (b)
                {
                    Game.root.world.tradeInfo.itemsB.push(((itemObj is Item) ? Item(itemObj) : new Item(itemObj)));
                };
            };
        }


    }
}//package Main.Controller

