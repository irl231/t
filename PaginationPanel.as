// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//PaginationPanel

package 
{
    import flash.display.MovieClip;
    import flash.display.*;
    import flash.events.*;

    public class PaginationPanel extends MovieClip 
    {


        public function display(iStart:int=0, iMin:int=0, iMax:int=0, iPadding:Number=5, iEnd:int=8):*
        {
            parent.rootClass.onRemoveChildrens(this);
            var iCounter:int;
            this.createButton(iMin, iPadding, iCounter);
            iCounter++;
            if (iStart == iMin)
            {
                iStart++;
                iEnd++;
            }
            else
            {
                if (iStart > 2)
                {
                    iStart--;
                }
                else
                {
                    if (iEnd < 8)
                    {
                        this.reposition();
                        this.x = ((parent.maskGuild.width - this.width) / 1.7);
                        return;
                    };
                };
            };
            while (iCounter < iEnd)
            {
                if (((iStart == iMax) || (iStart == iEnd)))
                {
                    this.reposition();
                    break;
                };
                this.createButton(iStart, iPadding, iCounter);
                iStart++;
                iCounter++;
            };
            this.createButton(iMax, iPadding, iCounter);
            this.reposition();
        }

        public function reposition():*
        {
            this.x = ((parent.maskGuild.width - this.width) / 1.4);
        }

        public function createButton(page:int, iPadding:Number, iCounter:int):*
        {
            var button:* = new PaginationButton();
            addChild(button);
            button.x = ((button.width + iPadding) * iCounter);
            button.txtPage.text = page;
            button.txtPage.mouseEnabled = false;
            button.name = "paginationButton";
            button.addEventListener(MouseEvent.CLICK, MovieClip(parent).onClick);
        }


    }
}//package 

