// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Game_fla.Respawn

package Game_fla
{
    import flash.display.MovieClip;
    import flash.display.*;

    public dynamic class Respawn extends MovieClip 
    {

        public var mcContent:MovieClip;
        public var mcTomb:MovieClip;
        public var rootClass:*;
        public var arrTips:Array;

        public function Respawn()
        {
            addFrameScript(0, this.frame1, 4, this.frame5, 19, this.frame20, 56, this.frame57);
        }

        internal function frame1():*
        {
            this.rootClass = MovieClip(stage.getChildAt(0));
            this.arrTips = ["Never give you password to ANYONE. AQW staff will never ask for it.", "Never share your password or your account with anyone.", "Sharing accounts is against the rules and might get you banned!", "Strength improves your chance of a critical strike for melee classes.", "Learn about Enhancing your weapons by clicking the ENHANCEMENT button in Battleon!", "Keep your enhancements up to date!", "Remember to rest in between battles!", "Intellect increases Magic Power and boosts magical damage and crit for caster classes.", "Wisdom only increases evasion for melee classes.", "Make sure yo read your tool tips for each skill you unlock!", "Mayonnaise should never be heated. It might make you ill!", "We were all noobs once. Help out new players!", "Members get access to special Member-only areas, classes and items!", "Don't stare at the sun.", "If someone is misbehaving, click on their character portrait to report them!", "Go easy on the carbs unless you move a lot.", '"A lot" is two words, not one.', "Sneevils LOVE boxes!", "You can get more item storage from the BANK! Visit Valencia in Battleontown!", "You can store items you got with AdventureCoins for FREE in the bank!", "Try having breakfast for dinner. You can thank me later.", "Clown pants are not heroic.", "Remember to link your AQW account to your MASTER ACCOUNT for additional safety!", "Lost? You can always /join BattleOn", "Trying to catch up with a friend? Type /goto <player name>", "You can hide the chat panel by clicking on the arrow on your interface.", "If someone is being rude you can IGNORE them by clicking on their character portrait.", "To Reply to a private message, just type /r and hit ENTER!", "Gain experience, gold and rep by completing quests.", "You can buy more space in your backpack from Valencia in Battleontown!", "You can use potions or food in battle if you equip it!", "Spotted a game bug? Report it on the official AQW forums!", "Staff will NEVER offer you free items, gold, ACs, or membership over Twitter or Facebook.", "Looking for things to do? Check your Book of Lore or the Adventure Button in Battleon!", "Always read the AQW Design Notes to find out what's coming next!", "Check out HEROMART.COM for lots of cool AQW shirts, games and more!", "Buying stuff at HEROMART.COM will earn you special in-game items!", "Game Moderators, Developers and Staff always have a gold name above their head.", "Give us your feedback on this week's release on the forum, Twitter and Facebook!", "Do not share your account information with ANYONE, no matter what they promise you.", "Confirm your email to unlock chat and gain Power Gem! Refer a friend to get Friend Gems and unlock Twilly's shop!", "Never give your email password to anyone!", "Cysero's left sock might be in your backpack right now!", "Don't give up now, you're just about to win!", "YOU are the only Hero who can save Lore. You must return to battle!", "Never leave home without an extra HP potion!"];
            stop();
        }

        internal function frame5():*
        {
            this.visible = true;
            this.mcContent.txtTip.htmlText = ("<b>Death's Note:</b> " + this.arrTips[Math.floor((Math.random() * this.arrTips.length))]);
        }

        internal function frame20():*
        {
            stop();
        }

        internal function frame57():*
        {
            stop();
        }


    }
}//package Game_fla

