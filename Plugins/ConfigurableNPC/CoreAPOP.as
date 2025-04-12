// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Plugins.ConfigurableNPC.CoreAPOP

package Plugins.ConfigurableNPC
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import Main.Aqw.LPF.*;

    public class CoreAPOP extends MovieClip 
    {

        public var rootClass:Game;
        public var objSettings:Object;
        public var mcButtonListVertical:MovieClip;
        public var mcButtonListHorizontal:MovieClip;
        public var dialogueIndex:int = 0;
        public var txtName:TextField;
        public var txtSubtitle:TextField;
        public var txtContext:TextField;
        public var btnContinue:MovieClip;
        public var btnTalk:MovieClip;
        public var btnBack:MovieClip;

        public function CoreAPOP(objSettings:Object, rootClass:Game)
        {
            this.rootClass = rootClass;
            this.objSettings = objSettings;
            this.txtName.text = objSettings.strUsername;
            this.txtSubtitle.text = objSettings.strClassName;
            this.createDialogue();
            this.createAction();
            rootClass.world.openAPOP(objSettings.NpcMapID);
        }

        public function createDialogue():void
        {
            this.btnTalk.visible = false;
            this.btnTalk.txtName.mouseEnabled = false;
            this.btnTalk.txtName.text = "Talk";
            this.btnContinue.visible = false;
            this.btnContinue.txtName.mouseEnabled = false;
            this.btnContinue.txtName.text = "Continue";
            this.btnBack.visible = false;
            this.btnBack.txtName.mouseEnabled = false;
            this.btnBack.txtName.text = "Back";
            if (this.objSettings.dialogues.length == 0)
            {
                this.txtContext.htmlText = "<b><font color='#FF0000'>[WARNING!]</font></b> This NPC does not have a dialogue, PLEASE do make at least one.";
                return;
            };
            if (!this.btnTalk.hasEventListener(MouseEvent.CLICK))
            {
                this.btnTalk.addEventListener(MouseEvent.CLICK, this.onClickGeneral);
            };
            if (!this.btnContinue.hasEventListener(MouseEvent.CLICK))
            {
                this.btnContinue.addEventListener(MouseEvent.CLICK, this.onClickGeneral);
            };
            if (!this.btnBack.hasEventListener(MouseEvent.CLICK))
            {
                this.btnBack.addEventListener(MouseEvent.CLICK, this.onClickGeneral);
            };
            this.txtContext.htmlText = String(this.objSettings.dialogues[this.dialogueIndex]).replace("{user}", (("<b>" + Game.root.strToProperCase(Game.root.world.myAvatar.objData.strUsername)) + "</b>"));
            switch (true)
            {
                case (this.objSettings.dialogues.length <= 1):
                    this.btnContinue.visible = false;
                    this.btnBack.visible = false;
                    break;
                case ((this.dialogueIndex == 0) && (this.objSettings.dialogues.length > 1)):
                    this.btnTalk.visible = true;
                    break;
                case (this.dialogueIndex == (this.objSettings.dialogues.length - 1)):
                    this.btnTalk.txtName.text = "Done";
                    this.btnTalk.visible = true;
                    break;
                default:
                    this.btnContinue.visible = true;
                    this.btnBack.visible = true;
            };
        }

        public function createAction():void
        {
            var mcButtonList:MovieClip;
            var action:Object;
            var button:CoreButton;
            var i:int;
            var btn:CoreButton;
            var j:int;
            var btnVertical:CoreButton;
            var mask:DisplayObject;
            var mcScroll:DisplayObject;
            var padding:int;
            var startX:int = 15;
            var startY:int;
            var maxButtonsPerRow:int = 4;
            var buttonsInRow:int;
            var totalWidth:int;
            var sumButtonWidths:int;
            var numButtons:int;
            if (((this.objSettings.dialogues.length > 1) || (this.objSettings.actions.length >= maxButtonsPerRow)))
            {
                mcButtonList = this.mcButtonListVertical;
                if (this.objSettings.face.toLowerCase() == "left")
                {
                    mcButtonList.x = startX;
                };
            }
            else
            {
                mcButtonList = this.mcButtonListHorizontal;
            };
            for each (action in this.objSettings.actions)
            {
                if (((!(action.isStaffOnly)) || ((action.isStaffOnly) && (this.rootClass.world.myAvatar.isStaff()))))
                {
                    button = new CoreButton(action.Name, action.NameColor, action.Subtitle, action.SubtitleColor, action.Action, action.Value, action.Icon, action.iQSindex, action.iQSvalue);
                    mcButtonList.addChild(button);
                    button.name = "btnButton";
                    if (mcButtonList == this.mcButtonListHorizontal)
                    {
                        sumButtonWidths = (sumButtonWidths + button.width);
                        numButtons++;
                    };
                };
            };
            if (mcButtonList == this.mcButtonListHorizontal)
            {
                totalWidth = (sumButtonWidths + ((numButtons - 1) * 5));
                startX = int((-(totalWidth) / 2));
                padding = 0;
                buttonsInRow = 0;
                i = 0;
                while (i < mcButtonList.numChildren)
                {
                    btn = CoreButton(mcButtonList.getChildAt(i));
                    if (btn)
                    {
                        btn.x = (startX + padding);
                        btn.y = startY;
                        padding = (padding + (btn.width + 5));
                        buttonsInRow++;
                        if (buttonsInRow >= maxButtonsPerRow)
                        {
                            buttonsInRow = 0;
                            startY = (startY + (btn.height + 5));
                            padding = 0;
                        };
                    };
                    i++;
                };
            }
            else
            {
                j = 0;
                while (j < mcButtonList.numChildren)
                {
                    btnVertical = CoreButton(mcButtonList.getChildAt(j));
                    if (btnVertical)
                    {
                        btnVertical.x = startX;
                        btnVertical.y = (startY + padding);
                        padding = (padding + (btnVertical.height + 5));
                    };
                    j++;
                };
            };
            if (((mcButtonList == this.mcButtonListVertical) && (this.objSettings.actions.length > maxButtonsPerRow)))
            {
                mask = addChild(new mcMask());
                mask.x = mcButtonList.x;
                mask.y = mcButtonList.y;
                mask.width = mcButtonList.width;
                mask.height = 175;
                mcScroll = addChild(new LPFElementScrollBar());
                mcScroll.x = ((mcButtonList.x + mcButtonList.width) + 5);
                mcScroll.y = (mcButtonList.y + 20);
                Game.configureScroll(mcButtonList, MovieClip(mask), MovieClip(mcScroll), (mask.height - 15));
                mask.height = 180;
                mask.y = (mask.y - 5);
            };
        }

        public function onClickGeneral(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "btnContinue":
                case "btnTalk":
                    this.dialogueIndex = ((this.btnTalk.txtName.text != "Done") ? (this.dialogueIndex + 1) : 0);
                    this.createDialogue();
                    break;
                case "btnBack":
                    this.dialogueIndex = (this.dialogueIndex - 1);
                    this.createDialogue();
                    break;
            };
        }


    }
}//package Plugins.ConfigurableNPC

