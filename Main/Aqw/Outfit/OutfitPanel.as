// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.Outfit.OutfitPanel

package Main.Aqw.Outfit
{
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.utils.ByteArray;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.utils.*;
    import Main.Controller.*;

    public class OutfitPanel extends Sprite 
    {

        public var tl3:MovieClip;
        public var bl1:MovieClip;
        public var bg:MovieClip;
        public var avtDummy:MovieClip;
        public var tr1:MovieClip;
        public var unlockinterface:OutfitUnlock;
        public var tr2:MovieClip;
        public var tl1:MovieClip;
        public var tr3:MovieClip;
        public var btnBack:MovieClip;
        public var br1:MovieClip;
        public var tl2:MovieClip;
        public var r:Game = Game.root;
        public var world:World = Game.root.world;
        public var tt:ToolTipMC;
        public var avatar:AvatarMC;
        public var pAV:Avatar;
        public var interfaceOutfitSets:OutfitSets;

        public function OutfitPanel()
        {
            this.addEventListener(Event.ADDED_TO_STAGE, this.onStage);
        }

        public function get sets():Array
        {
            return (this.world.objInfo["outfitSets"]);
        }

        public function get slots():int
        {
            return (this.world.myAvatar.objData.iLoadoutSlots);
        }

        public function clone(_arg_1:Object):*
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeObject(_arg_1);
            _local_2.position = 0;
            return (_local_2.readObject());
        }

        public function initAvatar():void
        {
            var _local_3:*;
            while (this.avtDummy.numChildren > 0)
            {
                this.avtDummy.removeChildAt(0);
            };
            this.avatar = new AvatarMC();
            this.avatar.world = this.world;
            this.pAV = new Avatar(Game.root);
            this.pAV.items = this.world.myAvatar.items.concat();
            this.pAV.objData = this.clone(this.world.myAvatar.objData);
            this.pAV.dataLeaf = this.clone(this.world.myAvatar.dataLeaf);
            this.pAV.dataLeaf.showHelm = true;
            this.pAV.dataLeaf.showCloak = true;
            this.pAV.isMyAvatar = true;
            this.pAV.firstDone();
            this.avatar.pAV = this.pAV;
            this.avatar.pAV.pMC = this.avatar;
            this.avatar.strGender = this.avatar.pAV.objData.strGender;
            this.avtDummy.addChild(this.avatar);
            for (_local_3 in this.pAV.objData.eqp)
            {
                this.pAV.loadMovieAtES(_local_3, this.pAV.objData.eqp[_local_3].sFile, this.pAV.objData.eqp[_local_3].sLink);
            };
            if (this.pAV.objData.eqp.he == null)
            {
                this.avatar.loadHair();
            };
            this.avatar.hideHPBar();
            this.avatar.shadow.visible = false;
            this.avatar.pname.visible = false;
            this.avatar.scale(3);
        }

        public function initOutfitInterface():void
        {
            this.interfaceOutfitSets = new OutfitSets(this);
            this.addChild(this.interfaceOutfitSets);
            this.interfaceOutfitSets.x = 751.65;
            this.interfaceOutfitSets.y = 315.1;
        }

        public function initSets():void
        {
            var _local_1:*;
            var _local_2:Object;
            this.world.objInfo["outfitSets"] = [];
            for (_local_1 in this.world.objInfo["customs"].loadouts)
            {
                _local_2 = this.r.copyObj(this.world.objInfo["customs"].loadouts[_local_1]);
                _local_2.name = _local_1;
                this.world.objInfo["outfitSets"].push(_local_2);
            };
        }

        public function onServerResponseUpdate():void
        {
            if (this.interfaceOutfitSets != null)
            {
                if (this.interfaceOutfitSets.interfaceOutfitEdit != null)
                {
                    this.interfaceOutfitSets.interfaceOutfitEdit.onServerResponseUpdate();
                };
            };
        }

        public function onServerResponseRemove(_arg_1:String):void
        {
            if (this.interfaceOutfitSets != null)
            {
                this.interfaceOutfitSets.onServerResponseRemove(_arg_1);
            };
        }

        public function slowDown():void
        {
            this.r.MsgBox.notify("Slow down! Last action was too fast.");
        }

        private function organizeSets():void
        {
            var _local_2:*;
            var _local_1:Object = {};
            for each (_local_2 in this.sets)
            {
                _local_1[_local_2.name] = this.r.copyObj(_local_2);
                delete _local_1[_local_2.name].name;
            };
            this.world.objInfo["customs"].loadouts = _local_1;
        }

        public function onStage(_arg_1:Event):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onStage);
            this.initAvatar();
            this.initSets();
            this.initOutfitInterface();
            this.btnBack.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this.world.visible = false;
            this.addChild(new ToolTipMC());
            this.unlockinterface.visible = false;
        }

        public function onClose(mouseEvent:MouseEvent=null):void
        {
            if (this.tt != null)
            {
                this.tt.close();
            };
            this.organizeSets();
            this.world.visible = true;
            UIController.close("outfit");
        }


    }
}//package Main.Aqw.Outfit

