// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//BankPreview

package 
{
    import flash.display.MovieClip;
    import Main.UI.Preview;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import Main.Model.Item;
    import flash.events.*;
    import Main.UI.*;

    public class BankPreview extends MovieClip 
    {

        public const preview:Preview = new Preview(BankPreview);

        public var tInfo:TextField;
        public var mcPreview:MovieClip;
        public var mcCoin:MovieClip;
        public var mcUpgrade:MovieClip;
        public var mcSpecial:MovieClip;
        public var btnGender:SimpleButton;

        public function BankPreview():void
        {
            this.mcCoin.visible = false;
            this.mcUpgrade.visible = false;
            this.mcSpecial.visible = false;
            this.btnGender.addEventListener(MouseEvent.CLICK, this.preview.onBtnGenderClick, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onGenderTTOver, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onGenderTTOut, false, 0, true);
        }

        public function fOpen(data:Object):void
        {
            this.x = data.r.x;
            this.y = data.r.y;
            this.width = data.r.w;
            this.height = data.r.h;
            this.preview.item = data.item;
            this.preview.LOAD_KEY = "bank_junk";
            this.fDraw();
        }

        public function fClose():void
        {
            this.btnGender.removeEventListener(MouseEvent.CLICK, this.preview.onBtnGenderClick);
            this.btnGender.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onGenderTTOver);
            this.btnGender.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onGenderTTOut);
            this.preview.item = null;
            this.preview.clearPreview();
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        private function fDraw():void
        {
            this.preview.clearPreview();
            this.btnGender.visible = false;
            if (this.preview.item != null)
            {
                this.tInfo.htmlText = Game.root.getItemInfoStringB(this.preview.item);
                this.mcUpgrade.visible = false;
                this.mcSpecial.visible = false;
                this.mcCoin.visible = false;
                if (this.preview.item.bUpg)
                {
                    this.mcUpgrade.visible = true;
                };
                this.preview.loadPreview();
            }
            else
            {
                this.tInfo.htmlText = "Please select an item to preview.";
            };
        }

        public function show(item:Item):void
        {
            if (item == null)
            {
                this.Hide();
                return;
            };
            this.preview.item = item;
            this.fDraw();
            this.visible = true;
        }

        private function Hide():void
        {
            this.visible = false;
        }


    }
}//package 

