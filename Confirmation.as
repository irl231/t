// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Confirmation

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class Confirmation extends MovieClip 
    {

        public var rootClass:Game;
        public var txtPassword:TextField;
        public var btnConfirm:SimpleButton;
        public var btnClose:SimpleButton;
        public var cParent:MovieClip;
        public var confirmation:Function;

        public function Confirmation(cParent:MovieClip, root:MovieClip, confirmation:Function)
        {
            this.cParent = cParent;
            this.rootClass = root;
            this.confirmation = confirmation;
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClose);
        }

        private function close():void
        {
            this.cParent.removeChild(this);
            this.cParent.visible = false;
        }

        private function onClose(event:MouseEvent):void
        {
            this.close();
        }

        public function onClick(event:MouseEvent):void
        {
            var password:String = this.txtPassword.text;
            if (password == Game.loginInfo.strPassword)
            {
                this.close();
                this.confirmation();
            }
            else
            {
                this.rootClass.chatF.pushMsg("warning", "The password you entered did not match. Please check the spelling and try again.", "SERVER", "", 0);
            };
        }


    }
}//package 

