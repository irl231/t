// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Menu.Character

package Main.Menu
{
    import Main.Controller.*;

    public class Character extends AbstractMenuButton 
    {

        public function Character():void
        {
            super();
            this.buttons.push(new MenuItem("Your Hero"));
            this.buttons.push(new MenuItem("Class Overview", function ():void
            {
                Game.root.toggleCharpanel();
            }));
            this.buttons.push(new MenuItem("Stats Overview", function ():void
            {
                Game.root.toggleStatsPanel();
            }));
            this.buttons.push(new MenuItem("Outfits", function ():void
            {
                UIController.show("outfit");
            }));
            this.buttons.push(new MenuItem("Party", function ():void
            {
                Game.root.togglePartyPanel();
            }));
            this.buttons.push(new MenuItem("Daily Login", function ():void
            {
                Game.root.toggleDailyLogin();
            }));
            this.buttons.push(new MenuItem("Redeem Code", function ():void
            {
                Game.root.toggleRedeemPanel();
            }));
            this.buttons.push(new MenuItem("Guildhall", function ():void
            {
                Game.root.world.gotoTown("guildhall", "Enter", "Spawn");
            }));
            this.buttons.push(new MenuItem("PvP Panel", function ():void
            {
                Game.root.togglePVPPanelinMap();
            }));
            this.buttons.push(new MenuItem("Toggle Players", function ():void
            {
                Game.root.toggleAvatarVisibilityOld();
            }));
            this.buttons.push(new MenuItem("Toggle World", function ():void
            {
                Game.root.toggleWorldVisibility();
            }));
            this.buttons.push(new MenuItem("Toggle Joystick", function ():void
            {
                Game.root.toggleJoystick();
            }));
        }

    }
}//package Main.Menu

