// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//GuildElement

package 
{
    import flash.display.MovieClip;
    import flash.text.TextField;

    public dynamic class GuildElement extends MovieClip 
    {

        public var bg:MovieClip;
        public var id:uint;
        public var tRank:TextField;
        public var tName:TextField;
        public var tLevel:TextField;
        public var tStatus:TextField;
        public var username:String;
        public var level:int;

        public function GuildElement(id:uint, tRank:String, status:String, username:String, level:int):void
        {
            this.setId(id);
            this.setRank(tRank);
            this.setStatus(status);
            this.setUsername(username);
            this.setLevel(level);
        }

        public function setId(id:uint):void
        {
            this.id = id;
        }

        public function setRank(tRank:String):void
        {
            this.tRank.htmlText = tRank;
        }

        public function setStatus(tStatus:String):void
        {
            this.tStatus.htmlText = tStatus;
        }

        public function setUsername(username:String):void
        {
            this.tName.text = username;
            this.username = username;
        }

        public function setLevel(level:int):void
        {
            this.tLevel.text = level;
        }


    }
}//package 

