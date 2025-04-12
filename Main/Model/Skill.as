// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Model.Skill

package Main.Model
{
    import flash.display.DisplayObject;

    public class Skill extends Model 
    {

        public var auras:Array;
        public var id:int;
        public var anim:String = null;
        public var cd:int;
        public var damage:Number;
        public var desc:String = null;
        public var fx:String = null;
        public var icon:String = null;
        public var isOK:Boolean = false;
        public var mp:int;
        public var nam:String = null;
        public var range:int;
        public var ref:String = null;
        public var tgt:String = null;
        public var typ:String = null;
        public var auto:Boolean = false;
        public var strl:String = null;
        public var filter:String = null;
        public var tgtMax:int = 1;
        public var tgtMin:int = 1;
        public var pet:int = 0;
        public var checkPet:Boolean = false;
        public var sArg1:String = null;
        public var sArg2:String = null;
        public var ts:Number = 0;
        public var actID:Number = -1;
        public var lastTS:Number = -9999;
        public var lock:Boolean = false;
        public var skillLock:DisplayObject = null;

        public function Skill(obj:Object=null)
        {
            super(obj);
        }

    }
}//package Main.Model

