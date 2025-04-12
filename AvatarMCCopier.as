// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//AvatarMCCopier

package 
{
    import flash.display.MovieClip;
    import flash.system.ApplicationDomain;
    import flash.events.Event;
    import flash.display.*;
    import Main.Avatar.*;

    public class AvatarMCCopier 
    {

        private var world:World;
        private var mcChar:MovieClip;
        private var objLinks:Object;
        private var pAV:Avatar;
        private var strGender:String;

        public function AvatarMCCopier(world:World):void
        {
            this.objLinks = {};
            this.world = world;
        }

        public function copyTo(character:MovieClip):void
        {
            var part:String;
            var key:String;
            var file:String;
            this.mcChar = character;
            MovieClip(this.mcChar.parent).pAV = this.world.myAvatar;
            this.pAV = this.world.myAvatar;
            this.strGender = this.pAV.objData.strGender;
            var hiddenParts:Array = ["cape", "backhair", "robe", "backrobe"];
            for each (part in hiddenParts)
            {
                if (this.mcChar.hasOwnProperty(part))
                {
                    this.mcChar[part].visible = false;
                };
            };
            if ((((!(this.pAV.dataLeaf.showHelm)) || (!("he" in this.pAV.objData.eqp))) || (this.pAV.objData.eqp.he == null)))
            {
                this.pAV.addLoad(this.pAV.objData.strHairFilename, (this.pAV.LOADER_KEY_PREFIX + "hair"), this.onHairLoadComplete);
            };
            for (key in this.world.myAvatar.objData.eqp)
            {
                file = this.pAV.objData.eqp[key].sFile;
                switch (key)
                {
                    case "Weapon":
                        this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + key), this.onLoadWeaponComplete);
                        break;
                    case "he":
                        if (this.pAV.dataLeaf.showHelm)
                        {
                            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + key), this.onLoadHelmComplete);
                        };
                        break;
                    case "ba":
                        if (this.pAV.dataLeaf.showCloak)
                        {
                            this.pAV.addLoad(file, (this.pAV.LOADER_KEY_PREFIX + key), this.onLoadCapeComplete);
                        };
                        break;
                    case "ar":
                        if (this.world.myAvatar.objData.eqp.co == null)
                        {
                            this.objLinks.ar = this.pAV.objData.eqp.ar.sLink;
                            this.pAV.addLoad(((("classes/" + this.strGender) + "/") + this.pAV.objData.eqp[key].sFile), (this.pAV.LOADER_KEY_PREFIX + key), this.onLoadArmorComplete);
                        };
                        break;
                    case "co":
                        this.objLinks.ar = this.pAV.objData.eqp.co.sLink;
                        this.pAV.addLoad(((("classes/" + this.strGender) + "/") + this.pAV.objData.eqp[key].sFile), (this.pAV.LOADER_KEY_PREFIX + key), this.onLoadArmorComplete);
                        break;
                };
            };
        }

        public function loadArmorPieces(linkage:String):void
        {
            var applicationDomain:ApplicationDomain = this.pAV.applicationDomain;
            if (AvatarUtil.build(applicationDomain, this.mcChar.head, ((linkage + this.strGender) + "Head")) == null)
            {
                AvatarUtil.build(applicationDomain, this.mcChar.head, ("mcHead" + this.strGender));
            };
            AvatarUtil.build(applicationDomain, this.mcChar.chest, ((linkage + this.strGender) + "Chest"));
            AvatarUtil.build(applicationDomain, this.mcChar.hip, ((linkage + this.strGender) + "Hip"));
            AvatarUtil.build(applicationDomain, this.mcChar.idlefoot, ((linkage + this.strGender) + "FootIdle"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontfoot, ((linkage + this.strGender) + "Foot"));
            this.mcChar.frontfoot.visible = false;
            AvatarUtil.build(applicationDomain, this.mcChar.backfoot, ((linkage + this.strGender) + "Foot"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontshoulder, ((linkage + this.strGender) + "Shoulder"));
            AvatarUtil.build(applicationDomain, this.mcChar.backshoulder, ((linkage + this.strGender) + "Shoulder"));
            AvatarUtil.build(applicationDomain, this.mcChar.fronthand, ((linkage + this.strGender) + "Hand"));
            AvatarUtil.build(applicationDomain, this.mcChar.backhand, ((linkage + this.strGender) + "Hand"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontthigh, ((linkage + this.strGender) + "Thigh"));
            AvatarUtil.build(applicationDomain, this.mcChar.backthigh, ((linkage + this.strGender) + "Thigh"));
            AvatarUtil.build(applicationDomain, this.mcChar.frontshin, ((linkage + this.strGender) + "Shin"));
            AvatarUtil.build(applicationDomain, this.mcChar.backshin, ((linkage + this.strGender) + "Shin"));
            if (AvatarUtil.build(applicationDomain, this.mcChar.robe, ((linkage + this.strGender) + "Robe")) == null)
            {
                this.mcChar.robe.getChildAt(0).visible = false;
            };
            if (AvatarUtil.build(applicationDomain, this.mcChar.backrobe, ((linkage + this.strGender) + "RobeBack")) == null)
            {
                this.mcChar.backrobe.getChildAt(0).visible = false;
            };
        }

        public function d(_arg1:String):void
        {
            var AssetClass:Class;
            var strSkinLinkage:String = _arg1;
            try
            {
                AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Head")) as Class);
                this.mcChar.head.addChildAt(new (AssetClass)(), 0);
                this.mcChar.head.removeChildAt(1);
            }
            catch(err:Error)
            {
                AssetClass = (world.getClass(("mcHead" + strGender)) as Class);
                mcChar.head.addChildAt(new (AssetClass)(), 0);
                mcChar.head.removeChildAt(1);
            };
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Chest")) as Class);
            this.mcChar.chest.removeChildAt(0);
            this.mcChar.chest.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Hip")) as Class);
            this.mcChar.hip.removeChildAt(0);
            this.mcChar.hip.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "FootIdle")) as Class);
            this.mcChar.idlefoot.removeChildAt(0);
            this.mcChar.idlefoot.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Foot")) as Class);
            this.mcChar.frontfoot.removeChildAt(0);
            this.mcChar.frontfoot.addChild(new (AssetClass)());
            this.mcChar.frontfoot.visible = false;
            this.mcChar.backfoot.removeChildAt(0);
            this.mcChar.backfoot.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Shoulder")) as Class);
            this.mcChar.frontshoulder.removeChildAt(0);
            this.mcChar.frontshoulder.addChild(new (AssetClass)());
            this.mcChar.backshoulder.removeChildAt(0);
            this.mcChar.backshoulder.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Hand")) as Class);
            this.mcChar.fronthand.removeChildAt(0);
            this.mcChar.fronthand.addChild(new (AssetClass)());
            this.mcChar.backhand.removeChildAt(0);
            this.mcChar.backhand.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Thigh")) as Class);
            this.mcChar.frontthigh.removeChildAt(0);
            this.mcChar.frontthigh.addChild(new (AssetClass)());
            this.mcChar.backthigh.removeChildAt(0);
            this.mcChar.backthigh.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Shin")) as Class);
            this.mcChar.frontshin.removeChildAt(0);
            this.mcChar.frontshin.addChild(new (AssetClass)());
            this.mcChar.backshin.removeChildAt(0);
            this.mcChar.backshin.addChild(new (AssetClass)());
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "Robe")) as Class);
            if (AssetClass != null)
            {
                this.mcChar.robe.removeChildAt(0);
                this.mcChar.robe.addChild(new (AssetClass)());
                this.mcChar.robe.visible = true;
            }
            else
            {
                this.mcChar.robe.visible = false;
            };
            AssetClass = (this.world.getClass(((strSkinLinkage + this.strGender) + "RobeBack")) as Class);
            if (AssetClass != null)
            {
                this.mcChar.backrobe.removeChildAt(0);
                this.mcChar.backrobe.addChild(new (AssetClass)());
                this.mcChar.backrobe.visible = true;
            }
            else
            {
                this.mcChar.backrobe.visible = false;
            };
        }

        public function onLoadArmorComplete(event:Event):void
        {
            this.loadArmorPieces(this.objLinks.ar);
        }

        public function onHairLoadComplete(event:Event):void
        {
            if (this.mcChar.head == undefined)
            {
                return;
            };
            var HairClass:Class = this.world.getClass(((this.pAV.objData.strHairName + this.pAV.objData.strGender) + "Hair"));
            if (HairClass != null)
            {
                this.mcChar.head.hair.removeChildren();
                this.mcChar.head.hair.addChild(new (HairClass)());
            };
            if (this.mcChar.backhair == undefined)
            {
                return;
            };
            var HairBackClass:Class = this.world.getClass(((this.pAV.objData.strHairName + this.pAV.objData.strGender) + "HairBack"));
            if (HairBackClass != null)
            {
                this.mcChar.backhair.removeChildren();
                this.mcChar.backhair.addChild(new (HairBackClass)());
            };
        }

        public function onLoadWeaponComplete(event:Event):void
        {
            var AssetClass:Class;
            if (this.mcChar.weapon == undefined)
            {
                return;
            };
            this.mcChar.weapon.removeChildAt(0);
            try
            {
                AssetClass = this.world.getClass(this.pAV.objData.eqp.Weapon.sLink);
                if (this.pAV.objData.eqp.Weapon.sType == "Gauntlet")
                {
                    this.mcChar.fronthand.addChildAt(new (AssetClass)(), 1);
                }
                else
                {
                    this.mcChar.weapon.addChild(new (AssetClass)());
                };
            }
            catch(err:Error)
            {
                this.mcChar.weapon.addChild(event.target.content);
            };
        }

        public function onLoadCapeComplete(event:Event):void
        {
            if (this.mcChar.cape == undefined)
            {
                return;
            };
            var CapeClass:Class = this.world.getClass(this.pAV.objData.eqp.ba.sLink);
            this.mcChar.cape.removeChildren();
            this.mcChar.cape.addChild(new (CapeClass)());
        }

        public function onLoadHelmComplete(event:Event):void
        {
            if (this.mcChar.head == undefined)
            {
                return;
            };
            var HelmClass:Class = this.world.getClass(this.pAV.objData.eqp.he.sLink);
            if (HelmClass != null)
            {
                this.mcChar.head.helm.removeChildAt(0);
                this.mcChar.head.helm.addChild(new (HelmClass)());
            };
        }


    }
}//package 

