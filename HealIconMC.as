// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//HealIconMC

package 
{
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class HealIconMC extends MovieClip 
    {

        public var shp:MovieClip;
        public var hit:MovieClip;
        private var avt:Avatar;

        public function HealIconMC(avatar:Avatar):void
        {
            addFrameScript(35, this.frame36);
            this.avt = avatar;
            this.hit.addEventListener(MouseEvent.CLICK, this.onClick, false, 0, true);
            this.hit.buttonMode = true;
            this.hit.alpha = 0;
            this.shp.mouseEnabled = false;
            this.shp.mouseChildren = false;
            this.y = ((this.avt.pMC.pname.y - this.height) - 5);
            this.x = (this.x - int((this.width >> 1)));
        }

        public function onClick(_arg1:MouseEvent):void
        {
            Game.root.world.healByIcon(this.avt);
            this.fClose();
        }

        public function fClose():void
        {
            stop();
            this.hit.removeEventListener(MouseEvent.CLICK, this.onClick);
            parent.removeChild(this);
        }

        private function frame36():void
        {
            gotoAndPlay("loop");
        }


    }
}//package 

