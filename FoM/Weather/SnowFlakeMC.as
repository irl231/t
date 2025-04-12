// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//FoM.Weather.SnowFlakeMC

package FoM.Weather
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.*;

    public class SnowFlakeMC extends MovieClip 
    {

        private var maxWidth:Number = 0;
        private var xPos:Number = 0;
        private var scale:Number = 0;
        private var maxHeight:Number = 0;
        private var ySpeed:Number = 0;
        private var xSpeed:Number = 0;
        private var radius:Number = 0;
        private var alphaValue:Number = 0;
        private var yPos:Number = 0;


        public function SetInitialProperties():*
        {
            this.xSpeed = (0.05 + (Math.random() * 0.1));
            this.ySpeed = (0.1 + (Math.random() * 3));
            this.radius = (0.1 + (Math.random() << 1));
            this.scale = (0.01 + Math.random());
            this.alphaValue = (0.1 + Math.random());
            this.maxWidth = 960;
            this.maxHeight = 550;
            this.x = (Math.random() * this.maxWidth);
            this.y = (Math.random() * this.maxHeight);
            this.xPos = this.x;
            this.yPos = this.y;
            this.scaleX = (this.scaleY = this.scale);
            this.alpha = this.alphaValue;
            this.addEventListener(Event.ENTER_FRAME, this.MoveSnowFlake);
        }

        private function MoveSnowFlake(evt:Event):void
        {
            this.xPos = (this.xPos + this.xSpeed);
            this.yPos = (this.yPos + this.ySpeed);
            this.x = (this.x + (this.radius * Math.cos(this.xPos)));
            this.y = (this.y + this.ySpeed);
            if ((this.y - this.height) > this.maxHeight)
            {
                this.y = (-10 - this.height);
                this.x = (Math.random() * this.maxWidth);
            };
        }


    }
}//package FoM.Weather

