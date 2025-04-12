// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Menu.MenuItem

package Main.Menu
{
    public class MenuItem 
    {

        public var txt:String = null;
        public var callback:Function = null;

        public function MenuItem(text:String, cb:Function=null)
        {
            this.txt = text;
            this.callback = cb;
        }

    }
}//package Main.Menu

