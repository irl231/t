// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFElementScrollBar

package Main.Aqw.LPF
{
    import Main.UI.AbstractScroll;

    public class LPFElementScrollBar extends AbstractScroll 
    {

        public var fParent:LPFFrame;

        public function LPFElementScrollBar():void
        {
        }

        public function fUpdate():void
        {
            this.update();
        }

        public function fOpen(data:Object):void
        {
            this.init(data);
        }

        public function fClose():void
        {
            this.destroy();
        }

        protected function fDraw():void
        {
        }

        public function subscribeTo(lpfFrame:LPFFrame):void
        {
            this.fParent = lpfFrame;
        }


    }
}//package Main.Aqw.LPF

