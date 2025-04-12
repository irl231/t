// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Network.User

package Main.Network
{
    public class User 
    {

        public static var TOKEN:String;
        public static var SERVERS:Object;
        public static var CHARACTER:Object;
        public static var CHARACTERS:Object;

        private var id:int;
        private var name:String;
        private var pId:int;

        public function User(id:int, name:String)
        {
            this.id = id;
            this.name = name;
        }

        public function getId():int
        {
            return (this.id);
        }

        public function getName():String
        {
            return (this.name);
        }

        public function setPlayerId(pid:int):void
        {
            this.pId = pid;
        }


    }
}//package Main.Network

