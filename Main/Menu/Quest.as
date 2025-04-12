// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Menu.Quest

package Main.Menu
{
    public class Quest extends AbstractMenuButton 
    {

        public function Quest():void
        {
            super();
            this.buttons.push(new MenuItem("Quests"));
            this.buttons.push(new MenuItem("Quests", function ():void
            {
                Game.root.world.toggleQuestLog();
            }));
        }

    }
}//package Main.Menu

