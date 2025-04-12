// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//DFrameMC

package 
{
    import Main.UI.AbstractDropFrame;
    import Main.Model.Item;
    import flash.events.MouseEvent;
    import flash.display.*;

    public class DFrameMC extends AbstractDropFrame 
    {

        public var cnt:DFrameMCcnt;

        public function DFrameMC(item:Item):void
        {
            addFrameScript(0, this.frame1, 2, this.frame3, 3, this.frame4, 8, this.frame9, 12, this.frame13);
            this.fWidth = 175;
            this.fHeight = 38;
            this.fData = item;
        }

        override public function init():void
        {
            this.cnt.strName.autoSize = "left";
            this.cnt.strName.htmlText = fData.sName;
            if (this.cnt.strName.height > 20)
            {
                this.cnt.strName.y = (this.cnt.strName.y - int((this.cnt.strName.height / 2)));
                if (this.cnt.strName.y < 3)
                {
                    this.cnt.strName.y = 3;
                };
            };
            this.cnt.strName.width = (this.cnt.strName.textWidth + 6);
            this.cnt.strType.text = rootClass.getDisplaysType(fData);
            if (fData.iQty > 1)
            {
                this.cnt.bg.width = (int(this.cnt.strName.textWidth) + 75);
                this.cnt.strQ.text = ("x" + fData.iQty);
                this.cnt.strQ.visible = true;
                this.cnt.strQ.x = ((this.cnt.bg.width - this.cnt.strQ.width) - 7);
            }
            else
            {
                this.cnt.strQ.visible = false;
                this.cnt.bg.width = (int(this.cnt.strName.textWidth) + 50);
            };
            this.cnt.fx1.width = this.cnt.bg.width;
            fWidth = this.cnt.bg.width;
            super.init();
        }

        private function frame1():void
        {
            visible = false;
        }

        private function frame3():void
        {
            iniFrameC++;
            if (iniFrameC <= (MovieClip(parent).getChildIndex(this) << 1))
            {
                this.gotoAndPlay((currentFrame - 1));
            };
        }

        private function frame4():void
        {
            visible = true;
        }

        private function frame9():void
        {
            durFrameC++;
            var durFrameT:int = 35;
            if (durFrameC <= durFrameT)
            {
                this.gotoAndPlay((currentFrame - 1));
            };
        }

        private function frame13():void
        {
            MovieClip(parent).removeChild(this);
            stop();
        }

        private function closeClick(_arg1:MouseEvent):void
        {
        }


    }
}//package 

