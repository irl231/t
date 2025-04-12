// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Model.Action

package Main.Model
{
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class Action extends Model 
    {

        public var active:Vector.<Skill> = new Vector.<Skill>();
        public var passive:Vector.<Skill> = new Vector.<Skill>();
        public var auto:Skill = null;

        public function Action(obj:Object=null)
        {
            super(obj);
        }

    }
}//package Main.Model

