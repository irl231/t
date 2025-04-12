// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Drag

package Main
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.*;

    public class Drag 
    {

        private static const game:Game = Game.root;

        public var drag:Sprite;
        public var target:Sprite;
        public var callback:Function;

        public function Drag(target:Sprite, drag:Sprite, callback:Function=null):void
        {
            this.target = target;
            this.drag = drag;
            this.callback = callback;
            this.drag.mouseEnabled = true;
            this.drag.mouseChildren = false;
            this.drag.useHandCursor = true;
            this.drag.buttonMode = true;
            this.drag.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown, false, 0, true);
            game.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp, false, 0, true);
        }

        public function destroy():void
        {
            this.drag.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            game.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this.target.stopDrag();
        }

        private function onMouseDown(e:MouseEvent):void
        {
            this.target.startDrag(false);
        }

        private function onMouseUp(e:MouseEvent):void
        {
            this.target.stopDrag();
            if (this.callback != null)
            {
                this.callback();
            };
        }


    }
}//package Main

