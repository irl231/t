// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrameItemPreview

package Main.Aqw.LPF
{
    import Main.UI.Preview;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.*;
    import Main.UI.*;

    public class LPFFrameItemPreview extends LPFFrame 
    {

        public const preview:Preview = new Preview(LPFFrameItemPreview);

        public var tInfo:TextField;
        public var mcPreview:MovieClip;
        public var mcCoin:MovieClip;
        public var mcUpgrade:MovieClip;
        public var mcSpecial:MovieClip;
        public var btnDelete:SimpleButton;
        public var btnChatShow:SimpleButton;
        public var btnGender:SimpleButton;
        public var btnLibrary:SimpleButton;
        public var btnCustomize:SimpleButton;
        private var isEquip:Boolean = false;
        private var isShow:Boolean = false;

        public function LPFFrameItemPreview():void
        {
            this.mcCoin.visible = false;
            this.mcUpgrade.visible = false;
            this.mcSpecial.visible = false;
            this.btnDelete.addEventListener(MouseEvent.CLICK, this.preview.onBtnDeleteClick, false, 0, true);
            this.btnDelete.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onDeleteTTOver, false, 0, true);
            this.btnDelete.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onDeleteTTOut, false, 0, true);
            this.btnChatShow.addEventListener(MouseEvent.CLICK, this.preview.onBtnChatShowClick, false, 0, true);
            this.btnChatShow.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onChatShowTTOver, false, 0, true);
            this.btnChatShow.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onChatShowTTOut, false, 0, true);
            this.btnCustomize.addEventListener(MouseEvent.CLICK, this.preview.onBtnCustomizeClick, false, 0, true);
            this.btnCustomize.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onCustomizeTTOver, false, 0, true);
            this.btnCustomize.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onCustomizeTTOut, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.CLICK, this.preview.onBtnGenderClick, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onGenderTTOver, false, 0, true);
            this.btnGender.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onGenderTTOut, false, 0, true);
            this.btnLibrary.addEventListener(MouseEvent.CLICK, this.preview.onBtnLibraryClick, false, 0, true);
            this.btnLibrary.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onbtnLibraryTTOver, false, 0, true);
            this.btnLibrary.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onbtnLibraryTTOut, false, 0, true);
            this.mcCoin.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onCoinTTOver, false, 0, true);
            this.mcCoin.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onCoinTTOut, false, 0, true);
            this.mcUpgrade.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onUpgradeTTOver, false, 0, true);
            this.mcUpgrade.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onUpgradeTTOut, false, 0, true);
            this.mcSpecial.addEventListener(MouseEvent.MOUSE_OVER, this.preview.onSpecialTTOver, false, 0, true);
            this.mcSpecial.addEventListener(MouseEvent.MOUSE_OUT, this.preview.onSpecialTTOut, false, 0, true);
        }

        override public function fOpen(data:Object):void
        {
            positionBy(data.r);
            if (data.eventTypes != undefined)
            {
                this.eventTypes = data.eventTypes;
            };
            if (data.isEquip != undefined)
            {
                this.isEquip = data.isEquip;
            };
            this.preview.LOAD_KEY = ((this.isEquip) ? "lpf_equipped_junk" : "lpf_preview_junk");
            if (data.isShow != undefined)
            {
                this.isShow = data.isShow;
            };
            this.fDraw();
            getLayout().registerForEvents(this, this.eventTypes);
        }

        override public function fClose():void
        {
            this.btnDelete.removeEventListener(MouseEvent.CLICK, this.preview.onBtnDeleteClick);
            this.btnDelete.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onDeleteTTOver);
            this.btnDelete.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onDeleteTTOut);
            this.btnChatShow.removeEventListener(MouseEvent.CLICK, this.preview.onBtnChatShowClick);
            this.btnChatShow.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onChatShowTTOver);
            this.btnChatShow.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onChatShowTTOut);
            this.btnGender.removeEventListener(MouseEvent.CLICK, this.preview.onBtnGenderClick);
            this.btnGender.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onGenderTTOver);
            this.btnGender.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onGenderTTOut);
            this.btnLibrary.removeEventListener(MouseEvent.CLICK, this.preview.onBtnLibraryClick);
            this.btnLibrary.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onbtnLibraryTTOver);
            this.btnLibrary.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onbtnLibraryTTOut);
            this.mcCoin.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onCoinTTOver);
            this.mcCoin.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onCoinTTOut);
            this.mcUpgrade.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onUpgradeTTOver);
            this.mcUpgrade.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onUpgradeTTOut);
            this.mcSpecial.removeEventListener(MouseEvent.MOUSE_OVER, this.preview.onSpecialTTOver);
            this.mcSpecial.removeEventListener(MouseEvent.MOUSE_OUT, this.preview.onSpecialTTOut);
            getLayout().unregisterFrame(this);
            this.preview.item = null;
            this.preview.clearPreview();
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        override public function notify(data:Object):void
        {
            this.preview.item = null;
            if (data.fData.eSel != null)
            {
                this.preview.item = data.fData.eSel;
            };
            if (data.fData.iSel != null)
            {
                this.preview.item = data.fData.iSel;
            };
            if (((this.isEquip) && (!(this.preview.item == null))))
            {
                this.preview.item = Game.root.world.myAvatar.getEquippedItemBySlot(this.preview.item.sES);
                if (this.preview.item == null)
                {
                    this.fParent.fClose();
                    return;
                };
            };
            this.fDraw();
        }

        private function fDraw():void
        {
            this.preview.clearPreview();
            this.btnDelete.visible = false;
            this.btnChatShow.visible = false;
            this.btnGender.visible = false;
            this.btnLibrary.visible = false;
            if (this.preview.item != null)
            {
                this.btnDelete.visible = true;
                this.btnChatShow.visible = true;
                this.btnLibrary.visible = true;
                this.tInfo.htmlText = Game.root.getItemInfoStringB(this.preview.item);
                this.tInfo.y = int((((this.btnDelete.y + this.btnDelete.height) - this.tInfo.textHeight) - 3));
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
                this.tInfo.htmlText = ((this.isEquip) ? "Please select an item to preview." : "");
            };
            this.btnDelete.visible = true;
            if ((((((Game.root.ui.mcPopup.currentLabel == "Shop") || (Game.root.ui.mcPopup.currentLabel == "AuctionPanel")) || (Game.root.ui.mcPopup.currentLabel == "MergeShop")) || (Game.root.ui.mcPopup.currentLabel == "ItemPreview")) || (this.isShow)))
            {
                this.btnDelete.visible = false;
                this.btnChatShow.visible = false;
                this.btnGender.y = 173;
            };
        }


    }
}//package Main.Aqw.LPF

