// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Avatar.AbstractAvatarMC

package Main.Avatar
{
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import flash.display.*;
    import flash.geom.*;
    import flash.errors.*;

    public class AbstractAvatarMC extends MovieClip 
    {

        protected var totalTransform:Object = {
            "alphaMultiplier":1,
            "alphaOffset":0,
            "redMultiplier":1,
            "redOffset":0,
            "greenMultiplier":1,
            "greenOffset":0,
            "blueMultiplier":1,
            "blueOffset":0
        };
        protected var animQueue:Array = [];
        protected var defaultCT:ColorTransform = transform.colorTransform;
        protected var clampedTransform:ColorTransform = new ColorTransform();
        public var pname:MovieClip;
        public var shadow:MovieClip;
        public var fx:MovieClip;
        public var bubble:MovieClip;
        public var pAV:Avatar;
        public var spFX:Object = {};
        protected var xDep:Number;
        protected var yDep:Number;
        protected var xTar:Number;
        protected var nDuration:Number;
        protected var nXStep:Number;
        protected var nYStep:Number;
        public var tx:int;
        public var ty:int;
        protected var op:Point;
        protected var tp:Point;
        protected var yTar:Number;
        protected var walkTS:Number;
        protected var walkD:Number;


        public function queueAnim(animation:String):void
        {
            throw (new IllegalOperationError("Must override queueAnim"));
        }

        public function stopWalking():void
        {
            throw (new IllegalOperationError("Must override stopWalking"));
        }

        public function walkTo(toX:int, toY:int, walkSpeed:int):void
        {
            throw (new IllegalOperationError("Must override walkTo"));
        }

        public function turn(position:String):void
        {
            throw (new IllegalOperationError("Must override turn"));
        }

        public function fClose():void
        {
            throw (new IllegalOperationError("Must override fClose"));
        }

        public function modulateColor(_arg1:ColorTransform, _arg2:String):void
        {
            var mc:MovieClip = (this.stage.getChildAt(0) as MovieClip);
            switch (_arg2)
            {
                case "+":
                    this.totalTransform.alphaMultiplier = (this.totalTransform.alphaMultiplier + _arg1.alphaMultiplier);
                    this.totalTransform.alphaOffset = (this.totalTransform.alphaOffset + _arg1.alphaOffset);
                    this.totalTransform.redMultiplier = (this.totalTransform.redMultiplier + _arg1.redMultiplier);
                    this.totalTransform.redOffset = (this.totalTransform.redOffset + _arg1.redOffset);
                    this.totalTransform.greenMultiplier = (this.totalTransform.greenMultiplier + _arg1.greenMultiplier);
                    this.totalTransform.greenOffset = (this.totalTransform.greenOffset + _arg1.greenOffset);
                    this.totalTransform.blueMultiplier = (this.totalTransform.blueMultiplier + _arg1.blueMultiplier);
                    this.totalTransform.blueOffset = (this.totalTransform.blueOffset + _arg1.blueOffset);
                    break;
                case "-":
                    this.totalTransform.alphaMultiplier = (this.totalTransform.alphaMultiplier - _arg1.alphaMultiplier);
                    this.totalTransform.alphaOffset = (this.totalTransform.alphaOffset - _arg1.alphaOffset);
                    this.totalTransform.redMultiplier = (this.totalTransform.redMultiplier - _arg1.redMultiplier);
                    this.totalTransform.redOffset = (this.totalTransform.redOffset - _arg1.redOffset);
                    this.totalTransform.greenMultiplier = (this.totalTransform.greenMultiplier - _arg1.greenMultiplier);
                    this.totalTransform.greenOffset = (this.totalTransform.greenOffset - _arg1.greenOffset);
                    this.totalTransform.blueMultiplier = (this.totalTransform.blueMultiplier - _arg1.blueMultiplier);
                    this.totalTransform.blueOffset = (this.totalTransform.blueOffset - _arg1.blueOffset);
                    break;
            };
            this.clampedTransform.alphaMultiplier = mc.clamp(this.totalTransform.alphaMultiplier, -1, 1);
            this.clampedTransform.alphaOffset = mc.clamp(this.totalTransform.alphaOffset, -255, 0xFF);
            this.clampedTransform.redMultiplier = mc.clamp(this.totalTransform.redMultiplier, -1, 1);
            this.clampedTransform.redOffset = mc.clamp(this.totalTransform.redOffset, -255, 0xFF);
            this.clampedTransform.greenMultiplier = mc.clamp(this.totalTransform.greenMultiplier, -1, 1);
            this.clampedTransform.greenOffset = mc.clamp(this.totalTransform.greenOffset, -255, 0xFF);
            this.clampedTransform.blueMultiplier = mc.clamp(this.totalTransform.blueMultiplier, -1, 1);
            this.clampedTransform.blueOffset = mc.clamp(this.totalTransform.blueOffset, -255, 0xFF);
            this.transform.colorTransform = this.clampedTransform;
        }


    }
}//package Main.Avatar

