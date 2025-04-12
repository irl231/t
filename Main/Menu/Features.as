// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Menu.Features

package Main.Menu
{
    public class Features extends AbstractMenuButton 
    {

        public function Features():void
        {
            super();
            this.buttons.push(new MenuItem("Game Features"));
            this.buttons.push(new MenuItem("Bot Manager", function ():void
            {
                Game.root.toggleBotPanel();
            }));
            this.buttons.push(new MenuItem("Redeem Code", function ():void
            {
                Game.root.toggleRedeemPanel();
            }));
            this.buttons.push(new MenuItem("Inspect User", function ():void
            {
                Game.root.toggleCharPage();
            }));
            this.buttons.push(new MenuItem("Rebirth", function ():void
            {
                Game.root.toggleRebirthPanel();
            }));
        }

    }
}//package Main.Menu

