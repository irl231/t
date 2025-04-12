// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.UI.AbstractDropFrame

package Main.UI
{
    import flash.display.MovieClip;
    import Main.Model.Item;
    import flash.display.DisplayObject;

    public dynamic class AbstractDropFrame extends MovieClip 
    {

        public var fWidth:int = 0;
        public var fHeight:int = 0;
        public var fX:int = 0;
        public var fY:int = 0;
        public var fData:Item = null;
        protected var isOpen:Boolean = false;
        protected var iniFrameT:int = 0;
        protected var iniFrameC:int = 0;
        protected var durFrameT:int = 0;
        protected var durFrameC:int = 0;
        protected var rootClass:Game = Game.root;


        public function init():void
        {
            this.rootClass.onRemoveChildrens(this.cnt.icon);
            var mcIcon:DisplayObject = this.cnt.icon.addChild(this.fData.iconClass);
            mcIcon.scaleX = (mcIcon.scaleY = 0.5);
            this.cnt.icon.filters = [this.fData.rarityGlow];
        }


    }
}//package Main.UI

