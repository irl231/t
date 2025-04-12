// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFLayoutChatItemPreview

package Main.Aqw.LPF
{
    import Main.Model.Item;
    import Main.Model.*;
    import Game_fla.*;

    public class LPFLayoutChatItemPreview extends LPFLayout 
    {

        private var splitPanel:LPFPanelListShopInvB;
        private var previewPanel:LPFPanelPreview;


        public static function linkItem(data:Object):void
        {
            if (data == null)
            {
                return;
            };
            var itemData:Item = ((data is Item) ? Item(data) : new Item(data));
            if (mcPopup_323(Game.root.ui.mcPopup).currentLabel == "ItemPreview")
            {
                mcPopup_323(Game.root.ui.mcPopup).fClose();
            };
            mcPopup_323(Game.root.ui.mcPopup).fOpen("ItemPreview", {"item":itemData});
        }


        override public function fOpen(data:Object):void
        {
            super.fOpen(data);
            Game.root.world.linkPreview = this;
            this.sMode = data.sMode;
            this.splitPanel = LPFPanelListShopInvB(addPanel({
                "panel":new LPFPanelListShopInvB(),
                "fData":{"sName":"ItemPreview"},
                "r":{
                    "x":322,
                    "y":3,
                    "w":316,
                    "h":495
                },
                "closeType":"close",
                "hideDir":"right",
                "hidePad":3,
                "isOpen":false
            }));
            this.splitPanel.visible = false;
            this.splitPanel.fHide();
            this.iSel = Item(this.fData.item);
            this.previewPanel = LPFPanelPreview(addPanel({
                "panel":new LPFPanelPreview(),
                "fData":{"sName":"Preview"},
                "r":{
                    "x":644,
                    "y":78,
                    "w":316,
                    "h":420
                },
                "closeType":"close",
                "xBuffer":3,
                "isOpen":false
            }));
            this.previewPanel.visible = true;
            update({
                "eventType":"listItemBSel",
                "fData":Item(this.fData.item)
            });
        }

        override protected function handleUpdate(data:Object):Object
        {
            var cancelBroadcast:Boolean;
            var object:Object;
            var iSelPrev:Item = iSel;
            var eSelPrev:Item = eSel;
            this.previewPanel.bg.tTitle.text = "Preview";
            switch (data.eventType)
            {
                case "listItemBSel":
                    if (!Game.root.isGreedyModalInStack())
                    {
                        object = Game.root.copyObj(data);
                        object.eventType = "listItemBSolo";
                        object.fData = {
                            "iSel":object.fData,
                            "eSel":null
                        };
                        iSel = data.fData;
                        data.fData = {
                            "iSel":iSel,
                            "eSel":eSel
                        };
                        if (((!(iSelPrev == iSel)) || (!(eSelPrev == eSel))))
                        {
                            notifyByEventType(object);
                        };
                        this.previewPanel.fShow();
                    }
                    else
                    {
                        cancelBroadcast = true;
                    };
                    break;
            };
            if (!cancelBroadcast)
            {
                return (data);
            };
            return (null);
        }


    }
}//package Main.Aqw.LPF

