// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Network.Room

package Main.Network
{
    public class Room 
    {

        private var userCount:int = 0;
        private var userList:Array = [];

        public function Room()
        {
            this.userCount = 0;
        }

        public function addUser(u:User, id:int):void
        {
            this.userList[id] = u;
            this.userCount++;
        }

        public function removeUser(id:int):void
        {
            this.userCount--;
            delete this.userList[id];
        }

        public function getUserList():Array
        {
            return (this.userList);
        }

        public function getUser(userId:*):User
        {
            var i:String;
            var u:User;
            var user:User;
            if (typeof(userId) == "number")
            {
                user = this.userList[userId];
            }
            else
            {
                if (typeof(userId) == "string")
                {
                    for (i in this.userList)
                    {
                        u = this.userList[i];
                        if (u.getName() == userId)
                        {
                            user = u;
                            break;
                        };
                    };
                };
            };
            return (user);
        }


    }
}//package Main.Network

