// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.Outfit.Button.OutfitButton

package Main.Aqw.Outfit.Button
{
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    public class OutfitButton extends Sprite 
    {

        public var btnMain:SimpleButton;
        public var txtName:TextField;
        public var btnEdit:SimpleButton;
        public var btnDelete:SimpleButton;

        public function OutfitButton()
        {
            this.btnMain.tabIndex = 3;
            this.btnDelete.tabIndex = 3;
            this.btnEdit.tabIndex = 3;
        }

    }
}//package Main.Aqw.Outfit.Button

