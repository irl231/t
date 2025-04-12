// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Main.Bot.Data.BotData

package Main.Bot.Data
{
    public class BotData 
    {

        public var attempt:uint = 0;
        public var commands:Array = [];
        public var skills:Array = [];
        public var quests:Array = [];
        public var items:Array = [];
        private var _skip:Boolean = false;
        private var _pickup:Boolean = false;
        private var _reject:Boolean = false;
        private var _energy:Boolean = false;
        private var _relogin:Boolean = false;
        private var _debug:Boolean = false;


        public function get skip():Boolean
        {
            return (this._skip);
        }

        public function set skip(value:Boolean):void
        {
            this._skip = value;
        }

        public function get pickup():Boolean
        {
            return (this._pickup);
        }

        public function set pickup(value:Boolean):void
        {
            this._pickup = value;
        }

        public function get reject():Boolean
        {
            return (this._reject);
        }

        public function set reject(value:Boolean):void
        {
            this._reject = value;
        }

        public function get energy():Boolean
        {
            return (this._energy);
        }

        public function set energy(value:Boolean):void
        {
            this._energy = value;
        }

        public function get relogin():Boolean
        {
            return (this._relogin);
        }

        public function set relogin(value:Boolean):void
        {
            this._relogin = value;
        }

        public function get debug():Boolean
        {
            return (this._debug);
        }

        public function set debug(value:Boolean):void
        {
            this._debug = value;
        }


    }
}//package Main.Bot.Data

