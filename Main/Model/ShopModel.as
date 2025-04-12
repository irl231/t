// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Model.ShopModel

package Main.Model
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class ShopModel extends Model 
    {

        public var bHouse:Boolean;
        public var bStaff:Boolean;
        public var bUpgrd:Boolean;
        public var bLimited:Boolean = false;
        public var iIndex:int;
        public var ShopID:int;
        public var sField:String;
        public var sName:String;
        public var items:Vector.<Item> = new Vector.<Item>();

        public function ShopModel(obj:Object=null)
        {
            var itemObj:Object;
            super(obj);
            for each (itemObj in obj.items)
            {
                this.items.push(new Item(itemObj));
            };
        }

    }
}//package Main.Model

