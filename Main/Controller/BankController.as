// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Controller.BankController

package Main.Controller
{
    import Main.Model.Item;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;
    import Main.Model.*;

    public class BankController 
    {


        public function bankFromInv(itemID:int, charItemID:int):void
        {
            var item:Item;
            var newItem:Item;
            var newItems:Vector.<Item>;
            var i:int;
            for each (item in Game.root.world.myAvatar.items)
            {
                if (item.ItemID == itemID)
                {
                    this.iBankCount++;
                    newItem = new Item(Game.root.copyObj(item));
                    newItem.CharItemID = charItemID;
                    newItems = new Vector.<Item>();
                    newItems.push(newItem);
                    Game.root.world.addItemsToBank(newItems);
                    Game.root.world.myAvatar.removeItemByID(itemID, item.iQty);
                    Game.root.world.invTree[itemID].iQty = 0;
                    return;
                };
                i++;
            };
        }

        public function bankToInv(itemID:int, charItemID:int):void
        {
            var item:Item;
            var ii:int;
            var item2:Item;
            var i:int;
            for each (item in Game.root.world.bankinfo.items)
            {
                if (item.ItemID == itemID)
                {
                    this.iBankCount--;
                    ii = 0;
                    item.CharItemID = charItemID;
                    for each (item2 in Game.root.world.myAvatar.items)
                    {
                        if (item2.ItemID == itemID)
                        {
                            Game.root.world.myAvatar.removeItemByID(itemID, item2.iQty);
                            item.iQty = (item.iQty + Game.root.world.invTree[itemID].iQty);
                            item.CharItemID = item2.CharItemID;
                            break;
                        };
                        ii++;
                    };
                    Game.root.world.bankinfo.items.removeAt(i);
                    Game.root.world.myAvatar.items.push(item);
                    Game.root.world.invTree[itemID] = item;
                    return;
                };
                i++;
            };
        }

        public function bankSwapInv(_arg1:int, _arg2:int, _arg3:int, _arg4:int):void
        {
            var _local3:Item;
            var _local4:Item;
            var _local5:int;
            while (_local5 < Game.root.world.myAvatar.items.length)
            {
                if (Game.root.world.myAvatar.items[_local5].ItemID == _arg1)
                {
                    _local4 = Game.root.world.myAvatar.items.splice(_local5, 1)[0];
                    break;
                };
                _local5++;
            };
            _local5 = 0;
            while (_local5 < Game.root.world.bankinfo.items.length)
            {
                if (Game.root.world.bankinfo.items[_local5].ItemID == _arg2)
                {
                    _local3 = Game.root.world.bankinfo.items.splice(_local5, 1)[0];
                    break;
                };
                _local5++;
            };
            if (((!(_local3 == null)) && (!(_local4 == null))))
            {
                _local4.CharItemID = _arg4;
                Game.root.world.bankinfo.items.push(_local4);
                if (_local4.bCoins == 0)
                {
                    this.iBankCount++;
                };
                Game.root.world.invTree[_arg1].iQty = 0;
                _local3.CharItemID = _arg3;
                Game.root.world.myAvatar.items.push(_local3);
                if (_local3.bCoins == 0)
                {
                    this.iBankCount--;
                };
                Game.root.world.invTree[_arg2] = _local3;
            };
        }

        public function get iBankCount():int
        {
            return (Game.root.world.bankinfo.Count);
        }

        public function set iBankCount(count:int):void
        {
            Game.root.world.bankinfo.Count = count;
        }


    }
}//package Main.Controller

