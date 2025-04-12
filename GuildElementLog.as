// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildElementLog

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class GuildElementLog extends MovieClip 
    {

        public var bg:MovieClip;
        public var date:String;
        public var details:String;
        public var tDate:TextField;
        public var tDetails:TextField;

        public function GuildElementLog(date:String, details:String):void
        {
            this.setDate(date);
            this.setDeails(details);
        }

        public function setDate(date:String):void
        {
            this.date = date;
            this.tDate.text = date;
        }

        public function setDeails(details:String):void
        {
            this.details = details;
            this.tDetails.text = details;
        }


    }
}//package 

