// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Party.PartyPanel

package Main.Party
{
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.text.TextField;
    import Game_fla.chkBox_32;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;

    public class PartyPanel extends MovieClip 
    {

        public var rootClass:Game = Game.root;
        public var btnRename:SimpleButton;
        public var btnPromote:SimpleButton;
        public var btnInvite:SimpleButton;
        public var btnKick:SimpleButton;
        public var btnClose:SimpleButton;
        public var txtSubtitle1:TextField;
        public var txtSubtitle2:TextField;
        public var txtPartyName:TextField;
        public var txtPromoteName:TextField;
        public var txtInviteName:TextField;
        public var txtKickName:TextField;
        public var chkShareXP:chkBox_32;
        public var mcSlot0:Sprite;
        public var mcSlot1:Sprite;
        public var mcSlot2:Sprite;
        public var mcSlot3:Sprite;
        public var mcSlot4:Sprite;
        public var mcSlot5:Sprite;

        public function PartyPanel()
        {
            addFrameScript(0, this.frame1);
        }

        public function setupParty():void
        {
            var party:* = this.rootClass.world.myAvatar.objData.party;
            this.txtPartyName.text = party.name;
            this.chkShareXP.bitChecked = party.isXPShared;
            this.chkShareXP.checkmark.visible = this.chkShareXP.bitChecked;
            var count:int;
            while (count < party.members.length)
            {
                this[("mcSlot" + count)].createMember(party, party.members[count]);
                count++;
            };
        }

        public function fClose():void
        {
            MovieClip(parent).onClose();
        }

        private function frame1():void
        {
            this.txtSubtitle1.text = "Members";
            this.txtSubtitle2.text = "Operations";
            this.btnRename.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnPromote.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnInvite.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnKick.addEventListener(MouseEvent.CLICK, this.onClick);
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClick);
            this.chkShareXP.removeEventListener(MouseEvent.CLICK, this.chkShareXP.onClick);
            this.chkShareXP.addEventListener(MouseEvent.CLICK, this.onClick);
            this.setupParty();
            stop();
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "chkShareXP":
                    if (!this.rootClass.world.myAvatar.objData.partyRank.ManageParty)
                    {
                        this.rootClass.MsgBox.notify("You don't have the privilege to do such action!");
                        return;
                    };
                    this.chkShareXP.bitChecked = (!(this.chkShareXP.bitChecked));
                    this.chkShareXP.checkmark.visible = this.chkShareXP.bitChecked;
                    this.rootClass.world.partyController.partyUpdate(((this.chkShareXP.bitChecked) ? 1 : 0));
                    break;
                case "btnRename":
                    if (this.txtPartyName.text == "")
                    {
                        this.rootClass.MsgBox.notify("Please insert a valid party name!");
                        return;
                    };
                    if (!this.rootClass.world.myAvatar.objData.partyRank.ManageParty)
                    {
                        this.rootClass.MsgBox.notify("You don't have the privilege to do such action!");
                        return;
                    };
                    this.rootClass.world.partyController.partyRename(this.txtPartyName.text);
                    break;
                case "btnPromote":
                    if (this.txtPromoteName.text == "")
                    {
                        this.rootClass.MsgBox.notify("Please insert a valid player name!");
                        return;
                    };
                    if (!this.rootClass.world.myAvatar.objData.partyRank.ManageParty)
                    {
                        this.rootClass.MsgBox.notify("You don't have the privilege to do such action!");
                        return;
                    };
                    this.rootClass.world.partyController.partyPromote(this.txtPromoteName.text);
                    break;
                case "btnInvite":
                    if (this.txtInviteName.text == "")
                    {
                        this.rootClass.MsgBox.notify("Please insert a valid player name!");
                        return;
                    };
                    if (this.rootClass.world.partyController.partyMembers.length >= 6)
                    {
                        this.rootClass.MsgBox.notify("Your party is already full!");
                        return;
                    };
                    if (this.rootClass.world.partyController.isPartyMember(this.txtInviteName.text))
                    {
                        this.rootClass.MsgBox.notify("Player already a member of your party!");
                        return;
                    };
                    if (!this.rootClass.world.myAvatar.objData.partyRank.ManageMembers)
                    {
                        this.rootClass.MsgBox.notify("You don't have the privilege to do such action!");
                        return;
                    };
                    this.rootClass.world.partyController.partyInvite(this.txtInviteName.text);
                    break;
                case "btnKick":
                    if (this.txtKickName.text == "")
                    {
                        this.rootClass.MsgBox.notify("Please insert a valid player name!");
                        return;
                    };
                    if (!this.rootClass.world.partyController.isPartyMember(this.txtKickName.text))
                    {
                        this.rootClass.MsgBox.notify("Player is not a member of your party!");
                        return;
                    };
                    if (!this.rootClass.world.myAvatar.objData.partyRank.ManageMembers)
                    {
                        this.rootClass.MsgBox.notify("You don't have the privilege to do such action!");
                        return;
                    };
                    this.rootClass.world.partyController.partyKick(this.txtKickName.text);
                    break;
                case "btnClose":
                    Game.root.mixer.playSound("Click");
                    MovieClip(parent).onClose();
                    break;
            };
        }


    }
}//package Main.Party

