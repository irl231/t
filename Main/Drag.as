// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Drag

package Main
{
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.geom.*;

    public class Drag 
    {

        private static const game:Game = Game.root;

        public var drag:DisplayObject;
        public var target:DisplayObject;
        private var origin:Point;

        public function Drag(target:DisplayObject, drag:DisplayObject):void
        {
            this.target = target;
            this.drag = drag;
            this.drag.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
        }

        public function destroy():void
        {
            this.drag.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            game.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            game.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
        }

        private function onMouseMove(mouseEvent:MouseEvent):void
        {
            if (!this.origin)
            {
                return;
            };
            this.target.x = (game.stage.mouseX - this.origin.x);
            this.target.y = (game.stage.mouseY - this.origin.y);
        }

        private function onMouseDown(mouseEvent:MouseEvent):void
        {
            game.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            game.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.origin = new Point((game.stage.mouseX - this.target.x), (game.stage.mouseY - this.target.y));
        }

        private function onMouseUp(mouseEvent:MouseEvent):void
        {
            game.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            game.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            this.origin = null;
        }


    }
}//package Main

