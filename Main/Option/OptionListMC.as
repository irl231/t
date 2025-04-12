// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Option.OptionListMC

package Main.Option
{
    import flash.display.MovieClip;
    import Main.Aqw.LPF.LPFElementScrollBar;
    import flash.text.TextField;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OptionListMC extends MovieClip 
    {

        public var game:Game = Game.root;
        public var listScroll:LPFElementScrollBar;
        public var listMask:MovieClip;
        public var listOption:MovieClip;
        public var listBackground:MovieClip;
        public var listBackdrop:MovieClip;
        public var listFilter:MovieClip;
        public var listLabel:TextField;
        public var listSearch:SimpleButton;
        public var listTitle:String;
        public var listOptions:Array;
        public var intWidth:Number;
        public var intHeight:Number;

        public function OptionListMC()
        {
            super();
            this.listFilter.visible = false;
            this.listSearch.addEventListener(MouseEvent.MOUSE_DOWN, this.onClick);
            this.listFilter.txtSearch.addEventListener(Event.CHANGE, function (event:Event):void
            {
                distribute(listTitle, listOptions, intWidth, intHeight);
            });
        }

        public function distribute(title:String, options:Array, width:Number=269.45, height:Number=169.4, disableScroll:Boolean=false):void
        {
            var searchTerm:String;
            var option:Object;
            this.listTitle = title;
            this.listOptions = options;
            this.intWidth = width;
            this.intHeight = height;
            this.listBackground.width = this.intWidth;
            this.listBackdrop.width = (this.listBackground.width - 18);
            this.listMask.width = this.listBackdrop.width;
            this.listSearch.x = (this.listBackground.width - this.listSearch.width);
            this.listScroll.x = ((this.listBackground.width - this.listScroll.width) - 2);
            this.listFilter.x = ((this.listSearch.x - this.listFilter.width) - 5);
            this.listBackground.height = height;
            this.listBackdrop.height = this.listBackground.height;
            this.listMask.height = this.listBackground.height;
            while (this.listOption.numChildren > 0)
            {
                this.listOption.removeChildAt(0);
            };
            searchTerm = this.listFilter.txtSearch.text.toLowerCase();
            var filteredOptions:Array = this.listOptions.filter(function (option:Object, index:int, array:Array):Boolean
            {
                return (option.strName.toLowerCase().indexOf(searchTerm) >= 0);
            });
            this.listLabel.text = this.listTitle;
            var i:int;
            while (i < filteredOptions.length)
            {
                if (this.game.world.myAvatar.objData.intAccessLevel < filteredOptions[i].intAccess)
                {
                }
                else
                {
                    option = filteredOptions[i];
                    option.component.y = (option.component.height * i);
                    if (option.component.hasOwnProperty("set"))
                    {
                        option.component.set(option, this.listBackdrop.width);
                    };
                    this.listOption.addChild(option.component);
                };
                i = (i + 1);
            };
            Game.configureScroll(this.listOption, this.listMask, this.listScroll, (this.listMask.height - 9), true, disableScroll);
        }

        private function onClick(event:MouseEvent):void
        {
            switch (event.currentTarget.name)
            {
                case "listSearch":
                    this.listFilter.visible = (!(this.listFilter.visible));
                    break;
            };
        }


    }
}//package Main.Option

