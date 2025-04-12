// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.hurlant.util.Base64

package com.hurlant.util
{
    public class Base64 
    {

        private static const k:int = 69;


        public static function encode(str:String):String
        {
            var c:int;
            var result:String = "";
            var i:int;
            while (i < str.length)
            {
                c = str.charCodeAt(i);
                c = (c + k);
                result = (result + String.fromCharCode(c));
                i++;
            };
            return (result);
        }


    }
}//package com.hurlant.util

