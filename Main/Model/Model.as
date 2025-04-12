// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Model.Model

package Main.Model
{
    import __AS3__.vec.*;

    public class Model 
    {

        public function Model(obj:Object=null)
        {
            if (obj != null)
            {
                this.fromObject(obj);
            };
        }

        public function fromObject(obj:Object):void
        {
            var p:String;
            for (p in obj)
            {
                if (((this.hasOwnProperty(p)) && (!(this[p] is Vector.<*>))))
                {
                    if (typeof(this[p]) === "boolean")
                    {
                        this[p] = (!(((obj[p] == "false") || (obj[p] == "0")) || (!(obj[p]))));
                    }
                    else
                    {
                        this[p] = obj[p];
                    };
                };
            };
        }


    }
}//package Main.Model

