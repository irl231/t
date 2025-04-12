// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.MapMenu

package Main.UI
{
    import Plugins.MapBuilder.OptionPad;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import Main.Model.Item;
    import flash.geom.Rectangle;
    import flash.display.MovieClip;
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import Plugins.MapBuilder.*;
    import Main.*;

    public class MapMenu extends AbstractPanel 
    {

        private var itemSelected:OptionPad = null;
        private var items:Vector.<OptionPad> = new Vector.<OptionPad>();

        public function MapMenu(game:Game):void
        {
            super(game);
        }

        override protected function onAddedToStage(event:Event):void
        {
            var pad:OptionPad;
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            this.drag = new Drag(this, this.hit);
            this.hit.alpha = 0;
            for each (pad in this.game.world.mapController.options)
            {
                this.dropItem(pad);
            };
            this.btnClose.addEventListener(MouseEvent.CLICK, this.onClickClose);
            this.preview.bAdd.addEventListener(MouseEvent.CLICK, this.onClickAccept);
            this.preview.bDel.addEventListener(MouseEvent.CLICK, this.onClickDeny);
            this.preview.bDel.visible = false;
            this.preview.bAdd.x = 28;
            this.buildA();
        }

        override protected function buildA():void
        {
            var item:OptionPad;
            var i:int;
            var itemType:String;
            var protoA:hProto;
            this.game.onRemoveChildrens(iListA.iList);
            var types:Array = [];
            for each (item in this.items)
            {
                if (types.indexOf(item.category) == -1)
                {
                    types.push(item.category);
                };
            };
            this.iListB.visible = false;
            this.preview.visible = false;
            var maxWidth:Number = 75;
            i = 0;
            for each (itemType in types)
            {
                protoA = hProto(MovieClip(iListA.iList).addChild(new hProto()));
                protoA.ti.text = itemType;
                protoA.ti.autoSize = "left";
                if (protoA.ti.textWidth > maxWidth)
                {
                    maxWidth = protoA.ti.textWidth;
                };
                protoA.hit.alpha = 0;
                protoA.itemType = itemType;
                protoA.addEventListener(MouseEvent.CLICK, onClickProtoA);
                protoA.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverProto, false, 0, true);
                protoA.y = (protoA.height * i);
                protoA.buttonMode = true;
                protoA.bg.visible = false;
                i++;
            };
            resizeMe(iListA, maxWidth);
            new Scroll(this.iListA.scr, this.iListA.iList, this.iListA.imask, this.iListA.scr.hit, this.iListA.scr.h, this.iListA.scr.b);
        }

        override protected function buildB(proto:hProto):void
        {
            var item:OptionPad;
            var protoB:hProto;
            this.game.onRemoveChildrens(iListB.iList);
            this.preview.visible = false;
            this.iListB.visible = true;
            var maxWidth:Number = 75;
            var j:int;
            for each (item in this.items)
            {
                if (proto.itemType == item.category)
                {
                    protoB = hProto(MovieClip(iListB.iList).addChild(new hProto()));
                    protoB.ti.htmlText = item.name;
                    protoB.ti.autoSize = "left";
                    if (protoB.ti.textWidth > maxWidth)
                    {
                        maxWidth = protoB.ti.textWidth;
                    };
                    protoB.hit.alpha = 0;
                    protoB.item = item;
                    protoB.addEventListener(MouseEvent.CLICK, this.onClickProtoB);
                    protoB.addEventListener(MouseEvent.MOUSE_OVER, onMouseOverProto, false, 0, true);
                    protoB.y = (protoB.height * j);
                    protoB.buttonMode = true;
                    protoB.bg.visible = false;
                    j++;
                };
            };
            resizeMe(iListB, maxWidth);
            new Scroll(this.iListB.scr, this.iListB.iList, this.iListB.imask, this.iListB.scr.hit, this.iListB.scr.h, this.iListB.scr.b);
        }

        override protected function onClickProtoB(mouseEvent:MouseEvent):void
        {
            var proto:hProto;
            if (this.preview.content.numChildren > 0)
            {
                game.onRemoveChildrens(this.preview.content);
            };
            proto = hProto(mouseEvent.currentTarget);
            this.itemSelected = proto.item;
            var item:OptionPad = proto.item;
            this.preview.content.x = 70;
            this.preview.content.y = 80;
            this.onLoadItem();
        }

        override public function onClickClose(event:MouseEvent):void
        {
            this.onHide();
        }

        override public function onShow():void
        {
            this.game.world.mapController.visible(true);
            super.onShow();
        }

        override public function onHide():void
        {
            this.game.world.mapController.visible(false);
            super.onDestroy();
        }

        public function dropItem(itemObj:OptionPad):void
        {
            this.items.push(itemObj);
            this.onShow();
            this.buildA();
        }

        public function getDrop(itemObj:Object):void
        {
            var item:Item;
            for each (item in this.items)
            {
                if (item.ItemID == itemObj.ItemID)
                {
                    this.items.removeAt(this.items.indexOf(item));
                };
            };
            this.buildA();
        }

        private function previewHandler(movieClip:MovieClip):void
        {
            var containerWidth:int = 115;
            var containerHeight:int = 115;
            var scale:Number = (((containerHeight / containerWidth) > (movieClip.height / movieClip.width)) ? (containerWidth / movieClip.width) : (containerHeight / movieClip.height));
            movieClip.scaleX = scale;
            movieClip.scaleY = scale;
            movieClip.x = 0;
            movieClip.y = 0;
            movieClip.visible = true;
            this.preview.content.addChild(movieClip);
            this.preview.mcSpecial.visible = false;
            this.preview.mcUpgrade.visible = false;
            this.preview.visible = true;
            var rectangle:Rectangle = movieClip.getBounds(this);
            if (rectangle.height > 113)
            {
                movieClip.scaleX = (movieClip.scaleX * (113 / rectangle.height));
                movieClip.scaleY = (movieClip.scaleY * (113 / rectangle.height));
            };
            movieClip.x = (this.preview.x - int(((movieClip.getBounds(this).x + (movieClip.getBounds(this).width >> 1)) - 65)));
            movieClip.y = int((this.preview.y - movieClip.getBounds(this).y));
            resizeMe();
        }

        private function onClickAccept(e:MouseEvent):void
        {
            this.game.network.send("frameAdd", [this.itemSelected.name]);
        }

        private function onClickDeny(e:MouseEvent):void
        {
        }

        private function onLoadItem():void
        {
            var link:Class = this.game.world.getClass(this.itemSelected.link);
            var icon:MovieClip = new link("");
            this.preview.content.x = 20;
            this.preview.content.y = 0;
            this.previewHandler(icon);
        }


    }
}//package Main.UI

