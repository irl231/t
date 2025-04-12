// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Avatar.AvatarColor

package Main.Avatar
{
    import flash.utils.Dictionary;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import fl.motion.AdjustColor;
    import flash.display.DisplayObjectContainer;
    import flash.display.*;
    import fl.motion.*;
    import flash.filters.*;
    import flash.utils.*;

    public class AvatarColor 
    {

        public static const validParentNames:Array = ["weapon", "weaponFist", "weaponOff", "weaponFistOff", "helm", "Face", "cape", "petMC", "mcPreview"];
        public static const processedShapes:Dictionary = new Dictionary();


        public static function changeColorSpecial(mc:MovieClip, item:Object, isPet:Boolean=false):void
        {
            if (((((((item) && (!(item.iHue == null))) && (!(item.iBrightness == null))) && (!(item.iContrast == null))) && (!(item.iSaturation == null))) && (!((((item.iHue === 0) && (item.iBrightness === 0)) && (item.iContrast === 0)) && (item.iSaturation === 0)))))
            {
                applyColorToAllChildren(mc, item, isPet);
            };
            if (((item) && (item.iReset == 1)))
            {
                item.iReset = 0;
                applyColorToAllChildren(mc, item, isPet);
            };
        }

        public static function wrapInMovieClip(child:DisplayObject):MovieClip
        {
            var wrapper:MovieClip = new MovieClip();
            wrapper.name = (child.name + "_wrapper");
            wrapper.addChild(child);
            wrapper.x = child.x;
            wrapper.y = child.y;
            child.x = 0;
            child.y = 0;
            return (wrapper);
        }

        public static function applyColorToAllChildren(container:MovieClip, color:Object, isPet:Boolean):void
        {
            var i:int;
            var child:DisplayObject;
            var adjustColor:AdjustColor;
            var movieClipChild:MovieClip;
            var apply:*;
            if (container != null)
            {
                i = 0;
                while (i < container.numChildren)
                {
                    child = container.getChildAt(i);
                    if ((((child is Shape) || (child is Graphics)) || (child is Bitmap)))
                    {
                        if (!processedShapes[child])
                        {
                            adjustColor = new AdjustColor();
                            adjustColor.brightness = color.iBrightness;
                            adjustColor.contrast = color.iContrast;
                            adjustColor.hue = color.iHue;
                            adjustColor.saturation = color.iSaturation;
                            child.filters = [new ColorMatrixFilter(adjustColor.CalculateFinalFlatArray())];
                        };
                    };
                    if ((child is MovieClip))
                    {
                        movieClipChild = MovieClip(child);
                        if (((!(movieClipChild["isColored"])) && (!(movieClipChild["isSkip"]))))
                        {
                            apply = applyColorAdjustmentToShapeParents(movieClipChild, color, isPet);
                            if (apply)
                            {
                                applyColorToAllChildren(movieClipChild, color, isPet);
                            };
                        }
                        else
                        {
                            revertFiltersOnParents(movieClipChild);
                        };
                    };
                    i++;
                };
            };
        }

        public static function applyColorAdjustmentToShapeParents(mc:MovieClip, item:Object, isPet:Boolean):Boolean
        {
            var petFilters:Array;
            var child:DisplayObject;
            var container:DisplayObjectContainer;
            var j:int;
            var shapeChild:DisplayObject;
            var currentFilters:Array;
            var newFilters:Array;
            var k:int;
            var adjustColor:AdjustColor = new AdjustColor();
            adjustColor.brightness = item.iBrightness;
            adjustColor.contrast = item.iContrast;
            adjustColor.hue = item.iHue;
            adjustColor.saturation = item.iSaturation;
            if (isPet)
            {
                petFilters = [new ColorMatrixFilter(adjustColor.CalculateFinalFlatArray())];
                mc.filters = petFilters;
                return (false);
            };
            var glowColor:uint = hueToColor(item.iHue);
            var i:int;
            while (i < mc.numChildren)
            {
                child = mc.getChildAt(i);
                if ((child is DisplayObjectContainer))
                {
                    container = (child as DisplayObjectContainer);
                    if (((container is MovieClip) && (container["isSkip"])))
                    {
                    }
                    else
                    {
                        j = 0;
                        while (j < container.numChildren)
                        {
                            shapeChild = container.getChildAt(j);
                            if (shapeChild != null)
                            {
                                currentFilters = ((shapeChild.filters) ? shapeChild.filters.slice() : []);
                                newFilters = [];
                                k = 0;
                                while (k < currentFilters.length)
                                {
                                    if ((currentFilters[k] is GlowFilter))
                                    {
                                        currentFilters[k].color = glowColor;
                                        newFilters.push(currentFilters[k]);
                                    };
                                    if ((currentFilters[k] is BlurFilter))
                                    {
                                        newFilters.push(currentFilters[k]);
                                    };
                                    k++;
                                };
                                if ((shapeChild is MovieClip))
                                {
                                    if (isAnimated(shapeChild))
                                    {
                                        newFilters.push(new ColorMatrixFilter(adjustColor.CalculateFinalFlatArray()));
                                        setSkipOnNestedChildren((shapeChild as MovieClip));
                                    };
                                    shapeChild.filters = newFilters;
                                };
                            };
                            j++;
                        };
                    };
                };
                i++;
            };
            return (true);
        }

        public static function hueToColor(hue:Number):uint
        {
            var r:Number;
            var g:Number;
            var b:Number;
            hue = (hue % 360);
            if (hue < 0)
            {
                hue = (hue + 360);
            };
            var i:int = int((int((hue / 60)) % 6));
            var f:Number = ((hue / 60) - i);
            var p:Number = 0;
            var q:Number = (1 - f);
            var t:Number = f;
            switch (i)
            {
                case 0:
                    r = 1;
                    g = t;
                    b = p;
                    break;
                case 1:
                    r = q;
                    g = 1;
                    b = p;
                    break;
                case 2:
                    r = p;
                    g = 1;
                    b = t;
                    break;
                case 3:
                    r = p;
                    g = q;
                    b = 1;
                    break;
                case 4:
                    r = t;
                    g = p;
                    b = 1;
                    break;
                case 5:
                    r = 1;
                    g = p;
                    b = q;
                    break;
            };
            return (((int((r * 0xFF)) << 16) | (int((g * 0xFF)) << 8)) | int((b * 0xFF)));
        }

        public static function setSkipOnNestedChildren(mc:MovieClip):void
        {
            var nestedChild:DisplayObject;
            mc["isSkip"] = true;
            var k:int;
            while (k < mc.numChildren)
            {
                nestedChild = mc.getChildAt(k);
                if ((nestedChild is MovieClip))
                {
                    setSkipOnNestedChildren((nestedChild as MovieClip));
                };
                k++;
            };
        }

        public static function isAnimated(container:DisplayObjectContainer):Boolean
        {
            return ((container is MovieClip) && (MovieClip(container).totalFrames > 1));
        }

        public static function revertFiltersOnParents(displayObject:DisplayObjectContainer):void
        {
            var currentParent:DisplayObjectContainer = displayObject.parent;
            while (currentParent != null)
            {
                if (AvatarColor.validParentNames.indexOf(currentParent.name) != -1)
                {
                    break;
                };
                if (isAnimated(currentParent))
                {
                    currentParent = currentParent.parent;
                }
                else
                {
                    if (((currentParent.filters) && (currentParent.filters.length > 0)))
                    {
                        currentParent.filters = [];
                    };
                    currentParent = currentParent.parent;
                };
            };
        }

        public static function scanColorSpecial(avatar:Object, pMC:MovieClip):void
        {
            var baseItemsObj:Object = (((!(avatar == null)) || (!(avatar.eqp == null))) ? avatar.eqp : pMC.pAV.objData.eqp);
            if (baseItemsObj == null)
            {
                return;
            };
            if (pMC.name == "mcHead")
            {
                applyColorForItem(baseItemsObj, "he", pMC.head.helm);
                applyColorForItem(baseItemsObj, "co", pMC.head.face);
                applyColorForItem(baseItemsObj, "ar", pMC.head.face);
                return;
            };
            applyArmorColors(((baseItemsObj["co"]) || (baseItemsObj["ar"])), pMC.mcChar);
            applyWeaponColors(baseItemsObj["Weapon"], pMC.mcChar);
            applyColorForItem(baseItemsObj, "ba", pMC.mcChar.cape);
            applyColorForItem(baseItemsObj, "he", pMC.mcChar.head.helm);
            applyColorForItem(baseItemsObj, "co", pMC.mcChar.head.face);
            applyColorForItem(baseItemsObj, "ar", pMC.mcChar.head.face);
            applyColorForItem(baseItemsObj, "mi", pMC.cShadow);
            applyColorForItem(baseItemsObj, "pe", pMC.pAV.petMC);
            applyColorForItem(baseItemsObj, "en", pMC.entityMC);
        }

        public static function applyColorForItem(baseItemsObj:Object, key:String, targetMovieClip:MovieClip):void
        {
            if ((key in baseItemsObj))
            {
                changeColorSpecial(targetMovieClip, baseItemsObj[key], ((key == "pe") || (key == "mi")));
            };
        }

        public static function applyWeaponColors(weaponColor:Object, mcChar:MovieClip):void
        {
            changeColorSpecial(mcChar.weapon, weaponColor);
            changeColorSpecial(mcChar.weaponFist, weaponColor);
            changeColorSpecial(mcChar.weaponFistOff, weaponColor);
            changeColorSpecial(mcChar.weaponOff, weaponColor);
        }

        public static function applyArmorColors(armor:Object, mcChar:MovieClip):void
        {
            var part:MovieClip;
            var armorParts:Array = [mcChar.backshoulder, mcChar.backhand, mcChar.backrobe, mcChar.backfoot, mcChar.backthigh, mcChar.backshin, mcChar.chest, mcChar.hip, mcChar.frontthigh, mcChar.frontshin, mcChar.idlefoot, mcChar.frontfoot, mcChar.robe, mcChar.frontshoulder, mcChar.fronthand];
            for each (part in armorParts)
            {
                changeColorSpecial(part, armor);
            };
        }


    }
}//package Main.Avatar

