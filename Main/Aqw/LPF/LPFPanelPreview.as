// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFPanelPreview

package Main.Aqw.LPF
{
    import flash.events.*;

    public class LPFPanelPreview extends LPFPanel 
    {

        public function LPFPanelPreview():void
        {
            x = 0;
            y = 0;
            frames = [];
            fData = {};
        }

        override public function fOpen(data:Object):void
        {
            fData = data.fData;
            this.x = data.r.x;
            this.y = ((data.r.y > -1) ? data.r.y : ((fParent.numChildren > 1) ? ((fParent.getChildAt((fParent.numChildren - 2)).y + fParent.getChildAt((fParent.numChildren - 2)).height) + 10) : 10));
            w = data.r.w;
            h = data.r.h;
            xo = x;
            yo = y;
            if (("closeType" in data))
            {
                closeType = data.closeType;
            };
            if (("hideDir" in data))
            {
                hideDir = data.hideDir;
            };
            if (("hidePad" in data))
            {
                hidePad = data.hidePad;
            };
            if (("xBuffer" in data))
            {
                xBuffer = data.xBuffer;
            };
            addFrame({
                "frame":new LPFFrameBackdrop(),
                "fData":null,
                "r":{
                    "x":14,
                    "y":36,
                    "w":(w - 26),
                    "h":204
                }
            });
            addFrame({
                "frame":new LPFFrameBackdrop(),
                "fData":null,
                "r":{
                    "x":14,
                    "y":244,
                    "w":(w - 26),
                    "h":121
                }
            });
            var o:Object = {};
            o.frame = new LPFFrameItemPreview();
            o.fData = null;
            o.r = {
                "x":18,
                "y":40,
                "w":(w - 20),
                "h":-1
            };
            if (data.isEquip != undefined)
            {
                o.isEquip = data.isEquip;
            };
            if (data.isShow != undefined)
            {
                o.isShow = data.isShow;
            };
            o.eventTypes = ["listItemASel", "listItemBSel", "refreshItems"];
            addFrame(o);
            o = {};
            o.frame = new LPFFrameEnhText();
            o.fData = null;
            o.r = {
                "x":18,
                "y":245,
                "w":(w - 20),
                "h":-1
            };
            if (data.isEquip != undefined)
            {
                o.isEquip = data.isEquip;
            };
            o.eventTypes = ["listItemASel", "listItemBSel", "refreshItems"];
            addFrame(o);
            if (data.isEquip == undefined)
            {
                addFrame({
                    "frame":new LPFFrameCostDisplay(),
                    "fData":null,
                    "r":{
                        "x":221,
                        "y":-66,
                        "w":-1,
                        "h":-1,
                        "xPosRule":"centerOnX"
                    },
                    "eventTypes":["listItemASel"]
                });
                addFrame({
                    "frame":new LPFFrameGenericButton(),
                    "fData":null,
                    "r":{
                        "x":46,
                        "y":-40,
                        "w":-1,
                        "h":-1
                    },
                    "eventTypes":["previewButton1Update"]
                });
                addFrame({
                    "frame":new LPFFrameGenericButton(),
                    "fData":null,
                    "r":{
                        "x":173,
                        "y":-40,
                        "w":-1,
                        "h":-1
                    },
                    "eventTypes":["previewButton2Update"]
                });
            };
            drawBG();
            bg.btnClose.addEventListener(MouseEvent.CLICK, onCloseClick, false, 0, true);
            if (!(("showDragonLeft" in data) && (data.showDragonLeft)))
            {
                bg.dragonLeft.visible = false;
            };
            if (!(("showDragonRight" in data) && (data.showDragonRight)))
            {
                bg.dragonRight.visible = false;
            };
        }


    }
}//package Main.Aqw.LPF

