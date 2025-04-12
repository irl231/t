// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.InventorySearch

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import Main.Model.Item;
    import __AS3__.vec.Vector;
    import flash.events.KeyboardEvent;
    import flash.events.*;

    public class InventorySearch extends MovieClip 
    {

        public var txtSearch:TextField;

        public function InventorySearch()
        {
            this.txtSearch.addEventListener(KeyboardEvent.KEY_DOWN, this.onInvSearch, false, 0, true);
        }

        public function onFilter(param1:Item, param2:int, items:Vector.<Item>):Boolean
        {
            return (param1.sName.toLowerCase().indexOf(this.txtSearch.text.toLowerCase()) > -1);
        }

        public function apply():void
        {
            if (Game.root.ui.mcPopup.currentLabel == "Inventory")
            {
                Game.root.world.myAvatar.filtered_list = ((this.txtSearch.text != "") ? Game.root.world.myAvatar.items.filter(this.onFilter) : null);
                LPFLayoutInvShopEnh(Game.root.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshInv"});
            }
            else
            {
                if (Game.root.ui.mcPopup.currentLabel == "HouseInventory")
                {
                    Game.root.world.myAvatar.filtered_list = ((this.txtSearch.text != "") ? Game.root.world.myAvatar.houseitems.filter(this.onFilter) : null);
                    LPFLayoutInvShopEnh(Game.root.ui.mcPopup.getChildByName("mcInventory")).update({"eventType":"refreshInv"});
                }
                else
                {
                    if (Game.root.ui.mcPopup.currentLabel == "Bank")
                    {
                        Game.root.world.myAvatar.filtered_list = ((this.txtSearch.text != "") ? Game.root.world.myAvatar.items.filter(this.onFilter) : null);
                        LPFLayoutBank(Game.root.ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshInv"});
                    }
                    else
                    {
                        if (Game.root.ui.mcPopup.currentLabel == "HouseBank")
                        {
                            Game.root.world.myAvatar.filtered_list = ((this.txtSearch.text != "") ? Game.root.world.myAvatar.houseitems.filter(this.onFilter) : null);
                            LPFLayoutBank(Game.root.ui.mcPopup.getChildByName("mcBank")).update({"eventType":"refreshInv"});
                        };
                    };
                };
            };
        }

        public function reset():void
        {
            Game.root.world.myAvatar.filtered_list = null;
        }

        private function onInvSearch(param1:KeyboardEvent):void
        {
            if (param1.charCode == 13)
            {
                this.apply();
            };
        }


    }
}//package Main.Aqw.LPF

