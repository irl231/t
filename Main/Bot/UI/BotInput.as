// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Bot.UI.BotInput

package Main.Bot.UI
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;

    public class BotInput extends MovieClip 
    {

        public var button:SimpleButton;
        public var title:TextField;
        public var input:TextField;


        public function hideButton():void
        {
            this.button.visible = false;
            this.input.width = 102.75;
        }


    }
}//package Main.Bot.UI

