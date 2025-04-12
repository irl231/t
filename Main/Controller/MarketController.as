// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.MarketController

package Main.Controller
{
    import Main.Model.Item;
    import Main.Model.*;

    public class MarketController 
    {


        public function addItems(itemsObj:Array):void
        {
            var item:Object;
            var exists:Boolean;
            var existingItem:Item;
            for each (item in itemsObj)
            {
                exists = false;
                for each (existingItem in Game.root.world.auctioninfo.items)
                {
                    if (existingItem.AuctionID == item.AuctionID)
                    {
                        exists = true;
                        break;
                    };
                };
                if (!exists)
                {
                    Game.root.world.auctioninfo.items.push(new Item(item));
                };
            };
        }

        public function addItemsToRetrieve(itemsArr:Array):void
        {
            var itemObj:Object;
            var exists:Boolean;
            var existingItem:Item;
            for each (itemObj in itemsArr)
            {
                exists = false;
                for each (existingItem in Game.root.world.retrieveinfo.items)
                {
                    if (existingItem.AuctionID == itemObj.AuctionID)
                    {
                        exists = true;
                        break;
                    };
                };
                if (!exists)
                {
                    Game.root.world.retrieveinfo.items.push(new Item(itemObj));
                };
            };
        }

        public function reset():void
        {
            Game.root.world.auctioninfo.items.length = 0;
            Game.root.auctionTabs.fRefresh({"filter":"All"});
        }

        public function retrieveReset():void
        {
            Game.root.world.retrieveinfo.items.length = 0;
            Game.root.auctionTabs.fRefresh({"test":""});
        }

        public function removeRetrieve(auctionID:int):void
        {
            var i:int;
            while (i < Game.root.world.retrieveinfo.items.length)
            {
                if (Game.root.world.retrieveinfo.items[i].AuctionID == auctionID)
                {
                    Game.root.world.retrieveinfo.items.removeAt(i);
                    return;
                };
                i++;
            };
        }

        public function auctionToInv(item:Object):void
        {
            var targetItem:Item;
            var i:int;
            while (i < Game.root.world.auctioninfo.items.length)
            {
                if (Game.root.world.auctioninfo.items[i].AuctionID == item.AuctionID)
                {
                    targetItem = Game.root.world.auctioninfo.items.splice(i, 1)[0];
                    Game.root.world.myAvatar.addItem(item);
                    return;
                };
                i++;
            };
        }

        public function sendLoadAuctionRequest(auctionIDs:Array=null, username:String=""):void
        {
            var auctionID:String;
            for each (auctionID in auctionIDs)
            {
                Game.root.world.auctioninfo.hasRequested[auctionID] = true;
            };
            if (username != "")
            {
                auctionIDs.push(username);
            };
            Game.root.network.send("loadAuction", auctionIDs);
        }

        public function retrieveHasRequested(auctionIDs:Array):Boolean
        {
            var auctionID:String;
            for each (auctionID in auctionIDs)
            {
                if (!(auctionID in Game.root.world.retrieveinfo.hasRequested))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function sendLoadRetrieveRequest(auctionIDs:Array=null, username:String=""):void
        {
            var auctionID:String;
            for each (auctionID in auctionIDs)
            {
                Game.root.world.auctioninfo.hasRequested[auctionID] = true;
            };
            if (username != "")
            {
                auctionIDs.push(username);
            };
            Game.root.network.send("loadRetrieve", auctionIDs);
        }


    }
}//package Main.Controller

