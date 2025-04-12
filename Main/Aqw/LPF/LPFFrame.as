// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Aqw.LPF.LPFFrame

package Main.Aqw.LPF
{
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;

    public class LPFFrame extends MovieClip 
    {

        public var w:int;
        public var h:int;
        public var fParent:LPFPanel;
        public var eventTypes:Array = [];
        public var sName:String = "";
        protected var fData:Object;
        protected var sMode:String;
        protected var rootClass:Game = Game.root;


        public function subscribeTo(_arg1:LPFPanel):void
        {
            this.fParent = _arg1;
        }

        public function getLayout():LPFLayout
        {
            var parent:MovieClip = this.fParent;
            while ((("fParent" in parent) && (!(parent.fParent == null))))
            {
                parent = parent.fParent;
            };
            return (parent as LPFLayout);
        }

        public function notify(_arg1:Object):void
        {
        }

        public function update(_arg1:Object):void
        {
            this.getLayout().update(_arg1);
        }

        public function getState():Object
        {
            return ({
                "fParent":this.fParent,
                "element":this,
                "fData":this.fData
            });
        }

        public function fOpen(data:Object):void
        {
            this.fData = data.fData;
            this.positionBy(data.r);
            this.getLayout().registerForEvents(this, this.eventTypes);
        }

        public function fClose():void
        {
            this.getLayout().unregisterFrame(this);
            if (parent != null)
            {
                parent.removeChild(this);
            };
        }

        public function fRemove():void
        {
            if (((!(this.fParent == null)) && ("delFrame" in this.fParent)))
            {
                this.fParent.delFrame(this);
            };
        }

        protected function positionBy(r:Object):void
        {
            var displayObject:DisplayObject;
            var rectangle:Rectangle;
            var i:int;
            var child:DisplayObject;
            var parentWidth:int = int((this.fParent.w >> 1));
            var rectangleWidth:* = (this.width >> 1);
            if (parent != null)
            {
                i = 0;
                while (i < parent.numChildren)
                {
                    child = parent.getChildAt(i);
                    if (child == this)
                    {
                        displayObject = child;
                    };
                    i++;
                };
                rectangle = displayObject.getBounds(parent);
                rectangleWidth = int((rectangle.width >> 1));
            };
            if (r.centerOn != undefined)
            {
                parentWidth = r.centerOn;
            };
            x = (((!(r.center == undefined)) && (r.center)) ? int((parentWidth - rectangleWidth)) : x = ((r.x > -1) ? r.x : int(((this.fParent.w >> 1) - (width >> 1)))));
            if (r.shiftAmount != undefined)
            {
                x = (x + int(r.shiftAmount));
            };
            this.w = r.w;
            this.h = r.h;
            this.positionByFinal(r);
        }

        protected function positionByFinal(r:Object):void
        {
            y = ((r.y > -1) ? r.y : y = ((r.y == -1) ? ((this.fParent.numChildren > 1) ? ((this.fParent.getChildAt((this.fParent.numChildren - 2)).y + this.fParent.getChildAt((this.fParent.numChildren - 2)).height) + 10) : 10) : (this.fParent.h + r.y)));
        }


    }
}//package Main.Aqw.LPF

