// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//Chat

package 
{
    import flash.utils.Timer;
    import flash.net.SharedObject;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.text.TextLineMetrics;
    import flash.events.TimerEvent;
    import flash.events.TextEvent;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.utils.*;
    import Main.Aqw.LPF.*;
    import Main.Aqw.*;
    import flash.net.*;
    import Main.*;
    import Main.Emoji.*;

    public class Chat 
    {

        public static const regExpSPACE:RegExp = /(\s{2,})/gi;
        public static const regExpLinking1:RegExp = /<\s*P\b.*?>(.*?)<\s*\/P\s*>/gi;
        public static const regExpLinking2:RegExp = /<\s*FONT\b.*?>(.*?)<\s*\/FONT\s*>/gi;
        public static const regExpLinking3:RegExp = /<\s*A HREF="(.*?)" TARGET="">(.*?)<\s*\/A\s*>/gi;
        public static const regExpURL:RegExp = new RegExp("\\b(http|https)://[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]", "i");
        private static const t:Timer = new Timer(500, 1);
        private static const windowTimer:Timer = new Timer(60000, 1);
        private static const t1Shorty:int = -137;
        private static const t1Tally:int = -378;
        public static const openTag:String = "$({";
        public static const closeTag:String = "})$";
        public static const fontColorStart:String = '<font color="#';
        public static const fontColorEnd:String = '">';
        public static const fontColorClose:String = "</font>";
        private static const jsonCannedOptions:Object = {"CannedChat":{"menu":[{
                    "menu":[{
                        "id":"emote",
                        "display":"Dance",
                        "text":"dance"
                    }, {
                        "id":"emote",
                        "display":"Dance2",
                        "text":"dance2"
                    }, {
                        "id":"emote",
                        "display":"Laugh",
                        "text":"laugh"
                    }, {
                        "id":"emote",
                        "display":"Cry",
                        "text":"cry"
                    }, {
                        "id":"emote",
                        "display":"Cheer",
                        "text":"cheer"
                    }, {
                        "id":"emote",
                        "display":"Point",
                        "text":"point"
                    }, {
                        "id":"emote",
                        "display":"Use",
                        "text":"use"
                    }, {
                        "id":"emote",
                        "display":"Feign",
                        "text":"feign"
                    }, {
                        "id":"emote",
                        "display":"Sleep",
                        "text":"sleep"
                    }, {
                        "id":"emote",
                        "display":"Jump",
                        "text":"jump"
                    }, {
                        "id":"emote",
                        "display":"Punt",
                        "text":"punt"
                    }, {
                        "id":"emote",
                        "display":"Wave",
                        "text":"wave"
                    }, {
                        "id":"emote",
                        "display":"Bow",
                        "text":"bow"
                    }, {
                        "id":"emote",
                        "display":"Salute",
                        "text":"Salute"
                    }, {
                        "id":"emote",
                        "display":"Backflip",
                        "text":"backflip"
                    }, {
                        "id":"emote",
                        "display":"Swordplay",
                        "text":"swordplay"
                    }, {
                        "id":"emote",
                        "display":"Unsheath",
                        "text":"unsheath"
                    }, {
                        "id":"emote",
                        "display":"Facepalm",
                        "text":"facepalm"
                    }, {
                        "id":"emote",
                        "display":"Air Guitar",
                        "text":"airguitar"
                    }, {
                        "id":"emote",
                        "display":"Stern",
                        "text":"stern"
                    }],
                    "display":"Emotes"
                }, {
                    "menu":[{
                        "id":"emote",
                        "display":"Casting",
                        "text":"casting"
                    }, {
                        "id":"emote",
                        "display":"Fishing",
                        "text":"fishing"
                    }, {
                        "id":"emote",
                        "display":"Mining",
                        "text":"mining"
                    }, {
                        "id":"emote",
                        "display":"Headscratch",
                        "text":"headscratch"
                    }, {
                        "id":"emote",
                        "display":"Shock",
                        "text":"shock"
                    }, {
                        "id":"emote",
                        "display":"Castmagic",
                        "text":"castmagic"
                    }, {
                        "id":"emote",
                        "display":"Dab",
                        "text":"dab"
                    }, {
                        "id":"emote",
                        "display":"Facepalm2",
                        "text":"facepalm2"
                    }, {
                        "id":"emote",
                        "display":"Fall",
                        "text":"fall"
                    }, {
                        "id":"emote",
                        "display":"Relax",
                        "text":"relax"
                    }, {
                        "id":"emote",
                        "display":"Toss",
                        "text":"toss"
                    }, {
                        "id":"emote",
                        "display":"Hold",
                        "text":"hold"
                    }, {
                        "id":"emote",
                        "display":"Spin",
                        "text":"spin"
                    }, {
                        "id":"emote",
                        "display":"Hop",
                        "text":"hop"
                    }, {
                        "id":"emote",
                        "display":"Idea",
                        "text":"idea"
                    }, {
                        "id":"emote",
                        "display":"Pant",
                        "text":"pant"
                    }],
                    "display":"Additional Emotes"
                }, {
                    "menu":[{
                        "id":"emote",
                        "display":"Powerup",
                        "text":"powerup"
                    }, {
                        "id":"emote",
                        "display":"Kneel",
                        "text":"kneel"
                    }, {
                        "id":"emote",
                        "display":"Jumpcheer",
                        "text":"jumpcheer"
                    }, {
                        "id":"emote",
                        "display":"Salute2",
                        "text":"salute2"
                    }, {
                        "id":"emote",
                        "display":"Cry2",
                        "text":"cry2"
                    }, {
                        "id":"emote",
                        "display":"Spar",
                        "text":"spar"
                    }, {
                        "id":"emote",
                        "display":"Stepdance",
                        "text":"stepdance"
                    }, {
                        "id":"emote",
                        "display":"Headbang",
                        "text":"headbang"
                    }, {
                        "id":"emote",
                        "display":"Dazed",
                        "text":"dazed"
                    }, {
                        "id":"emote",
                        "display":"DanceWeapon",
                        "text":"danceweapon"
                    }, {
                        "id":"emote",
                        "display":"UseWeapon",
                        "text":"useweapon"
                    }, {
                        "id":"emote",
                        "display":"Samba",
                        "text":"samba"
                    }],
                    "display":"VIP Emotes"
                }, {
                    "menu":[{
                        "menu":[{
                            "id":"ba",
                            "display":"Hello!",
                            "text":"Hello!"
                        }, {
                            "id":"bb",
                            "display":"Hi!",
                            "text":"Hi!"
                        }, {
                            "id":"bc",
                            "display":"Well met!",
                            "text":"Well met!"
                        }, {
                            "id":"bd",
                            "display":"Welcome!",
                            "text":"Welcome!"
                        }, {
                            "id":"be",
                            "display":"Welcome back!",
                            "text":"Welcome back!"
                        }, {
                            "id":"bf",
                            "display":"How are you today?",
                            "text":"How are you today?"
                        }],
                        "display":"Greetings"
                    }, {
                        "menu":[{
                            "id":"ca",
                            "display":"Bye!",
                            "text":"Bye!"
                        }, {
                            "id":"cb",
                            "display":"See you later.",
                            "text":"See you later."
                        }, {
                            "id":"cc",
                            "display":"AFK",
                            "text":"I'm going AFK"
                        }, {
                            "id":"cd",
                            "display":"I have to go now.",
                            "text":"I have to go now."
                        }, {
                            "id":"ce",
                            "display":"Logging out now",
                            "text":"Logging out now."
                        }, {
                            "id":"cf",
                            "display":"brb",
                            "text":"brb"
                        }, {
                            "id":"cg",
                            "display":"Farewell",
                            "text":"Farewell"
                        }],
                        "display":"Farewells"
                    }, {
                        "menu":[{
                            "menu":[{
                                "id":"ea",
                                "display":"to my Friends list",
                                "text":"Can I add you to my Friends list?"
                            }, {
                                "id":"eb",
                                "display":"to my Party",
                                "text":"Can I add you to my Party?"
                            }],
                            "id":"da",
                            "display":"Can I add you"
                        }, {
                            "id":"db",
                            "display":"Do you want to battle together?",
                            "text":"Do you want to battle together?"
                        }, {
                            "menu":[{
                                "id":"fa",
                                "display":"Helm",
                                "text":" Is that a Hero only helm?"
                            }, {
                                "id":"fb",
                                "display":"Cape",
                                "text":" Is that a Hero only cape?"
                            }, {
                                "id":"fc",
                                "display":"Armor",
                                "text":" Is that a Hero only armor?"
                            }, {
                                "id":"fd",
                                "display":"Weapon",
                                "text":" Is that a Hero only weapon?"
                            }],
                            "id":"dc",
                            "display":"Is that a Hero only..."
                        }, {
                            "id":"dd",
                            "display":"Where are you?",
                            "text":"Where are you?"
                        }, {
                            "id":"de",
                            "display":"Are you sure?",
                            "text":"Are you sure?"
                        }, {
                            "id":"df",
                            "display":"Can I help you?",
                            "text":"Can I help you?"
                        }, {
                            "id":"dg",
                            "display":"What is your alignment?",
                            "text":"What is your alignment?"
                        }, {
                            "menu":[{
                                "id":"ga",
                                "display":"Helm",
                                "text":"Where did you get that helm?"
                            }, {
                                "id":"gb",
                                "display":"Cape",
                                "text":"Where did you get that cape?"
                            }, {
                                "id":"gc",
                                "display":"Armor",
                                "text":"Where did you get that armor?"
                            }, {
                                "id":"gd",
                                "display":"Weapon",
                                "text":"Where did you get that weapon?"
                            }, {
                                "id":"ge",
                                "display":"Pet",
                                "text":"Where did you get that pet?"
                            }, {
                                "id":"ge",
                                "display":"Class",
                                "text":"Where did you get that class?"
                            }],
                            "id":"dh",
                            "display":"Where did you get that ..."
                        }, {
                            "menu":[{
                                "id":"ha",
                                "display":"Guardian",
                                "text":"Are you a Guardian?"
                            }, {
                                "id":"hb",
                                "display":"DragonLord",
                                "text":"Are you a DragonLord?"
                            }, {
                                "id":"hc",
                                "display":"StarCaptain",
                                "text":"Are you a StarCaptain?"
                            }],
                            "id":"di",
                            "display":"Are you a..."
                        }, {
                            "menu":[{
                                "id":"ia",
                                "display":"AdventureQuest",
                                "text":"Do you play AdventureQuest?"
                            }, {
                                "id":"ib",
                                "display":"DragonFable",
                                "text":"Do you play DragonFable?"
                            }, {
                                "id":"ic",
                                "display":"MechQuest",
                                "text":"Do you play MechQuest?"
                            }],
                            "id":"dj",
                            "display":"Do you play..."
                        }, {
                            "id":"dl",
                            "display":"What are you doing?",
                            "text":"What are you doing?"
                        }],
                        "display":"Questions"
                    }, {
                        "menu":[{
                            "menu":[{
                                "id":"ka",
                                "display":"Thanks!",
                                "text":"Thanks!"
                            }, {
                                "id":"kb",
                                "display":"Thank you!",
                                "text":"Thank you!"
                            }, {
                                "id":"kc",
                                "display":"Thanks for helping me.",
                                "text":"Thanks for helping me."
                            }, {
                                "id":"kd",
                                "display":"I owe you one.",
                                "text":"I owe you one.."
                            }, {
                                "id":"ke",
                                "display":"No problem!",
                                "text":"No problem!"
                            }, {
                                "id":"kf",
                                "display":"You're welcome!",
                                "text":"You're welcome!"
                            }],
                            "id":"ja",
                            "display":"thanks/welcome"
                        }, {
                            "menu":[{
                                "id":"ma",
                                "display":"Quest",
                                "text":"I am doing a quest."
                            }, {
                                "id":"mb",
                                "display":"Farming",
                                "text":"I am farming."
                            }, {
                                "id":"mc",
                                "display":"New",
                                "text":"I am playing the new release."
                            }, {
                                "id":"md",
                                "display":"Level up.",
                                "text":"I am trying to level up."
                            }, {
                                "id":"me",
                                "display":"Rank up.",
                                "text":"I am trying to rank up."
                            }],
                            "id":"jn",
                            "display":"I am doing/trying to.."
                        }, {
                            "id":"jb",
                            "display":"I'm fine, thanks.",
                            "text":"I'm fine, thanks."
                        }, {
                            "id":"jc",
                            "display":"Could be better.",
                            "text":"Could be better."
                        }, {
                            "id":"jd",
                            "display":"I don't think so.",
                            "text":"I don't think so."
                        }, {
                            "id":"je",
                            "display":"I don't know.",
                            "text":"I don't know."
                        }, {
                            "id":"jf",
                            "display":"Indeed.",
                            "text":"Indeed."
                        }, {
                            "id":"jg",
                            "display":"Pleased to meet you.",
                            "text":"Pleased to meet you."
                        }, {
                            "id":"jh",
                            "display":"Good.",
                            "text":"I am Good."
                        }, {
                            "id":"ji",
                            "display":"Evil.",
                            "text":"I am Evil."
                        }, {
                            "id":"jj",
                            "display":"Me too!",
                            "text":"Me too!"
                        }, {
                            "menu":[{
                                "id":"la",
                                "display":"as a drop.",
                                "text":"I got it as a drop."
                            }, {
                                "id":"lb",
                                "display":"from a shop.",
                                "text":"I got it from a shop."
                            }],
                            "id":"jk",
                            "display":"I got it..."
                        }, {
                            "id":"jl",
                            "display":"Check the Wiki...",
                            "text":"You can check the Wiki for the location."
                        }, {
                            "id":"jm",
                            "display":"Your Book of Lore will know that",
                            "text":"Your Book of Lore will know that."
                        }, {
                            "id":"jo",
                            "display":"I can only use Canned Chat.",
                            "text":"I can only use Canned Chat."
                        }],
                        "display":"Answers"
                    }, {
                        "menu":[{
                            "id":"na",
                            "display":"Follow me!",
                            "text":"Follow me!"
                        }, {
                            "id":"nb",
                            "display":"Over here!",
                            "text":"Over here!"
                        }, {
                            "id":"nc",
                            "display":"Goto me.",
                            "text":"Goto me."
                        }, {
                            "id":"nd",
                            "display":"I'll follow you.",
                            "text":"I'll follow you."
                        }, {
                            "id":"ne",
                            "display":"Maybe some other time.",
                            "text":"Maybe some other time."
                        }, {
                            "id":"nf",
                            "display":"Ok, let's go.",
                            "text":"Ok, let's go."
                        }, {
                            "id":"ng",
                            "display":"Come back here.",
                            "text":"Come back here."
                        }, {
                            "id":"nh",
                            "display":"I need to finish this first.",
                            "text":"I need to finish this first."
                        }, {
                            "id":"ni",
                            "display":"Seriously?",
                            "text":"Seriously?"
                        }, {
                            "menu":[{
                                "id":"oa",
                                "display":"Artix",
                                "text":"I'm going to the Artix Server."
                            }, {
                                "id":"ob",
                                "display":"Galanoth",
                                "text":"I'm going to the Galanoth Server."
                            }, {
                                "id":"oh",
                                "display":"Sir Ver",
                                "text":"I'm going to Sir Ver."
                            }, {
                                "id":"oi",
                                "display":"Twig",
                                "text":"I'm going to the Twig server."
                            }, {
                                "id":"oj",
                                "display":"Twilly",
                                "text":"I'm going to the Twilly server."
                            }, {
                                "id":"ok",
                                "display":"Yorumi",
                                "text":"I'm going to the Yorumi server."
                            }, {
                                "id":"oj",
                                "display":"TestingServer",
                                "text":"I'm going to the TestingServer server."
                            }, {
                                "id":"ok",
                                "display":"TestingServer2",
                                "text":"I'm going to the TestingServer2 server."
                            }],
                            "id":"nj",
                            "display":"*I'm going to..."
                        }, {
                            "id":"nk",
                            "display":"Sorry, I'm busy.",
                            "text":"Sorry, I'm busy."
                        }],
                        "display":"Meeting up"
                    }, {
                        "menu":[{
                            "menu":[{
                                "id":"qa",
                                "display":"help with battle",
                                "text":"Can you help me with this battle?"
                            }, {
                                "id":"qb",
                                "display":"help with Boss",
                                "text":"Can you help me with the Boss?"
                            }],
                            "id":"pa",
                            "display":"Can you.."
                        }, {
                            "menu":[{
                                "id":"ra",
                                "display":"Let's attack now!",
                                "text":"Let's attack now!"
                            }, {
                                "id":"rb",
                                "display":"I'll attack first.",
                                "text":"I'll attack first."
                            }, {
                                "id":"rc",
                                "display":"You go first.",
                                "text":"You go first."
                            }, {
                                "id":"rd",
                                "display":"I need to rest.",
                                "text":"I need to rest."
                            }],
                            "id":"pb",
                            "display":"Planning..."
                        }, {
                            "menu":[{
                                "id":"sa",
                                "display":"Heal, please!",
                                "text":"Heal, please!"
                            }, {
                                "id":"sb",
                                "display":"MEDIC!",
                                "text":"MEDIC!"
                            }, {
                                "id":"sc",
                                "display":"Help!",
                                "text":"Help!"
                            }, {
                                "id":"sd",
                                "display":"I'm out of Mana.",
                                "text":"I'm out of Mana."
                            }, {
                                "id":"se",
                                "display":"Use your special attacks!",
                                "text":"Use your special attacks!"
                            }, {
                                "id":"sf",
                                "display":"This monster is strong!",
                                "text":"This monster is strong!"
                            }, {
                                "id":"sg",
                                "display":"Slay that monster!",
                                "text":"Slay that monster!"
                            }, {
                                "id":"sh",
                                "display":"This is hard.",
                                "text":"This hard."
                            }, {
                                "id":"si",
                                "display":"This is easy.",
                                "text":"This easy."
                            }, {
                                "id":"sj",
                                "display":"Run away!",
                                "text":"Run away!"
                            }],
                            "id":"pc",
                            "display":"During the battle"
                        }, {
                            "menu":[{
                                "id":"ta",
                                "display":"Yes! I got the drop!",
                                "text":"Yes! I got the drop!"
                            }, {
                                "id":"tb",
                                "display":"We did it!",
                                "text":"We did it!"
                            }, {
                                "id":"tc",
                                "display":"You fight well.",
                                "text":"You fight well."
                            }, {
                                "id":"td",
                                "display":"Nooo! I died!",
                                "text":"Nooo! I died!"
                            }, {
                                "id":"tf",
                                "display":"Let's try again!",
                                "text":"Let's try again!"
                            }],
                            "id":"pd",
                            "display":"After battle"
                        }],
                        "display":"In Battle"
                    }, {
                        "menu":[{
                            "id":"ua",
                            "display":"Battle on!",
                            "text":"Battle on!"
                        }, {
                            "id":"uc",
                            "display":"OMG!",
                            "text":"OMG!"
                        }, {
                            "id":"ud",
                            "display":"lol",
                            "text":"lol"
                        }, {
                            "id":"uf",
                            "display":"Woot!",
                            "text":"Woot!"
                        }, {
                            "id":"ug",
                            "display":"Wow!",
                            "text":"Wow"
                        }, {
                            "id":"uh",
                            "display":"High Five!",
                            "text":"High Five!"
                        }, {
                            "id":"ui",
                            "display":"Congrats!",
                            "text":"Congrats!"
                        }, {
                            "id":"uj",
                            "display":"Level up!",
                            "text":"Level up!"
                        }, {
                            "id":"uk",
                            "display":"Rank up!",
                            "text":"Rank up!"
                        }, {
                            "id":"ul",
                            "display":"LONG UN-LIVE THE SHADOWSCYTHE!!",
                            "text":"LONG UN-LIVE THE SHADOWSCYTHE!!"
                        }, {
                            "id":"um",
                            "display":"Long live King Alteon the Good!!",
                            "text":"Long live King Alteon the Good!!"
                        }, {
                            "id":"un",
                            "display":"This rocks!",
                            "text":"This rocks!"
                        }, {
                            "id":"uo",
                            "display":"This is awesome!",
                            "text":"This is awesome!"
                        }, {
                            "id":"up",
                            "display":"This is fun.",
                            "text":"This is fun."
                        }, {
                            "id":"uq",
                            "display":"That is really cool.",
                            "text":"That is really cool."
                        }, {
                            "id":"ur",
                            "display":"Cheer up!",
                            "text":"Cheer up!"
                        }, {
                            "id":"ut",
                            "display":"Great!",
                            "text":"Great!"
                        }, {
                            "id":"uu",
                            "display":"HaHa",
                            "text":"HaHa"
                        }],
                        "display":"Exclamations"
                    }, {
                        "menu":[{
                            "id":"va",
                            "display":"following me",
                            "text":"Please stop following me."
                        }, {
                            "id":"vb",
                            "display":"doing that",
                            "text":"Please stop doing that."
                        }, {
                            "id":"vc",
                            "display":"PMing me",
                            "text":"Please stop PMing me."
                        }],
                        "display":"Stop"
                    }, {
                        "menu":[{
                            "id":"wa",
                            "display":":)",
                            "text":":)"
                        }, {
                            "id":"wb",
                            "display":":(",
                            "text":":("
                        }, {
                            "id":"wc",
                            "display":":/",
                            "text":":/"
                        }, {
                            "id":"wd",
                            "display":":|",
                            "text":":|"
                        }, {
                            "id":"we",
                            "display":":O",
                            "text":":O"
                        }, {
                            "id":"wf",
                            "display":"D:",
                            "text":"D:"
                        }],
                        "display":"Smilies"
                    }, {
                        "id":"x",
                        "display":"Yes.",
                        "text":"Yes."
                    }, {
                        "id":"y",
                        "display":"No.",
                        "text":"No."
                    }, {
                        "id":"z",
                        "display":"OK.",
                        "text":"OK."
                    }],
                    "display":"Canned Chat"
                }, {
                    "menu":[{
                        "id":"ac1",
                        "display":"No Alliance",
                        "text":"I currently dont have any guild alliance."
                    }],
                    "display":"Alliance Chat"
                }, {
                    "menu":[{
                        "id":"hi1",
                        "display":"No History",
                        "text":"I currently dont have any canned history."
                    }],
                    "display":"History"
                }]}};
        private static const xmlCannedOptions:XML = <CannedChat>
            <l1 display="Emotes">
                <l2 id="emote" display="Dance" text="dance"/>
                <l2 id="emote" display="Dance2" text="dance2"/>
                <l2 id="emote" display="Laugh" text="laugh"/>
                <l2 id="emote" display="Cry" text="cry"/>
                <l2 id="emote" display="Cheer" text="cheer"/>
                <l2 id="emote" display="Point" text="point"/>
                <l2 id="emote" display="Use" text="use"/>
                <l2 id="emote" display="Feign" text="feign"/>
                <l2 id="emote" display="Sleep" text="sleep"/>
                <l2 id="emote" display="Jump" text="jump"/>
                <l2 id="emote" display="Punt" text="punt"/>
                <l2 id="emote" display="Wave" text="wave"/>
                <l2 id="emote" display="Bow" text="bow"/>
                <l2 id="emote" display="Salute" text="Salute"/>
                <l2 id="emote" display="Backflip" text="backflip"/>
                <l2 id="emote" display="Swordplay" text="swordplay"/>
                <l2 id="emote" display="Unsheath" text="unsheath"/>
                <l2 id="emote" display="Facepalm" text="facepalm"/>
                <l2 id="emote" display="Air Guitar" text="airguitar"/>
                <l2 id="emote" display="Stern" text="stern"/>
            </l1>
            <l1 display="Hero Emotes">
                <l2 id="emote" display="Powerup" text="powerup"/>
                <l2 id="emote" display="Kneel" text="kneel"/>
                <l2 id="emote" display="Jumpcheer" text="jumpcheer"/>
                <l2 id="emote" display="Salute2" text="salute2"/>
                <l2 id="emote" display="Cry2" text="cry2"/>
                <l2 id="emote" display="Spar" text="spar"/>
                <l2 id="emote" display="Stepdance" text="stepdance"/>
                <l2 id="emote" display="Headbang" text="headbang"/>
                <l2 id="emote" display="Dazed" text="dazed"/>
                <l2 id="emote" display="DanceWeapon" text="danceweapon"/>
            </l1>
            <l1 display="Greetings">
                <l2 id="ba" display="Hello!" text="Hello!"/>
                <l2 id="bb" display="Hi!" text="Hi!"/>
                <l2 id="bc" display="Well met!" text="Well met!"/>
                <l2 id="bd" display="Welcome!" text="Welcome!"/>
                <l2 id="be" display="Welcome back!" text="Welcome back!"/>
                <l2 id="bf" display="How are you today?" text="How are you today?"/>
            </l1>
            <l1 display="Farewells">
                <l2 id="ca" display="Bye!" text="Bye!"/>
                <l2 id="cb" display="See you later." text="See you later."/>
                <l2 id="cc" display="AFK" text="I'm going AFK"/>
                <l2 id="cd" display="I have to go now." text="I have to go now."/>
                <l2 id="ce" display="Logging out now" text="Logging out now."/>
                <l2 id="cf" display="brb" text="brb"/>
                <l2 id="cg" display="Farewell" text="Farewell"/>
            </l1>
            <l1 display="Questions">
                <l2 id="da" display="Can I add you">
                    <l3 id="ea" display="to my Friends list" text="Can I add you to my Friends list?"/>
                    <l3 id="eb" display="to my Party" text="Can I add you to my Party?"/>
                </l2>
                <l2 id="db" display="Do you want to battle together?" text="Do you want to battle together?"/>
                <l2 id="dc" display="Is that a Hero only...">
                    <l3 id="fa" display="Helm" text=" Is that a Hero only helm?"/>
                    <l3 id="fb" display="Cape" text=" Is that a Hero only cape?"/>
                    <l3 id="fc" display="Armor" text=" Is that a Hero only armor?"/>
                    <l3 id="fd" display="Weapon" text=" Is that a Hero only weapon?"/>
                </l2>
                <l2 id="dd" display="Where are you?" text="Where are you?"/>
                <l2 id="de" display="Are you sure?" text="Are you sure?"/>
                <l2 id="df" display="Can I help you?" text="Can I help you?"/>
                <l2 id="dg" display="What is your alignment?" text="What is your alignment?"/>
                <l2 id="dh" display="Where did you get that ...">
                    <l3 id="ga" display="Helm" text="Where did you get that helm?"/>
                    <l3 id="gb" display="Cape" text="Where did you get that cape?"/>
                    <l3 id="gc" display="Armor" text="Where did you get that armor?"/>
                    <l3 id="gd" display="Weapon" text="Where did you get that weapon?"/>
                    <l3 id="ge" display="Pet" text="Where did you get that pet?"/>
                    <l3 id="ge" display="Class" text="Where did you get that class?"/>
                </l2>
                <l2 id="di" display="Are you a...">
                    <l3 id="ha" display="Guardian" text="Are you a Guardian?"/>
                    <l3 id="hb" display="DragonLord" text="Are you a DragonLord?"/>
                    <l3 id="hc" display="StarCaptain" text="Are you a StarCaptain?"/>
                </l2>
                <l2 id="dj" display="Do you play...">
                    <l3 id="ia" display="AdventureQuest" text="Do you play AdventureQuest?"/>
                    <l3 id="ib" display="DragonFable" text="Do you play DragonFable?"/>
                    <l3 id="ic" display="MechQuest" text="Do you play MechQuest?"/>
                </l2>
                <l2 id="dl" display="What are you doing?" text="What are you doing?"/>
            </l1>
            <l1 display="Answers">
                <l2 id="ja" display="thanks/welcome">
                    <l3 id="ka" display="Thanks!" text="Thanks!"/>
                    <l3 id="kb" display="Thank you!" text="Thank you!"/>
                    <l3 id="kc" display="Thanks for helping me." text="Thanks for helping me."/>
                    <l3 id="kd" display="I owe you one." text="I owe you one.."/>
                    <l3 id="ke" display="No problem!" text="No problem!"/>
                    <l3 id="kf" display="You're welcome!" text="You're welcome!"/>
                </l2>
                <l2 id="jn" display="I am doing/trying to..">
                    <l3 id="ma" display="Quest" text="I am doing a quest."/>
                    <l3 id="mb" display="Farming" text="I am farming."/>
                    <l3 id="mc" display="New" text="I am playing the new release."/>
                    <l3 id="md" display="Level up." text="I am trying to level up."/>
                    <l3 id="me" display="Rank up." text="I am trying to rank up."/>
                </l2>
                <l2 id="jb" display="I'm fine, thanks." text="I'm fine, thanks."/>
                <l2 id="jc" display="Could be better." text="Could be better."/>
                <l2 id="jd" display="I don't think so." text="I don't think so."/>
                <l2 id="je" display="I don't know." text="I don't know."/>
                <l2 id="jf" display="Indeed." text="Indeed."/>
                <l2 id="jg" display="Pleased to meet you." text="Pleased to meet you."/>
                <l2 id="jh" display="Good." text="I am Good."/>
                <l2 id="ji" display="Evil." text="I am Evil."/>
                <l2 id="jj" display="Me too!" text="Me too!"/>
                <l2 id="jk" display="I got it...">
                    <l3 id="la" display="as a drop." text="I got it as a drop."/>
                    <l3 id="lb" display="from a shop." text="I got it from a shop."/>
                </l2>
                <l2 id="jl" display="Check the Wiki..." text="You can check the Wiki for the location."/>
                <l2 id="jm" display="Your Book of Lore will know that" text="Your Book of Lore will know that."/>
                <l2 id="jo" display="I can only use Canned Chat." text="I can only use Canned Chat."/>
            </l1>
            <l1 display="Meeting up">
                <l2 id="na" display="Follow me!" text="Follow me!"/>
                <l2 id="nb" display="Over here!" text="Over here!"/>
                <l2 id="nc" display="Goto me." text="Goto me."/>
                <l2 id="nd" display="I'll follow you." text="I'll follow you."/>
                <l2 id="ne" display="Maybe some other time." text="Maybe some other time."/>
                <l2 id="nf" display="Ok, let's go." text="Ok, let's go."/>
                <l2 id="ng" display="Come back here." text="Come back here."/>
                <l2 id="nh" display="I need to finish this first." text="I need to finish this first."/>
                <l2 id="ni" display="Seriously?" text="Seriously?"/>
                <l2 id="nj" display="*I'm going to...">
                    <l3 id="oa" display="Artix" text="I'm going to the Artix Server."/>
                    <l3 id="ob" display="Galanoth" text="I'm going to the Galanoth Server."/>
                    <l3 id="oh" display="Sir Ver" text="I'm going to Sir Ver."/>
                    <l3 id="oi" display="Twig" text="I'm going to the Twig server."/>
                    <l3 id="oj" display="Twilly" text="I'm going to the Twilly server."/>
                    <l3 id="ok" display="Yorumi" text="I'm going to the Yorumi server."/>
                    <l3 id="oj" display="TestingServer" text="I'm going to the TestingServer server."/>
                    <l3 id="ok" display="TestingServer2" text="I'm going to the TestingServer2 server."/>
                </l2>
                <l2 id="nk" display="Sorry, I'm busy." text="Sorry, I'm busy."/>
            </l1>
            <l1 display="In Battle">
                <l2 id="pa" display="Can you..">
                    <l3 id="qa" display="help with battle" text="Can you help me with this battle?"/>
                    <l3 id="qb" display="help with Boss" text="Can you help me with the Boss?"/>
                </l2>
                <l2 id="pb" display="Planning...">
                    <l3 id="ra" display="Let's attack now!" text="Let's attack now!"/>
                    <l3 id="rb" display="I'll attack first." text="I'll attack first."/>
                    <l3 id="rc" display="You go first." text="You go first."/>
                    <l3 id="rd" display="I need to rest." text="I need to rest."/>
                </l2>
                <l2 id="pc" display="During the battle">
                    <l3 id="sa" display="Heal, please!" text="Heal, please!"/>
                    <l3 id="sb" display="MEDIC!" text="MEDIC!"/>
                    <l3 id="sc" display="Help!" text="Help!"/>
                    <l3 id="sd" display="I'm out of Mana." text="I'm out of Mana."/>
                    <l3 id="se" display="Use your special attacks!" text="Use your special attacks!"/>
                    <l3 id="sf" display="This monster is strong!" text="This monster is strong!"/>
                    <l3 id="sg" display="Slay that monster!" text="Slay that monster!"/>
                    <l3 id="sh" display="This is hard." text="This hard."/>
                    <l3 id="si" display="This is easy." text="This easy."/>
                    <l3 id="sj" display="Run away!" text="Run away!"/>
                </l2>
                <l2 id="pd" display="After battle">
                    <l3 id="ta" display="Yes! I got the drop!" text="Yes! I got the drop!"/>
                    <l3 id="tb" display="We did it!" text="We did it!"/>
                    <l3 id="tc" display="You fight well." text="You fight well."/>
                    <l3 id="td" display="Nooo! I died!" text="Nooo! I died!"/>
                    <l3 id="tf" display="Let's try again!" text="Let's try again!"/>
                </l2>
            </l1>
            <l1 display="Exclamations">
                <l2 id="ua" display="Battle on!" text="Battle on!"/>
                <l2 id="uc" display="OMG!" text="OMG!"/>
                <l2 id="ud" display="lol" text="lol"/>
                <l2 id="uf" display="Woot!" text="Woot!"/>
                <l2 id="ug" display="Wow!" text="Wow"/>
                <l2 id="uh" display="High Five!" text="High Five!"/>
                <l2 id="ui" display="Congrats!" text="Congrats!"/>
                <l2 id="uj" display="Level up!" text="Level up!"/>
                <l2 id="uk" display="Rank up!" text="Rank up!"/>
                <l2 id="ul" display="LONG UN-LIVE THE SHADOWSCYTHE!!" text="LONG UN-LIVE THE SHADOWSCYTHE!!"/>
                <l2 id="um" display="Long live King Alteon the Good!!" text="Long live King Alteon the Good!!"/>
                <l2 id="un" display="This rocks!" text="This rocks!"/>
                <l2 id="uo" display="This is awesome!" text="This is awesome!"/>
                <l2 id="up" display="This is fun." text="This is fun."/>
                <l2 id="uq" display="That is really cool." text="That is really cool."/>
                <l2 id="ur" display="Cheer up!" text="Cheer up!"/>
                <l2 id="ut" display="Great!" text="Great!"/>
                <l2 id="uu" display="HaHa" text="HaHa"/>
            </l1>
            <l1 display="Stop">
                <l2 id="va" display="following me" text="Please stop following me."/>
                <l2 id="vb" display="doing that" text="Please stop doing that."/>
                <l2 id="vc" display="PMing me" text="Please stop PMing me."/>
            </l1>
            <l1 display="Smilies">
                <l2 id="wa" display=":)" text=":)"/>
                <l2 id="wb" display=":(" text=":("/>
                <l2 id="wc" display=":/" text=":/"/>
                <l2 id="wd" display=":|" text=":|"/>
                <l2 id="we" display=":O" text=":O"/>
                <l2 id="wf" display="D:" text="D:"/>
            </l1>
            <l1 id="x" display="Yes." text="Yes."/>
            <l1 id="y" display="No." text="No."/>
            <l1 id="z" display="OK." text="OK."/>
        </CannedChat>
        ;

        public var game:Game;
        public var iChat:int = 0;
        public var mode:int = 1;
        public var pmSourceA:Array = [];
        public var mute:Object = {
            "ts":0,
            "cd":0,
            "timer":new Timer(0, 1)
        };
        public var pmI:int = 0;
        public var pmNm:String = "";
        public var ignoreList:SharedObject = SharedObject.getLocal("ignoreList");
        public var muteData:SharedObject = SharedObject.getLocal("muteData");
        public var chn:Object = {};
        public var myMsgsI:int = 0;
        public var pmMode:int = 0;
        public var acceptCross:Boolean = false;
        private var panelIndex:int = 0;
        private var chatArray:Array = [];
        private var drawnA:Array = [];
        private var tfHeight:int = 126;
        private var tfdH:int = Math.abs((t1Tally - t1Shorty));
        private var msgID:int = 0;
        private var t1Arr:Array = [];
        private var mcCannedChat:MovieClip;

        public function Chat(game:Game)
        {
            this.game = game;
        }

        public static function getCCText(_arg1:String):String
        {
            var ccOption:XML = getCCOption(_arg1, xmlCannedOptions.children());
            return ((ccOption != null) ? ccOption.attribute("text").toString() : "");
        }

        public static function cleanStr(message:String, _arg2:Boolean=true, _arg3:Boolean=false, _arg4:Boolean=false):String
        {
            message = message.split("&#").join("");
            message = ((_arg4) ? message.split("#038:#").join("") : message.split("#038:").join(""));
            if (message.indexOf("%") > -1)
            {
                message = message.split("%").join("#037:");
            };
            if (((_arg2) && (message.indexOf("#037:") > -1)))
            {
                message = message.split("#037:").join("%");
            };
            return (message);
        }

        public static function Hex2Color(r:String):String
        {
            return (Number(r).toString(16).toUpperCase());
        }

        public static function rainbowMessage(messageElement:String):String
        {
            var rgb2Color:String;
            var colorfulMessage:String = "";
            var center:* = 128;
            var width:int = 127;
            var frequency:Number = ((Math.PI << 1) / messageElement.length);
            var skip:Boolean;
            messageElement = messageElement.split("&amp;").join("&");
            messageElement = messageElement.split("&quot;").join('"');
            messageElement = messageElement.split("&apos;").join("'");
            messageElement = messageElement.split("&gt;").join(">");
            var i:int;
            while (i < messageElement.length)
            {
                if ((((messageElement.charAt(i) == "}") && (messageElement.charAt((i + 1)) == ")")) && (messageElement.charAt((i + 2)) == "$")))
                {
                    colorfulMessage = (colorfulMessage + closeTag);
                    i = (i + 3);
                    skip = false;
                };
                if ((((messageElement.charAt(i) == "$") && (messageElement.charAt((i + 1)) == "(")) && (messageElement.charAt((i + 2)) == "{")))
                {
                    colorfulMessage = (colorfulMessage + openTag);
                    i = (i + 3);
                    skip = true;
                };
                if (skip)
                {
                    colorfulMessage = (colorfulMessage + messageElement.charAt(i));
                }
                else
                {
                    rgb2Color = RGB2Color(((Math.sin((frequency * i)) * width) + center), ((Math.sin(((frequency * i) + 2)) * width) + center), ((Math.sin(((frequency * i) + 4)) * width) + center));
                    if ((((messageElement.charAt(i) == "&") && (messageElement.charAt((i + 1)) == "l")) && (messageElement.charAt((i + 2)) == "t")))
                    {
                        colorfulMessage = (colorfulMessage + (((fontColorStart + rgb2Color) + '">&lt;') + fontColorClose));
                        i = (i + 3);
                    }
                    else
                    {
                        colorfulMessage = (colorfulMessage + ((((fontColorStart + rgb2Color) + fontColorEnd) + messageElement.charAt(i)) + fontColorClose));
                    };
                };
                i++;
            };
            return (colorfulMessage);
        }

        private static function getCCOption(cc:String, list:XMLList):XML
        {
            var xml:XML;
            var xml1:XML;
            var listLength:int = list.length();
            var i:int;
            while (i < listLength)
            {
                xml = list[i];
                if (((xml.children().length() == 0) && (xml.attribute("id").toString() == cc)))
                {
                    return (xml);
                };
                xml1 = getCCOption(cc, xml.children());
                if (xml1 != null)
                {
                    return (xml1);
                };
                i++;
            };
            return (null);
        }

        private static function formatWithoutTextLinks(_arg1:TextField):void
        {
            var _local15:String;
            var _local16:String;
            var _local7:String;
            var _local8:String;
            var _local9:String;
            var _local10:String;
            var _local11:Array;
            var _local12:String;
            var _local13:String;
            while (((_arg1.htmlText.indexOf(openTag) > -1) && (_arg1.htmlText.indexOf(closeTag) > -1)))
            {
                _local7 = _arg1.htmlText;
                _local8 = _local7.substr(0, _local7.indexOf(openTag));
                _local9 = _local7.substr((_local7.indexOf(closeTag) + closeTag.length));
                _local10 = _local7.substr((_local7.indexOf(openTag) + openTag.length));
                _local11 = _local10.substr(0, _local10.indexOf(closeTag)).split(",");
                _local12 = _local11[0];
                _local13 = _local11[1];
                switch (_local12)
                {
                    case "url":
                        _local16 = _local13;
                        _local15 = ((((((fontColorStart + "FFFF99") + fontColorEnd) + "<u>") + _local16) + "</u>") + fontColorClose);
                        break;
                    case "user":
                        _local16 = _local13;
                        _local15 = ((((fontColorStart + "FFFFFF") + fontColorEnd) + _local16) + fontColorClose);
                        break;
                    case "item":
                    case "quest":
                        _local15 = ((((((fontColorStart + "FFFF99") + fontColorEnd) + "&lt;") + _local13) + "&gt;") + fontColorClose);
                        break;
                    case "emoji":
                        _local15 = "     ";
                        break;
                };
                _arg1.htmlText = ((_local8 + _local15) + _local9);
            };
        }

        private static function getBitmapByIndex(index:int, container:DisplayObjectContainer):DisplayObject
        {
            var child:DisplayObject;
            var childIndex:int;
            var i:int;
            while (i < container.numChildren)
            {
                child = container.getChildAt(i);
                childIndex = int(child.name.substr(1));
                if (childIndex == index)
                {
                    return (child);
                };
                i++;
            };
            return (null);
        }

        private static function RGB2Color(r:Number, g:Number, b:Number):String
        {
            return ((byte2Hex(r) + byte2Hex(g)) + byte2Hex(b));
        }

        private static function byte2Hex(n:Number):String
        {
            var nybHexString:String = "0123456789ABCDEF";
            return (String(nybHexString.substr(((n >> 4) & 0x0F), 1)) + nybHexString.substr((n & 0x0F), 1));
        }

        private static function urlClick(mouseEvent:MouseEvent):void
        {
            navigateToURL(new URLRequest(MovieClip(mouseEvent.currentTarget).str), "_blank");
        }

        private static function linkClick(mouseEvent:MouseEvent):void
        {
            LPFLayoutChatItemPreview.linkItem(Game.root.world.linkTree[MovieClip(mouseEvent.currentTarget).str.split("loadItem:")[1]]);
        }

        private static function onRollOut(event:MouseEvent):void
        {
            var cannedOption:CannedOption = CannedOption(event.currentTarget);
            cannedOption.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
            if (cannedOption.mcMoreOptions != null)
            {
                cannedOption.mcMoreOptions.visible = false;
            };
        }

        private static function onCannedChatOver(_arg1:MouseEvent):void
        {
            if (t != null)
            {
                t.reset();
            };
        }

        private static function onCannedChatOut(_arg1:MouseEvent):void
        {
            t.start();
        }


        public function init():void
        {
            this.chn.cur = {};
            this.chn.cur = this.chn.zone;
            this.chn.lastPublic = {};
            this.chn.lastPublic = this.chn.cur;
            if (this.ignoreList.data.users == undefined)
            {
                this.ignoreList.data.users = [];
            };
            this.chatArray = [];
            this.t1Arr = [];
            this.drawnA = [];
            this.msgID = 0;
            this.panelIndex = 0;
            this.tfHeight = 126;
            this.tfdH = Math.abs((t1Tally - t1Shorty));
            if (this.muteData.data != null)
            {
                this.mute.ts = this.muteData.data.ts;
                this.mute.cd = this.muteData.data.cd;
            };
            this.mute.timer.addEventListener(TimerEvent.TIMER, this.unmuteMe, false, 0, true);
            this.buildCannedChat();
            this.game.ui.mcInterface.tt.mouseEnabled = false;
            this.game.ui.mcInterface.textLine.ti.htmlText = "";
            this.game.ui.mcInterface.textLine.ti.autoSize = "left";
            this.game.ui.mcInterface.textLine.visible = false;
            this.game.ui.mcInterface.bMinMax.buttonMode = true;
            this.game.ui.mcInterface.bMinMax.a2.visible = false;
            this.game.ui.mcInterface.bShortTall.buttonMode = true;
            this.game.ui.mcInterface.bShortTall.a2.visible = false;
            this.game.ui.mcInterface.te.text = "";
            this.game.ui.mcInterface.te.visible = false;
            this.game.ui.mcInterface.tt.text = "";
            this.game.ui.mcInterface.tt.visible = false;
            this.game.ui.mcInterface.te.maxChars = 150;
            this.game.ui.mouseEnabled = false;
            this.game.ui.mcInterface.mouseEnabled = false;
            this.game.ui.mcInterface.t1.mouseEnabled = false;
            this.game.ui.mcInterface.lotteLotteLotte.mouseEnabled = true;
            this.game.ui.mcInterface.bCannedChat.removeEventListener(MouseEvent.CLICK, this.onCannedChatClick);
            this.game.ui.mcInterface.bsend.removeEventListener(MouseEvent.CLICK, this.chat_btnSend);
            this.game.ui.mcInterface.tebg.removeEventListener(MouseEvent.CLICK, this.chat_tebgClick);
            this.game.ui.mcInterface.bMinMax.removeEventListener(MouseEvent.CLICK, this.bMinMaxClick);
            this.game.ui.mcInterface.bMinMax.removeEventListener(MouseEvent.MOUSE_OVER, this.bMinMaxMouseOver);
            this.game.ui.mcInterface.bMinMax.removeEventListener(MouseEvent.MOUSE_OUT, this.bMinMaxMouseOut);
            this.game.ui.mcInterface.bShowChat.removeEventListener(MouseEvent.CLICK, this.bShowChatClick);
            this.game.ui.mcInterface.bShowChat.removeEventListener(MouseEvent.MOUSE_OVER, this.bShowChatMouseOver);
            this.game.ui.mcInterface.bShowChat.removeEventListener(MouseEvent.MOUSE_OUT, this.bShowChatMouseOut);
            this.game.ui.mcInterface.bShortTall.removeEventListener(MouseEvent.CLICK, this.bShortTallClick);
            this.game.ui.mcInterface.bShortTall.removeEventListener(MouseEvent.MOUSE_OVER, this.bShortTallMouseOver);
            this.game.ui.mcInterface.bShortTall.removeEventListener(MouseEvent.MOUSE_OUT, this.bShortTallMouseOut);
            this.game.stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.game.key_StageGame);
            this.game.ui.mcInterface.te.removeEventListener(KeyboardEvent.KEY_DOWN, this.game.key_ChatEntry);
            this.game.ui.mcInterface.te.removeEventListener(Event.CHANGE, this.checkMsgType);
            this.game.stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelEvent);
            t.removeEventListener(TimerEvent.TIMER, this.closeCannedChatTimer);
            windowTimer.removeEventListener(TimerEvent.TIMER, this.timedWindowHide);
            this.game.ui.mcInterface.bCannedChat.addEventListener(MouseEvent.CLICK, this.onCannedChatClick);
            this.game.ui.mcInterface.bsend.addEventListener(MouseEvent.CLICK, this.chat_btnSend);
            this.game.ui.mcInterface.tebg.addEventListener(MouseEvent.CLICK, this.chat_tebgClick);
            this.game.ui.mcInterface.bMinMax.addEventListener(MouseEvent.CLICK, this.bMinMaxClick);
            this.game.ui.mcInterface.bMinMax.addEventListener(MouseEvent.MOUSE_OVER, this.bMinMaxMouseOver);
            this.game.ui.mcInterface.bMinMax.addEventListener(MouseEvent.MOUSE_OUT, this.bMinMaxMouseOut);
            this.game.ui.mcInterface.bShowChat.addEventListener(MouseEvent.CLICK, this.bShowChatClick);
            this.game.ui.mcInterface.bShowChat.addEventListener(MouseEvent.MOUSE_OVER, this.bShowChatMouseOver);
            this.game.ui.mcInterface.bShowChat.addEventListener(MouseEvent.MOUSE_OUT, this.bShowChatMouseOut);
            this.game.ui.mcInterface.bShortTall.addEventListener(MouseEvent.CLICK, this.bShortTallClick);
            this.game.ui.mcInterface.bShortTall.addEventListener(MouseEvent.MOUSE_OVER, this.bShortTallMouseOver);
            this.game.ui.mcInterface.bShortTall.addEventListener(MouseEvent.MOUSE_OUT, this.bShortTallMouseOut);
            this.game.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.game.key_StageGame);
            this.game.ui.mcInterface.te.addEventListener(KeyboardEvent.KEY_DOWN, this.game.key_ChatEntry);
            this.game.ui.mcInterface.te.addEventListener(Event.CHANGE, this.checkMsgType);
            this.game.stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelEvent);
            t.addEventListener(TimerEvent.TIMER, this.closeCannedChatTimer);
            windowTimer.addEventListener(TimerEvent.TIMER, this.timedWindowHide);
        }

        public function toggleChatWindow(show:Boolean=true):void
        {
            var showChatButton:MovieClip = this.game.ui.mcInterface.bShowChat;
            if (!this.game.chatSession.shown())
            {
                this.game.chatSession.show();
                if (show)
                {
                    this.game.ui.ToolTip.openWith({"str":"Hide the chat window"});
                };
                return;
            };
            this.game.chatSession.hide();
            showChatButton.a1.visible = false;
            showChatButton.a2.visible = true;
            if (show)
            {
                this.game.ui.ToolTip.openWith({"str":"Show the chat window"});
            };
        }

        public function toggleChatPane(show:Boolean=true):void
        {
            var minMaxButton:MovieClip = this.game.ui.mcInterface.bMinMax;
            if (!this.game.ui.mcInterface.t1.visible)
            {
                this.game.ui.mcInterface.t1.visible = true;
                minMaxButton.a1.visible = true;
                minMaxButton.a2.visible = false;
                this.mode = 1;
                if (this.chn.zone.act)
                {
                    this.chn.cur = this.chn.zone;
                    this.chn.lastPublic = this.chn.zone;
                    this.game.ui.mcInterface.te.text = this.game.ui.mcInterface.te.text.substr((this.game.ui.mcInterface.te.text.split(" ")[0].substr(1).length + 2));
                };
                if (show)
                {
                    this.game.ui.ToolTip.openWith({"str":"Hide the chat pane"});
                };
                return;
            };
            this.game.ui.mcInterface.t1.visible = false;
            minMaxButton.a1.visible = false;
            minMaxButton.a2.visible = true;
            if (show)
            {
                this.game.ui.ToolTip.openWith({"str":"Show the chat pane"});
            };
        }

        public function formatMsgEntry(message:String):void
        {
            this.game.ui.mcInterface.te.setSelection(0, 0);
            switch (this.chn.cur)
            {
                case this.chn.whisper:
                    if ((("string" == "undefined") || (message == "")))
                    {
                        this.game.ui.mcInterface.tt.text = "";
                        this.game.ui.mcInterface.tt.visible = false;
                    }
                    else
                    {
                        this.pmNm = message;
                        this.game.ui.mcInterface.tt.htmlText = (("To " + message) + ": ");
                        this.game.ui.mcInterface.tt.visible = true;
                    };
                    break;
                case this.chn.alliance:
                    if ((("string" == "undefined") || (message == "")))
                    {
                        this.game.ui.mcInterface.tt.text = "";
                        this.game.ui.mcInterface.tt.visible = false;
                    }
                    else
                    {
                        this.pmNm = message;
                        this.game.ui.mcInterface.tt.htmlText = (("To <font color='#00FF00'>[Alliance]</font> " + message) + ": ");
                        this.game.ui.mcInterface.tt.visible = true;
                    };
                    break;
                default:
                    if (this.chn.cur == this.chn.zone)
                    {
                        this.game.ui.mcInterface.tt.text = "";
                        this.game.ui.mcInterface.tt.visible = false;
                    }
                    else
                    {
                        this.game.ui.mcInterface.tt.text = (this.chn.cur.tag + ": ");
                        this.game.ui.mcInterface.tt.visible = true;
                    };
            };
        }

        public function updateMsgEntry():void
        {
            this.game.ui.mcInterface.te.x = ((this.game.ui.mcInterface.tt.x + this.game.ui.mcInterface.tt.textWidth) + ((this.game.ui.mcInterface.tt.text.length) ? 1 : 0));
            this.game.ui.mcInterface.te.width = ((this.game.ui.mcInterface.bsend.x - this.game.ui.mcInterface.te.x) - 3);
            this.game.ui.mcInterface.te.textColor = "0xFFFFFF";
        }

        public function submitMsg(message:String, typ:String, unm:String, isMulti:Boolean=false):void
        {
            var targetUsername:String;
            var guildName:String;
            var i:int;
            var params:Array;
            var paramStr:String;
            var key:String;
            var counter:int;
            var displayObject:DisplayObject;
            var mapMovieClip:MovieClip;
            var roomNumber:int;
            var partA:String;
            var partB:String;
            if (this.game.ui.mcInterface.te.htmlText == "")
            {
                this.closeMsgEntry();
            };
            var xtArr:Array = [];
            var cmd:String = "";
            var uVars:* = undefined;
            if ((((!(this.game.world == null)) && (!(this.game.world.myAvatar == null))) && ((this.game.world.myAvatar.items == null) || (this.game.world.myAvatar.items.length < 1))))
            {
                this.pushMsg("warning", "Character is still being loaded, please wait a moment.", "SERVER", "", 0);
                return;
            };
            if (message.substr(0, 1) == "/")
            {
                i = 0;
                params = message.substr(1).split(" ");
                paramStr = params[0].toLowerCase();
                switch (paramStr)
                {
                    case "reload":
                        cmd = null;
                        this.game.world.reloadCurrentMap();
                        break;
                    case "debug":
                        cmd = null;
                        if (this.game.world.myAvatar.isStaff())
                        {
                            Config.debugToggle();
                        };
                        break;
                    case "stats":
                        cmd = null;
                        for (key in this.game.world.myAvatar.dataLeaf.sta)
                        {
                            this.pushMsg("server", ((key + ": ") + this.game.world.myAvatar.dataLeaf.sta[key]), "SERVER", "", 0);
                        };
                        break;
                    case "frame":
                        cmd = null;
                        this.pushMsg("server", ("Your current frame is: " + this.game.world.map.currentLabel), "SERVER", "", 0);
                        counter = 0;
                        while (counter < this.game.world.map.numChildren)
                        {
                            displayObject = this.game.world.map.getChildAt(counter);
                            if ((displayObject is MovieClip))
                            {
                                mapMovieClip = MovieClip(displayObject);
                                if (mapMovieClip.isMonster)
                                {
                                    this.pushMsg("warning", ("Current Frame Monster ID: " + mapMovieClip.MonMapID), "SERVER", "", 0);
                                };
                            };
                            counter++;
                        };
                        break;
                    case "rejoin":
                        cmd = null;
                        if (this.game.world.myAvatar.isStaff())
                        {
                            roomNumber = (1000 + Math.floor((Math.random() * ((9000 - 1000) + 1))));
                            this.game.world.gotoTown(((this.game.world.strMapName + "-") + roomNumber), this.game.world.strFrame, this.game.world.strPad);
                        };
                        break;
                    case "rebuild":
                        cmd = null;
                        if (this.game.world.myAvatar.isStaff())
                        {
                            this.game.world.rebuildFrame();
                        };
                        break;
                    case "cell":
                        cmd = null;
                        if (this.game.world.myAvatar.isStaff())
                        {
                            partA = ((params.length > 1) ? params[1] : "none");
                            partB = ((params.length > 2) ? params[2] : "none");
                            if (partA != "none")
                            {
                                this.game.world.moveToCell(partA, partB);
                            };
                        };
                        break;
                    case "props":
                        cmd = null;
                        if (this.game.world.myAvatar.isStaff())
                        {
                            this.game.toggleHideRemoveProps();
                        };
                        break;
                    case "shop":
                        cmd = null;
                        if (this.game.world.myAvatar.objData.intAccessLevel >= 40)
                        {
                            this.game.world.sendLoadShopRequest(((params.length > 1) ? int(params[1]) : 1));
                        };
                        break;
                    case "ignore":
                        cmd = null;
                        if (params.length > 1)
                        {
                            targetUsername = params.slice(1).join(" ");
                            if (targetUsername.toLowerCase() != this.game.network.myUserName)
                            {
                                cmd = "cmd";
                                this.ignore(targetUsername);
                                message = ("You are now ignoring user " + targetUsername);
                                this.pushMsg("server", message, "SERVER", "", 0);
                            }
                            else
                            {
                                message = "You cannot ignore yourself!";
                                this.pushMsg("warning", message, "SERVER", "", 0);
                            };
                        };
                        break;
                    case "unignore":
                        cmd = null;
                        if (params.length > 1)
                        {
                            targetUsername = params.slice(1).join(" ");
                            cmd = "cmd";
                            this.unignore(targetUsername);
                            message = (("User " + targetUsername) + " is no longer being ignored");
                            this.pushMsg("server", message, "SERVER", "", 0);
                        };
                        break;
                    case "ignoreclear":
                        cmd = null;
                        this.ignoreList.data.users = [];
                        this.pushMsg("warning", "Ignore List Cleared!", "SERVER", "", 0);
                        this.game.network.send("cmd", ["ignoreList", "$clearAll"]);
                        break;
                    case "guild":
                        this.game.toggleGuildPanel();
                        break;
                    case "guildInvite":
                    case "gi":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            this.game.world.guildInvite(params.slice(1).join(" "));
                        };
                        break;
                    case "gwar":
                    case "war":
                    case "guildwar":
                    case "guildWar":
                    case "gw":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            targetUsername = params.slice(1).join(" ");
                            this.game.world.sendGuildWarInvite(targetUsername);
                        };
                        break;
                    case "guildremove":
                    case "gr":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            targetUsername = params.slice(1).join(" ");
                            MainController.modal((("Do you want to remove " + targetUsername) + " from the guild?"), this.game.world.guildRemove, {"userName":targetUsername}, null, "dual");
                        };
                        break;
                    case "motd":
                        if (message.length == 5)
                        {
                            if (this.game.world.myAvatar.objData.guild)
                            {
                                if (this.game.world.myAvatar.objData.guild.MOTD != null)
                                {
                                    this.pushMsg("guild", ("Message of the day: " + String(this.game.world.myAvatar.objData.guild.MOTD)), "SERVER", "", 0);
                                }
                                else
                                {
                                    this.pushMsg("guild", "No Message of the day has been set.", "SERVER", "", 0);
                                };
                            };
                        }
                        else
                        {
                            this.game.world.setGuildMOTD(message.substr(5));
                        };
                        break;
                    case "gc":
                    case "guildcreate":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            guildName = params.slice(1).join(" ");
                            MainController.modal((("Do you want to create the guild " + guildName) + "?"), this.game.world.createGuild, {"guildName":guildName}, null, "dual");
                        }
                        else
                        {
                            this.game.chatF.pushMsg("server", "Please specify a name for your guild.", "SERVER", "", 0);
                        };
                        break;
                    case "renameGuild":
                    case "rg":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            guildName = params.slice(1).join(" ");
                            MainController.modal((((((("Do you want to rename the guild to " + guildName) + "? This will cost ") + Config.getInt("guild_rename_cost")) + " ") + Config.getString("coins_name_short")) + "."), this.game.world.renameGuild, {"guildName":guildName}, "red,medium", "dual");
                        }
                        else
                        {
                            this.game.chatF.pushMsg("server", "Please specify a name for your guild.", "SERVER", "", 0);
                        };
                        break;
                    case "guildreset":
                        this.game.network.send("guild", ["guildreset"]);
                        break;
                    case "invite":
                    case "pi":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            targetUsername = params.slice(1).join(" ");
                            this.game.world.partyController.partyInvite(targetUsername);
                            this.addToCannedChat({
                                "parent":"History",
                                "id":"Command History",
                                "display":("/invite " + targetUsername),
                                "text":["invite", targetUsername]
                            }, this.getJsonCannedChatMenu());
                        };
                        break;
                    case "ps":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            this.game.world.partyController.partySummon(params.slice(1).join(" "));
                        };
                        break;
                    case "pk":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            this.game.world.partyController.partyKick(params.slice(1).join(" "));
                        };
                        break;
                    case "duel":
                        cmd = null;
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            targetUsername = params.slice(1).join(" ");
                            this.game.world.sendDuelInvite(targetUsername);
                            this.addToCannedChat({
                                "parent":"History",
                                "id":"Command History",
                                "display":("/duel " + targetUsername),
                                "text":["duel", targetUsername]
                            }, this.getJsonCannedChatMenu());
                        };
                        break;
                    case "friends":
                        cmd = null;
                        this.game.world.showFriendsList();
                        break;
                    case "friend":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            targetUsername = params.slice(1).join(" ");
                            if (targetUsername.toLowerCase() != this.game.network.myUserName)
                            {
                                this.game.world.requestFriend(targetUsername);
                            };
                        };
                        break;
                    case "tfer":
                    case "join":
                        if (((((params.length > 1) && (params[1].length > 0)) && (!(this.game.world.uoTree[this.game.network.myUserName].intState == 0))) && (this.game.world.coolDown("tfer"))))
                        {
                            this.game.world.returnInfo = null;
                            cmd = "cmd";
                            xtArr.push("tfer", this.game.network.myUserName, params.slice(1).join(" "));
                        };
                        break;
                    case "house":
                        cmd = null;
                        this.game.world.gotoHouse(((params[1] == null) ? this.game.network.myUserName : params.slice(1).join(" ")));
                        break;
                    case "flylove":
                        if (this.game.world.myAvatar.isStaff())
                        {
                            cmd = null;
                            this.game.world.flyToggle();
                        };
                        break;
                    case "kick":
                    case "unmute":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            cmd = "cmd";
                            xtArr.push(params[0], params.slice(1).join(" "));
                        };
                        break;
                    case "mute":
                    case "ban":
                        if ((((this.game.world.myAvatar.isStaff()) && (params.length > 2)) && (params[2].length > 0)))
                        {
                            cmd = "cmd";
                            targetUsername = params.slice(2).join(" ");
                            xtArr.push(params[0], params[1], targetUsername);
                        };
                        break;
                    case "goto":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            cmd = null;
                            this.game.world._SafeStr_1(params.slice(1).join(" "));
                        };
                        break;
                    case "pull":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            cmd = null;
                            this.game.world.pull(params.slice(1).join(" "));
                        };
                        break;
                    case "npcmessage":
                    case "npcattack":
                    case "monsterattack":
                    case "emotemessage":
                    case "iay":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            cmd = "cmd";
                            xtArr.push(params[0], cleanStr(params.slice(1).join(" "), false, true));
                        };
                        break;
                    case "fps":
                        cmd = null;
                        this.game.world.toggleFPS();
                        break;
                    case "geta":
                        if (((this.game.world.myAvatar.isStaff()) && (params.length == 3)))
                        {
                            this.pushMsg("warning", ((((("geta " + params[1]) + ",") + params[2]) + ": ") + Achievement.getAchievement(params[1], params[2])), "SERVER", "", 0);
                        };
                        break;
                    case "seta":
                        if (((this.game.world.myAvatar.isStaff()) && (params.length == 4)))
                        {
                            this.game.world.setAchievement(params[1], params[2], params[3]);
                        };
                        break;
                    case "e":
                    case "me":
                    case "em":
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            cmd = "em";
                            xtArr.push(cleanStr(params.slice(1).join(" "), false, true), this.chn.event.str);
                        };
                        break;
                    case "who":
                        cmd = "cmd";
                        xtArr.push(params[0]);
                        if (((params.length > 1) && (params[1].length > 0)))
                        {
                            xtArr.push(params[1]);
                        };
                        break;
                    case "afk":
                        cmd = null;
                        this.game.world.afkToggle();
                        break;
                    case "rest":
                        this.game.world.rest();
                        break;
                    case "samba":
                    case "danceweapon":
                    case "useweapon":
                    case "powerup":
                    case "kneel":
                    case "jumpcheer":
                    case "salute2":
                    case "cry2":
                    case "spar":
                    case "stepdance":
                    case "headbang":
                    case "dazed":
                        if (!this.game.world.myAvatar.isUpgraded())
                        {
                            this.pushMsg("warning", "Requires membership to use this emote.", "SERVER", "", 0);
                            break;
                        };
                    case "casting":
                    case "fishing":
                    case "mining":
                    case "hex":
                    case "firejump":
                    case "firewings":
                    case "headscratch":
                    case "shock":
                    case "castmagic":
                    case "dab":
                    case "groundtofly":
                    case "flyidle":
                    case "flywalk":
                    case "flytoground":
                    case "facepalm2":
                    case "fall":
                    case "relax":
                    case "toss":
                    case "hold":
                    case "spin":
                    case "hop":
                    case "idea":
                    case "pant":
                    case "dance":
                    case "laugh":
                    case "lol":
                    case "point":
                    case "use":
                    case "fart":
                    case "backflip":
                    case "sleep":
                    case "jump":
                    case "punt":
                    case "dance2":
                    case "swordplay":
                    case "feign":
                    case "wave":
                    case "bow":
                    case "cry":
                    case "unsheath":
                    case "cheer":
                    case "stern":
                    case "salute":
                    case "airguitar":
                    case "facepalm":
                        uVars = {};
                        cmd = (uVars.typ = "emotea");
                        uVars.strEmote = paramStr;
                        if (uVars.strEmote == "lol")
                        {
                            uVars.strEmote = "laugh";
                        };
                        uVars.strChar = params[1];
                        break;
                    default:
                        cmd = "cmd";
                        i = 0;
                        while (i < params.length)
                        {
                            xtArr.push(params[i]);
                            i++;
                        };
                };
            }
            else
            {
                switch (typ)
                {
                    case "whisper":
                    case "alliance":
                        cmd = typ;
                        message = cleanStr(message, false, true);
                        xtArr.push(message);
                        xtArr.push(unm);
                        break;
                    default:
                        cmd = "message";
                        message = cleanStr(message, false, true);
                        xtArr.push(message);
                        xtArr.push(this.chn.cur.str);
                        if (((this.chn.cur.str == "crosschat") && (!(this.acceptCross))))
                        {
                            MainController.modal(((((((((((("Please read the rules before sending a message to the cross chat. \n\n <font size='22' color='#FF0000'>RULES:</font>\n" + "<p align='left'>1. Be respectful to members of all servers.\n") + "2. Avoid using offensive or toxic language.\n") + "3. This server is under the Megumin service, which promotes a peaceful and welcoming community.\n") + "4. Violations of the rules will result in <font color='#FF0000'>penalties</font>:\n") + "   - 1st Violation: Warning.\n") + "   - 2nd Violation: Ban from your Origin Server.\n") + "   - 3rd Violation: Ban from all Megumin Servers.\n\n") + "<b>This notice will only show in every restart of your launcher. Would you still like to send the message below?</b>\n\n") + "Your Message: ") + message) + "</p>"), this.trySendChat, {
                                "cmd":cmd,
                                "message":message,
                                "xtArr":xtArr,
                                "channel":this.chn.cur.str
                            }, "red,medium", "dual");
                            this.closeMsgEntry();
                            return;
                        };
                };
            };
            if (cmd == "emotea")
            {
                this.addToCannedChat({
                    "parent":"History",
                    "id":"Emote History",
                    "display":("/" + uVars.strEmote),
                    "text":uVars.strEmote
                }, this.getJsonCannedChatMenu());
                this.game.world.myAvatar.pMC.mcChar.gotoAndPlay(this.game.strToProperCase(uVars.strEmote));
                this.game.network.send(cmd, [uVars.strEmote]);
            }
            else
            {
                if (((cmd == "mod") || (cmd == "cmd")))
                {
                    if (xtArr.length)
                    {
                        this.game.network.send(cmd, xtArr);
                    };
                }
                else
                {
                    this.trySendChat({
                        "cmd":cmd,
                        "message":message,
                        "xtArr":xtArr,
                        "channel":this.chn.cur.str,
                        "accept":true
                    });
                };
            };
            this.closeMsgEntry();
        }

        public function trySendChat(event:Object):void
        {
            var iDiff:Number;
            var iHrs:Number;
            var iMin:Number;
            if (!event.accept)
            {
                this.game.MsgBox.notify("Message Cancelled.");
                return;
            };
            if (((event.channel == "crosschat") && (!(this.acceptCross))))
            {
                this.acceptCross = true;
            };
            if (((!(event.cmd == "simple")) && ((!(event.cmd == null)) && (event.xtArr.length >= 1))))
            {
                this.game.world.afkPostpone();
                if (this.iChat == 0)
                {
                    this.pushMsg("warning", "This server only allows canned chat.", "SERVER", "", 0);
                }
                else
                {
                    if (((this.iChat == 1) && (!(((this.game.world.myAvatar.hasUpgraded()) || (this.game.world.myAvatar.isVerified())) || (this.game.world.myAvatar.isStaff())))))
                    {
                        this.pushMsg("warning", "Chat is a members-only feature at this time.", "SERVER", "", 0);
                    }
                    else
                    {
                        if (this.game.world.myAvatar.objData.bPermaMute == 1)
                        {
                            this.pushMsg("warning", "You are mute! Chat privileges have been permanently revoked.", "SERVER", "", 0);
                        }
                        else
                        {
                            if (((!(this.game.world.myAvatar.objData.dMutedTill == null)) && (this.game.world.myAvatar.objData.dMutedTill.getTime() > this.game.date_server.getTime())))
                            {
                                iDiff = ((this.game.world.myAvatar.objData.dMutedTill.getTime() - this.game.date_server.getTime()) / 1000);
                                iHrs = Math.floor((iDiff / 3600));
                                iMin = Math.floor(((iDiff - (iHrs * 3600)) / 60));
                                this.pushMsg("warning", (((("You are mute! Chat privileges have been revoked for the next " + iHrs) + "h ") + iMin) + "m!"), "SERVER", "", 0);
                            }
                            else
                            {
                                if (this.amIMute())
                                {
                                    this.pushMsg("warning", "You are mute! Chat privileges have been temporarily revoked.", "SERVER", "", 0);
                                }
                                else
                                {
                                    if (event.xtArr[0].length > 0)
                                    {
                                        this.addToCannedChat({
                                            "parent":"History",
                                            "id":"Chat History",
                                            "display":event.message,
                                            "text":event.xtArr
                                        }, this.getJsonCannedChatMenu());
                                        this.game.network.send(event.cmd, event.xtArr);
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public function closeCannedChat():void
        {
            this.mcCannedChat.visible = false;
        }

        public function writeText(panelIndex:int):void
        {
            var text:DisplayObject;
            var i1:int;
            var pos:int;
            var arr:Array = [];
            var b:Boolean = true;
            var i:int = (this.t1Arr.length - 1);
            while (i > -1)
            {
                if (((i <= panelIndex) && (b)))
                {
                    i1 = this.t1Arr[i].id;
                    this.game.ui.mcInterface.textLine.ti.htmlText = this.t1Arr[i].s;
                    formatWithoutTextLinks(this.game.ui.mcInterface.textLine.ti);
                    pos = this.checkPos(this.game.ui.mcInterface.textLine, i, i1, panelIndex);
                    if (pos <= 0)
                    {
                        b = false;
                    }
                    else
                    {
                        arr.push(i1);
                        if (this.drawnA.indexOf(i1) > -1)
                        {
                            text = getBitmapByIndex(i1, this.game.ui.mcInterface.t1);
                        }
                        else
                        {
                            text = this.buildTextLinks(this.game.ui.mcInterface.textLine.ti, this.t1Arr[i].s, this.game.ui.mcInterface.t1, this.drawnA, i1);
                        };
                        text.y = pos;
                        MovieClip(text).mouseEnabled = false;
                    };
                };
                i--;
            };
            i = 0;
            while (i < this.drawnA.length)
            {
                if (arr.indexOf(this.drawnA[i]) < 0)
                {
                    text = getBitmapByIndex(this.drawnA[i], this.game.ui.mcInterface.t1);
                    if (text != null)
                    {
                        this.game.ui.mcInterface.t1.removeChild(text);
                        this.drawnA.splice(i, 1);
                        i--;
                    };
                };
                i++;
            };
        }

        public function pushMsg(channel:String, message:String, username:String, target:String, isReceiving:int, _arg6:int=0):void
        {
            var showWarning:Boolean;
            var channelElement:String;
            var messageElement:String;
            var usernameElement:String;
            var targetElement:String;
            var isReceivingElement:int;
            var sixthElement:int;
            var usernameColor:String;
            var tagContent:String;
            var timestampContent:String;
            var userPrefix:String;
            var xColor:String;
            var isRainbow:Boolean;
            var chatColor:String;
            var avatarChat:Avatar;
            if (((!(this.ignoreList.data.users == null)) && (this.ignoreList.data.users.indexOf(username) > -1)))
            {
                return;
            };
            this.game.chatSession.addChatHistory({
                "channel":"all",
                "message":message,
                "username":username,
                "time":(("(" + this.game.date_server.toLocaleTimeString()) + ")"),
                "target":channel
            });
            switch (channel)
            {
                case "warning":
                case "server":
                case "game":
                    this.game.chatSession.addChatHistory({
                        "channel":"server",
                        "message":message,
                        "username":username,
                        "time":(("(" + this.game.date_server.toLocaleTimeString()) + ")"),
                        "target":channel
                    });
                    break;
                case "world":
                case "party":
                case "guild":
                case "trade":
                case "crosschat":
                    this.game.chatSession.addChatHistory({
                        "channel":channel,
                        "message":message,
                        "username":username,
                        "time":(("(" + this.game.date_server.toLocaleTimeString()) + ")"),
                        "target":channel
                    });
                    break;
                default:
                    this.game.chatSession.addChatHistory({
                        "channel":"area",
                        "message":message,
                        "username":username,
                        "time":(("(" + this.game.date_server.toLocaleTimeString()) + ")"),
                        "target":channel
                    });
            };
            var chatChannels:Array = ["zone", "warning", "world", "crosschat", "party", "guild", "trade"];
            if (chatChannels.indexOf(channel) !== -1)
            {
                showWarning = ((channel == "warning") && ((this.game.userPreference.data.defaultChatServerMessage) || ((!(Game.root.autoCombatTimer == null)) && (Game.root.autoCombatTimer.running))));
                switch (this.mode)
                {
                    case 1:
                        if (showWarning)
                        {
                            return;
                        };
                        break;
                    case 2:
                        if (((channel == "zone") || (showWarning))) break;
                        return;
                    case 3:
                        if ((((channel == "world") || (channel == "crosschat")) || (showWarning))) break;
                        return;
                    case 4:
                        if (((channel == "party") || (showWarning))) break;
                        return;
                    case 5:
                        if (((channel == "guild") || (showWarning))) break;
                        return;
                    case 6:
                        if (((channel == "trade") || (showWarning))) break;
                        return;
                    case 7:
                        if (((channel == "crosschat") || (showWarning))) break;
                        return;
                    default:
                        return;
                };
            };
            var whisper:Boolean;
            switch (channel)
            {
                case "whisper":
                    username = this.game.strToProperCase(username);
                    if (((!(username.toLowerCase() == this.game.network.myUserName)) && (_arg6 == 0)))
                    {
                        whisper = true;
                    };
                    break;
                case "crosschat":
                case "warning":
                case "server":
                case "game":
                case "event":
                case "wheel":
                    break;
                case "alliance":
                case "trade":
                case "party":
                case "guild":
                case "world":
                case "moderator":
                    if (username.toLowerCase() != "server")
                    {
                        username = this.game.strToProperCase(username);
                    };
                    break;
                case "npc":
                    this.popBubble(("n:" + this.game.strToProperCase(username)), message);
                    break;
                case "zone":
                    username = this.game.strToProperCase(username);
                    this.popBubble(("u:" + username), message);
                    break;
            };
            this.checkFieldsVPos();
            this.chatArray.push([channel, message, username, target, isReceiving, this.msgID]);
            var lineLimit:int = 100;
            if (this.chatArray.length > lineLimit)
            {
                this.chatArray.splice(0, (this.chatArray.length - lineLimit));
            };
            this.html2Fields("", "=", "server", 0);
            this.t1Arr = [];
            var i1:int;
            while (i1 < this.chatArray.length)
            {
                channelElement = this.chatArray[i1][0];
                messageElement = this.chatArray[i1][1];
                usernameElement = this.chatArray[i1][2];
                targetElement = this.chatArray[i1][3];
                isReceivingElement = this.chatArray[i1][4];
                sixthElement = this.chatArray[i1][5];
                usernameColor = this.chn[channelElement].col;
                tagContent = ((this.chn[channelElement].tag == "") ? "" : (((((((fontColorStart + usernameColor) + fontColorEnd) + "[") + this.chn[channelElement].tag) + "]") + fontColorClose) + " "));
                timestampContent = ((this.game.userPreference.data["defaultChatTimestamp"]) ? (((((((fontColorStart + "666666") + fontColorEnd) + "[") + (((isNaN(this.game.date_server.hours)) || (isNaN(this.game.date_server.minutes))) ? "00:00" : ((((this.game.date_server.hours < 10) ? ("0" + this.game.date_server.hours) : this.game.date_server.hours) + ":") + ((this.game.date_server.minutes < 10) ? ("0" + this.game.date_server.minutes) : this.game.date_server.minutes)))) + "]") + fontColorClose) + " ") : "");
                if (messageElement.indexOf("loadItem") > 0)
                {
                    messageElement = messageElement.replace(regExpLinking2, "$1");
                    messageElement = messageElement.replace(/<\s*A HREF="(.*?)">&lt;(.*?)&gt;<\s*\/A\s*>/ig, "$({item,$2,$1})$");
                };
                if (messageElement.indexOf("emoji:") > 0)
                {
                    messageElement = messageElement.replace(regExpLinking2, "$1");
                    messageElement = messageElement.replace(/<\s*A HREF="(.*?)">&lt;(.*?)&gt;<\s*\/A\s*>/ig, "$({emoji,$2,$1})$");
                };
                messageElement = messageElement.replace(regExpURL, "$({url,$&})$");
                userPrefix = "";
                if (usernameElement == "SERVER")
                {
                    userPrefix = "";
                }
                else
                {
                    if (usernameElement != null)
                    {
                        userPrefix = ((Game.isRuffle()) ? (usernameElement + ": ") : ((((openTag + "user,") + usernameElement) + closeTag) + ": "));
                    };
                };
                if (channelElement != "whisper")
                {
                    if (channelElement != "event")
                    {
                        xColor = usernameColor;
                        isRainbow = false;
                        if (usernameElement != "SERVER")
                        {
                            avatarChat = ((channel == "npc") ? this.game.world.getNpcAvatarByUserName(usernameElement.toLowerCase()) : this.game.world.getAvatarByUserName(usernameElement.toLowerCase()));
                            if (((!(avatarChat == null)) && (!(avatarChat.objData == null))))
                            {
                                if (((((((!(channelElement == null)) && (!(channelElement == "warning"))) && (!(channelElement == "server"))) && (!(channelElement == "game"))) && (!(channelElement == "event"))) && (!(channelElement == "wheel"))))
                                {
                                    chatColor = avatarChat.objData.strChatColor;
                                    switch (chatColor)
                                    {
                                        case "000001":
                                        case "1":
                                            chatColor = xColor;
                                            break;
                                        case "000002":
                                        case "2":
                                            isRainbow = true;
                                            break;
                                        default:
                                            chatColor = Hex2Color(chatColor);
                                    };
                                }
                                else
                                {
                                    switch (channelElement)
                                    {
                                        case "guild":
                                        case "world":
                                            chatColor = xColor;
                                            break;
                                        default:
                                            chatColor = "9CCAFD";
                                    };
                                };
                            }
                            else
                            {
                                if (channelElement != "serverevent")
                                {
                                    chatColor = xColor;
                                };
                            };
                        }
                        else
                        {
                            chatColor = xColor;
                        };
                        messageElement = messageElement.split("#037:").join("%");
                        if (isRainbow)
                        {
                            this.html2Fields((((((" " + timestampContent) + tagContent) + userPrefix) + rainbowMessage(messageElement)) + "<br>"), "+=", channelElement, sixthElement);
                        }
                        else
                        {
                            this.html2Fields((((((((((" " + timestampContent) + tagContent) + userPrefix) + fontColorStart) + chatColor) + fontColorEnd) + messageElement) + fontColorClose) + "<br>"), "+=", channelElement, sixthElement);
                        };
                    }
                    else
                    {
                        this.html2Fields((((((((((((((((fontColorStart + "CCCCCC") + fontColorEnd) + "*") + fontColorStart) + "FFFFFF") + fontColorEnd) + usernameElement) + fontColorClose) + fontColorStart) + "CCCCCC") + fontColorEnd) + " ") + messageElement) + fontColorClose) + "*<br>"), "+=", channelElement, sixthElement);
                    };
                }
                else
                {
                    if (usernameElement.toLowerCase() == this.game.network.myUserName.toLowerCase())
                    {
                        if (isReceivingElement == 0)
                        {
                            this.html2Fields((((((((timestampContent + fontColorStart) + this.chn[channelElement].col) + '">From ') + userPrefix) + messageElement) + fontColorClose) + "</font><br>"), "+=", channelElement, sixthElement);
                        }
                        else
                        {
                            this.html2Fields((((((((((timestampContent + fontColorStart) + this.game.modColor(this.chn[channelElement].col, "666666", "-")) + fontColorEnd) + "To ") + targetElement) + ": ") + messageElement) + fontColorClose) + "</font><br>"), "+=", channelElement, sixthElement);
                        };
                    }
                    else
                    {
                        this.html2Fields(((((((fontColorStart + this.chn[channelElement].col) + '">From ') + userPrefix) + messageElement) + fontColorClose) + "</font><br>"), "+=", channelElement, sixthElement);
                    };
                };
                i1++;
            };
            this.setFieldsVPos();
            this.writeText(this.panelIndex);
            this.msgID++;
            if (whisper)
            {
                this.pushMsg("warning", (("<font color='#FFFFFF'>" + username) + "</font> IS NOT A MODERATOR.  DO NOT GIVE ACCOUNT INFORMATION TO OTHER PLAYERS."), "SERVER", "", 0);
            };
        }

        public function isIgnored(_arg1:String):Boolean
        {
            return ((this.ignoreList.data.users == undefined) ? false : (this.ignoreList.data.users.indexOf(_arg1.toLowerCase()) >= 0));
        }

        public function ignore(strName:String):void
        {
            var avatar:Avatar;
            if (this.ignoreList.data.users.indexOf(strName.toLowerCase()) == -1)
            {
                this.ignoreList.data.users.push(strName.toLowerCase());
                try
                {
                    this.ignoreList.flush();
                }
                catch(e:Error)
                {
                };
                avatar = this.game.world.getAvatarByUserName(strName.toLowerCase());
                if (avatar != null)
                {
                    avatar.pMC.ignore.visible = true;
                };
                this.game.network.send("cmd", ["ignoreList", this.ignoreList.data.users]);
            };
            try
            {
                if (this.game.ui.mcOFrame.fData.typ == "userListIgnore")
                {
                    this.game.ui.mcOFrame.update();
                };
            }
            catch(e:Error)
            {
            };
        }

        public function unignore(strName:String):void
        {
            var uind:* = this.ignoreList.data.users.indexOf(strName.toLowerCase());
            while (uind > -1)
            {
                this.ignoreList.data.users.splice(uind, 1);
                uind = this.ignoreList.data.users.indexOf(strName.toLowerCase());
            };
            try
            {
                this.ignoreList.flush();
            }
            catch(e:Error)
            {
            };
            var avatar:Avatar = this.game.world.getAvatarByUserName(strName.toLowerCase());
            if (avatar != null)
            {
                avatar.pMC.ignore.visible = false;
            };
            this.game.network.send("cmd", ["ignoreList", this.ignoreList.data.users]);
            try
            {
                if (this.game.ui.mcOFrame.fData.typ == "userListIgnore")
                {
                    this.game.ui.mcOFrame.update();
                };
            }
            catch(e:Error)
            {
            };
        }

        public function muteMe(dur:int):void
        {
            this.mute.ts = Number(new Date().getTime());
            this.mute.cd = dur;
            this.mute.timer.delay = dur;
            this.mute.timer.start();
            this.muteData.data.ts = this.mute.ts;
            this.muteData.data.cd = this.mute.cd;
            try
            {
                this.muteData.flush();
            }
            catch(e:Error)
            {
            };
            this.pushMsg("warning", "You have been muted! Chat privileges are temporarily revoked.", "SERVER", "", 0);
        }

        public function amIMute():Boolean
        {
            var currentTime:Number;
            if (this.mute.ts > 0)
            {
                currentTime = new Date().getTime();
                if ((currentTime - this.mute.ts) >= this.mute.cd)
                {
                    this.mute.ts = 0;
                    this.mute.cd = 0;
                }
                else
                {
                    return (true);
                };
            };
            return (false);
        }

        public function openMsgEntry():void
        {
            this.pmI = 0;
            this.myMsgsI = 0;
            this.game.ui.mcInterface.tebg.addEventListener(MouseEvent.CLICK, this.chat_tebgClick);
            this.game.ui.mcInterface.te.visible = true;
            this.game.ui.mcInterface.te.type = TextFieldType.INPUT;
            this.game.stage.focus = null;
            this.game.stage.focus = this.game.ui.mcInterface.te;
            this.game.world.chatFocus = this.game.ui.mcInterface.te;
            this.formatMsgEntry(this.pmNm);
            this.updateMsgEntry();
        }

        public function openPMsg(username:String):void
        {
            this.pmNm = username;
            this.chn.cur = this.chn.whisper;
            this.openMsgEntry();
        }

        public function closeMsgEntry():void
        {
            this.game.ui.mcInterface.tebg.addEventListener(MouseEvent.CLICK, this.chat_tebgClick);
            this.game.ui.mcInterface.te.htmlText = "";
            this.game.ui.mcInterface.te.text = "";
            this.game.ui.mcInterface.tt.text = "";
            this.game.ui.mcInterface.te.visible = false;
            this.game.ui.mcInterface.tt.visible = false;
            if (this.pmMode != 2)
            {
                this.chn.cur = this.chn.lastPublic;
            };
            this.game.ui.mcInterface.te.type = TextFieldType.DYNAMIC;
            this.game.stage.focus = null;
        }

        public function getJsonCannedChatMenu():*
        {
            return (jsonCannedOptions.CannedChat.menu);
        }

        public function removeFromCannedChat(menu:Object, display:String):Boolean
        {
            var history:Object;
            for each (history in menu)
            {
                if (history.display == display)
                {
                    menu.removeAt(menu.indexOf(history));
                    return (true);
                };
            };
            return (false);
        }

        public function addToCannedChat(data:Object, menu:Object):void
        {
            var submenu:Object;
            for each (submenu in menu)
            {
                if (((!(data.parent == null)) && (submenu.display == data.parent)))
                {
                    switch (submenu.display)
                    {
                        case "History":
                            this.removeFromCannedChat(submenu.menu, "No History");
                            break;
                    };
                    if (submenu.menu != null)
                    {
                        this.addToCannedChat(data, submenu.menu);
                        return;
                    };
                };
                if (submenu.display == data.id)
                {
                    switch (submenu.display)
                    {
                        case "Alliance Chat":
                            this.removeFromCannedChat(submenu.menu, "No Alliance");
                            break;
                    };
                    if (!this.removeFromCannedChat(submenu.menu, data.display))
                    {
                        if (submenu.menu.length >= 9)
                        {
                            submenu.menu.removeAt(9);
                        };
                    };
                    submenu.menu.push(data);
                    this.buildCannedChat();
                    return;
                };
            };
            menu.push({
                "menu":[data],
                "display":data.id
            });
            this.buildCannedChat();
        }

        public function chatSend():void
        {
            var chatText:String = this.game.ui.mcInterface.te.htmlText;
            chatText = chatText.replace(regExpLinking1, "$1");
            chatText = chatText.replace(regExpLinking2, "$1");
            chatText = chatText.replace(regExpLinking3, '<A HREF="$1">$2</A>');
            this.submitMsg(chatText, this.chn.cur.typ, this.pmNm);
            this.game.stage.focus = null;
        }

        private function popBubble(identifier:String, message:*):void
        {
            var character:* = null;
            var _local_4:* = identifier.split(":")[0];
            identifier = identifier.substr(2);
            switch (_local_4)
            {
                case "u":
                    character = Game.root.world.getMCByUserName(identifier);
                    break;
            };
            if (character != null)
            {
                character.bubble.ti.autoSize = TextFieldAutoSize.CENTER;
                character.bubble.ti.wordWrap = true;
                character.bubble.ti.htmlText = message;
                character.bubble.bg.width = int((character.bubble.ti.textWidth + 12));
                character.bubble.bg.height = int((character.bubble.ti.textHeight + 8));
                character.bubble.y = ((character.pname.y - character.bubble.bg.height) - 4);
                character.bubble.bg.x = (-(character.bubble.bg.width) / 2);
                character.bubble.arrow.y = ((character.bubble.bg.y + character.bubble.bg.height) - 2);
                character.bubble.visible = true;
                character.bubble.alpha = 100;
                if (character.kv == null)
                {
                    character.kv = new Killvis();
                    character.kv.kill(character.bubble, 3000);
                }
                else
                {
                    character.kv.resetkill();
                };
            };
        }

        private function initCannedChat(menu:Object):MovieClip
        {
            var submenu:Object;
            var cannedOption:CannedOption;
            var textDisplay:Object;
            var subMenuMC:CannedOption;
            var displayMC:MovieClip = new MovieClip();
            var textWidth:Number = 0;
            var counter:int;
            for each (submenu in menu)
            {
                cannedOption = CannedOption(displayMC.addChild(new CannedOption()));
                cannedOption.y = (counter * 23);
                cannedOption.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
                cannedOption.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
                textDisplay = submenu.display;
                if (textDisplay.indexOf("loadItem") > 0)
                {
                    textDisplay = textDisplay.replace(regExpLinking2, "$1").replace(/<\s*A HREF="(.*?)">&lt;(.*?)&gt;<\s*\/A\s*>/ig, "$({item,$2,$1})$");
                };
                cannedOption.txtChat.htmlText = textDisplay;
                formatWithoutTextLinks(cannedOption.txtChat);
                cannedOption.txtChat.mouseEnabled = false;
                if (cannedOption.txtChat.textWidth > textWidth)
                {
                    textWidth = cannedOption.txtChat.textWidth;
                };
                cannedOption.strMsg = submenu.text;
                cannedOption.id = submenu.id;
                if (submenu.menu != null)
                {
                    cannedOption.mcMoreOptions = this.initCannedChat(submenu.menu);
                    cannedOption.addChild(cannedOption.mcMoreOptions);
                    cannedOption.mcMoreOptions.visible = false;
                    if (cannedOption.txtChat.text.length > 17)
                    {
                    };
                }
                else
                {
                    cannedOption.mcMore.visible = false;
                    cannedOption.addEventListener(MouseEvent.CLICK, this.onMouseClick);
                };
                counter++;
            };
            counter = 0;
            while (counter < displayMC.numChildren)
            {
                subMenuMC = CannedOption(displayMC.getChildAt(counter));
                subMenuMC.txtChat.width = (textWidth + 6);
                subMenuMC.bg.width = (textWidth + 20);
                subMenuMC.mcMore.x = (subMenuMC.bg.width - 10);
                if (subMenuMC.mcMoreOptions != null)
                {
                    subMenuMC.mcMoreOptions.x = subMenuMC.bg.width;
                };
                counter++;
            };
            return (displayMC);
        }

        private function checkFieldsVPos():void
        {
            this.game.ui.mcInterface.t1.resetVPos = 0;
            if (this.panelIndex == (this.t1Arr.length - 1))
            {
                this.game.ui.mcInterface.t1.resetVPos = 1;
            };
        }

        private function setFieldsVPos():void
        {
            if (this.game.ui.mcInterface.t1.resetVPos)
            {
                this.panelIndex = (this.t1Arr.length - 1);
            };
            this.panelIndex = Math.min(this.panelIndex, (this.t1Arr.length - 1));
        }

        private function html2Fields(html:String, _type:String, channel:String, id:int):void
        {
            switch (_type)
            {
                case "=":
                default:
                    this.t1Arr = [{
                        "s":html,
                        "id":id
                    }];
                    return;
                case "+=":
                    this.t1Arr.push({
                        "s":html,
                        "id":id
                    });
            };
        }

        private function checkPos(movieClip:MovieClip, _arg2:int, _arg3:int, panelIndex:int):int
        {
            var bitmap:DisplayObject = getBitmapByIndex((_arg3 + 1), this.game.ui.mcInterface.t1);
            var offset:int = ((Game.isRuffle()) ? 16 : 2);
            return (((!(bitmap == null)) && (_arg2 < panelIndex)) ? ((bitmap.y - movieClip.height) + offset) : Math.round((this.tfHeight - movieClip.height)));
        }

        private function buildTextLinks(_arg1:TextField, _arg2:String, _arg3:MovieClip, _arg4:Array, _arg5:int):DisplayObject
        {
            var _local21:String;
            var _local22:String;
            var _local23:Object;
            var _local24:* = undefined;
            var _local25:* = undefined;
            var _local26:int;
            var _local27:int;
            var _local28:int;
            var _local29:* = undefined;
            var _local30:Rectangle;
            var _local31:Rectangle;
            var _local32:MovieClip;
            var _local33:* = undefined;
            var _local34:String;
            var chatLog:String;
            var chatLogOpen:String;
            var chatLogClose:String;
            var chatLogOpener:String;
            var chatLogArray:Array;
            var chatLogOption:String;
            var chatLogName:String;
            var _local13:String;
            var _local14:String;
            var _local15:String;
            var _local16:String;
            var _local17:Array;
            var _local18:String;
            var _local19:String;
            var _local20:int;
            var emojiData:String;
            var emoji:Object;
            var _local6:MovieClip = new MovieClip();
            _local6.name = ("b" + _arg5);
            _arg1.htmlText = _arg2;
            var textLine:uiTextLine = new uiTextLine();
            textLine.mouseEnabled = false;
            textLine.mouseChildren = false;
            if (Game.isRuffle())
            {
                if (((_arg1.htmlText.indexOf(Chat.openTag) > -1) && (_arg1.htmlText.indexOf(Chat.closeTag) > -1)))
                {
                    textLine.ti.addEventListener("link", this.onTextFieldLink);
                    textLine.mouseEnabled = true;
                    textLine.mouseChildren = true;
                };
                while (((_arg1.htmlText.indexOf(Chat.openTag) > -1) && (_arg1.htmlText.indexOf(Chat.closeTag) > -1)))
                {
                    chatLog = _arg1.htmlText;
                    chatLogOpen = chatLog.substr(0, chatLog.indexOf(Chat.openTag));
                    chatLogClose = chatLog.substr((chatLog.indexOf(Chat.closeTag) + Chat.closeTag.length));
                    chatLogOpener = chatLog.substr((chatLog.indexOf(Chat.openTag) + Chat.openTag.length));
                    chatLogArray = chatLogOpener.substr(0, chatLogOpener.indexOf(Chat.closeTag)).split(",");
                    chatLogOption = chatLogArray[0];
                    chatLogName = chatLogArray[1].split("&amp;").join("&");
                    switch (chatLogOption)
                    {
                        case "url":
                            _arg1.htmlText = ((((((((((chatLogOpen + Chat.fontColorStart) + "FFFF99") + Chat.fontColorEnd) + "<u><a href='event:loadUrl:") + chatLogName) + "'>") + chatLogName) + "</a></u>") + Chat.fontColorClose) + chatLogClose);
                            break;
                        case "item":
                            _arg1.htmlText = ((((((((((chatLogOpen + Chat.fontColorStart) + "FFFF99") + Chat.fontColorEnd) + "&lt;<a href='event:") + chatLogArray[2]) + "'>") + chatLogName) + "</a>&gt;") + Chat.fontColorClose) + chatLogClose);
                            break;
                    };
                };
            }
            else
            {
                while (((_arg1.htmlText.indexOf(openTag) > -1) && (_arg1.htmlText.indexOf(closeTag) > -1)))
                {
                    _local13 = _arg1.htmlText;
                    _local14 = _local13.substr(0, _local13.indexOf(openTag));
                    _local15 = _local13.substr((_local13.indexOf(closeTag) + closeTag.length));
                    _local16 = _local13.substr((_local13.indexOf(openTag) + openTag.length));
                    _local17 = _local16.substr(0, _local16.indexOf(closeTag)).split(",");
                    _local18 = _local17[0];
                    _local19 = _local17[1];
                    _local19 = _local19.split("&amp;").join("&");
                    _local20 = _arg1.text.indexOf(openTag);
                    _local23 = {};
                    switch (_local18)
                    {
                        case "url":
                            _local22 = _local19;
                            _local21 = ((((((fontColorStart + "FFFF99") + fontColorEnd) + "<u>") + _local22) + "</u>") + fontColorClose);
                            _local23.callback = urlClick;
                            break;
                        case "user":
                            _local22 = _local19;
                            _local21 = ((((fontColorStart + "FFFFFF") + fontColorEnd) + _local22) + fontColorClose);
                            _local23.callback = this.pmClick;
                            break;
                        case "item":
                            _local22 = _local19;
                            _local21 = ((((((fontColorStart + "FFFF99") + fontColorEnd) + "&lt;") + _local22) + "&gt;") + fontColorClose);
                            _local22 = (("<" + _local19) + ">");
                            _local22 = _local22.replace(/&apos;/g, "'");
                            _local19 = _local17[2];
                            _local23.callback = linkClick;
                            break;
                        case "quest":
                            _local23.sName = _local17[1];
                            _local23.QuestID = _local17[2];
                            _local23.iLvl = _local17[3];
                            _local23.unm = _local17[4];
                            _local22 = (("[" + _local19) + "]");
                            _local21 = ((((fontColorStart + "00CCFF") + fontColorEnd) + _local22) + fontColorClose);
                            _local23.callback = this.game.world.doCTAClick;
                            break;
                        case "emoji":
                            _local21 = "      ";
                            _local22 = "      ";
                            _local23.callback = linkClick;
                            break;
                    };
                    _arg1.htmlText = ((_local14 + _local21) + _local15);
                    _local24 = _local20;
                    _local25 = ((_local20 + _local22.length) - 1);
                    _local26 = _arg1.getLineIndexOfChar(_local24);
                    _local27 = _arg1.getLineIndexOfChar(_local25);
                    _local28 = _local26;
                    while (_local28 <= _local27)
                    {
                        try
                        {
                            if (_local28 == _local26)
                            {
                                _local29 = _arg1.getCharBoundaries(_local24);
                            }
                            else
                            {
                                _local29 = _arg1.getCharBoundaries(_arg1.getLineOffset(_local28));
                            };
                            if (_local28 == _local27)
                            {
                                _local30 = _arg1.getCharBoundaries(_local25);
                            }
                            else
                            {
                                _local30 = _arg1.getCharBoundaries((_arg1.getLineOffset((_local28 + 1)) - 1));
                            };
                        }
                        catch(e:Error)
                        {
                            Game.consoleLog(("Error: " + e));
                        };
                        _local31 = new Rectangle(_local29.x, _local29.y, ((_local30.x - _local29.x) + _local30.width), ((_local30.y - _local29.y) + _local30.height));
                        _local32 = new MovieClip();
                        _local32.graphics.beginFill(52479);
                        _local32.graphics.drawRect(0, 0, _local31.width, _local31.height);
                        _local32.graphics.endFill();
                        _local33 = _local6.addChild(_local32);
                        _local33.alpha = 0;
                        _local33.x = (_arg1.x + _local29.x);
                        _local33.y = (_arg1.y + _local29.y);
                        switch (_local18)
                        {
                            case "emoji":
                                emojiData = _local17[2].replace(/emoji:/g, "");
                                emoji = Game.root.world.emojiTree[emojiData];
                                ((function (local33:Sprite, _local6:Sprite, point:Point, emoji:Object):*
                                {
                                    EmojiMC.load(emoji, function (event:Event):void
                                    {
                                        var container:* = undefined;
                                        var containerScaleX:* = undefined;
                                        var containerScaleY:* = undefined;
                                        EmojiMC.emojiCache[emoji.File] = true;
                                        container = EmojiMC.display(point, emoji, 18, 18);
                                        _local6.addChild(container);
                                        containerScaleX = container.scaleX;
                                        containerScaleY = container.scaleY;
                                        container.addEventListener(MouseEvent.MOUSE_OVER, function (event:MouseEvent):void
                                        {
                                            var targetScale:* = "";
                                            container.parent.setChildIndex(container, (container.parent.numChildren - 1));
                                            var originalX:* = container.x;
                                            var originalY:* = container.y;
                                            targetScale = 0.11;
                                            var scaleFactor:* = (targetScale / container.scaleX);
                                            container.x = (container.x - ((container.width * (scaleFactor - 1)) / 2));
                                            container.y = (container.y - ((container.height * (scaleFactor - 1)) / 2));
                                            container.scaleX = targetScale;
                                            container.scaleY = targetScale;
                                            game.ui.ToolTip.openWith({"str":(((emoji.Name + " (") + emoji.Command) + ")")});
                                        });
                                        container.addEventListener(MouseEvent.MOUSE_OUT, function (event:MouseEvent):void
                                        {
                                            container.scaleX = containerScaleX;
                                            container.scaleY = containerScaleY;
                                            container.x = point.x;
                                            container.y = point.y;
                                            game.ui.ToolTip.close();
                                        });
                                    });
                                })(_local33, _local6, new Point(_local33.x, _local33.y), emoji));
                                this.game.ui.mcInterface.textLine.ti.htmlText.replace((((("$({emoji," + emoji.Command) + ",emoji:") + emoji.id) + "})$"), "");
                                break;
                        };
                        for (_local34 in _local23)
                        {
                            if (_local34 != "callback")
                            {
                                _local33[_local34] = _local23[_local34];
                            };
                        };
                        _local33.str = _local19;
                        _local33.buttonMode = true;
                        _local33.addEventListener(MouseEvent.CLICK, _local23.callback, false, 0, true);
                        _local28 = (_local28 + 1);
                    };
                };
            };
            textLine.ti.htmlText = this.game.ui.mcInterface.textLine.ti.htmlText;
            textLine.ti.autoSize = "left";
            textLine.ti.multiline = true;
            textLine.name = "bmp";
            if (_local6.numChildren > 0)
            {
                _local6.swapChildren(_local6.getChildAt(0), _local6.addChildAt(textLine, 0));
            }
            else
            {
                _local6.addChild(textLine);
            };
            _arg4.push(_arg5);
            return (_arg3.addChild(_local6));
        }

        private function getCharBoundariesApprox(textField:TextField, charIndex:int):Rectangle
        {
            var charBoundaries:Rectangle;
            if (((charIndex < 0) || (charIndex >= textField.length)))
            {
                return (new Rectangle(0, 0, 0, 0));
            };
            var lineIndex:int = textField.getLineIndexOfChar(charIndex);
            var lineMetrics:TextLineMetrics = textField.getLineMetrics(lineIndex);
            var xPosition:int;
            var i:int;
            while (i < charIndex)
            {
                charBoundaries = textField.getCharBoundaries(i);
                if (charBoundaries)
                {
                    xPosition = (xPosition + charBoundaries.width);
                };
                i++;
            };
            var yPosition:Number = lineMetrics.ascent;
            var charWidthAtIndex:Number = 0;
            var charBoundariesAtIndex:Rectangle = textField.getCharBoundaries(charIndex);
            if (charBoundariesAtIndex)
            {
                charWidthAtIndex = (charBoundariesAtIndex.width * 5);
            };
            Game.consoleLog(("xPosition: " + xPosition));
            Game.consoleLog(("yPosition: " + yPosition));
            Game.consoleLog(("charWidthAtIndex: " + charWidthAtIndex));
            return (new Rectangle(xPosition, yPosition, charWidthAtIndex, lineMetrics.height));
        }

        private function buildCannedChat():void
        {
            if (((!(this.mcCannedChat == null)) && (this.game.ui.mcInterface.contains(this.mcCannedChat))))
            {
                this.game.ui.mcInterface.removeChild(this.mcCannedChat);
            };
            this.mcCannedChat = this.initCannedChat(jsonCannedOptions.CannedChat.menu);
            this.game.ui.mcInterface.addChild(this.mcCannedChat);
            this.mcCannedChat.addEventListener(MouseEvent.MOUSE_OVER, onCannedChatOver);
            this.mcCannedChat.addEventListener(MouseEvent.MOUSE_OUT, onCannedChatOut);
            this.mcCannedChat.y = (-(this.mcCannedChat.numChildren) * 23);
            this.mcCannedChat.visible = false;
        }

        private function handleSlashCommand(inputParts:Array, command:String, remainder:String):void
        {
            switch (command)
            {
                case "1":
                case "s":
                case "say":
                    if (((!([3, 4, 5, 6].indexOf(this.mode) == -1)) && (!(this.game.ui.mcInterface.chatLog.btnAll == null))))
                    {
                        this.game.ui.mcInterface.chatLog.btnAll.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                    if (this.chn.zone.act)
                    {
                        this.chn.cur = this.chn.zone;
                        this.chn.lastPublic = this.chn.zone;
                        this.game.ui.mcInterface.te.text = remainder;
                    };
                    this.formatMsgEntry("");
                    this.updateMsgEntry();
                    break;
                case "p":
                    if (((!([3, 5, 6].indexOf(this.mode) == -1)) && (!(this.game.ui.mcInterface.chatLog.btnParty == null))))
                    {
                        this.game.ui.mcInterface.chatLog.btnParty.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                    if (this.chn.party.act)
                    {
                        this.chn.cur = this.chn.party;
                        this.chn.lastPublic = this.chn.party;
                        this.game.ui.mcInterface.te.text = remainder.substr(2);
                    };
                    this.formatMsgEntry("");
                    this.updateMsgEntry();
                    break;
                case "r":
                    if (this.pmSourceA.length)
                    {
                        this.pmMode = 1;
                        this.chn.cur = this.chn.whisper;
                        this.game.ui.mcInterface.te.text = remainder.substr(2);
                        this.formatMsgEntry(this.pmSourceA[0]);
                        this.updateMsgEntry();
                    };
                    break;
                case "tell":
                case "w":
                    if (inputParts.length > 2)
                    {
                        this.pmMode = 1;
                        this.chn.cur = this.chn.whisper;
                        this.game.ui.mcInterface.te.text = remainder.substr(((inputParts[0].length + inputParts[1].length) + 1));
                        this.formatMsgEntry(inputParts[1]);
                        this.updateMsgEntry();
                    };
                    break;
                case "c":
                    this.pmMode = 2;
                    this.chn.cur = this.chn.whisper;
                    this.game.ui.mcInterface.te.text = remainder.substr(((inputParts[0].length + inputParts[1].length) + 1));
                    this.formatMsgEntry(this.pmSourceA[0]);
                    this.updateMsgEntry();
                    break;
                case "g":
                    if (((!([3, 4, 6].indexOf(this.mode) == -1)) && (!(this.game.ui.mcInterface.chatLog.btnGuild == null))))
                    {
                        this.game.ui.mcInterface.chatLog.btnGuild.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                    if (this.chn.guild.act)
                    {
                        this.chn.cur = this.chn.guild;
                        this.chn.lastPublic = this.chn.guild;
                        this.game.ui.mcInterface.te.text = remainder.substr(2);
                    };
                    this.formatMsgEntry("");
                    this.updateMsgEntry();
                    break;
                case "world":
                    if (((!([2, 4, 5, 6].indexOf(this.mode) == -1)) && (!(this.game.ui.mcInterface.chatLog.btnWorld == null))))
                    {
                        this.game.ui.mcInterface.chatLog.btnWorld.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                    this.chn.cur = this.chn.world;
                    this.chn.lastPublic = this.chn.world;
                    this.game.ui.mcInterface.te.text = remainder.substr(6);
                    this.formatMsgEntry("");
                    this.updateMsgEntry();
                    break;
            };
        }

        public function bShortTallClick(mouseEvent:MouseEvent):void
        {
            var shortTall:MovieClip = this.game.ui.mcInterface.bShortTall;
            if (this.game.ui.mcInterface.t1.y == t1Tally)
            {
                this.game.ui.mcInterface.t1.y = t1Shorty;
                this.tfHeight = (this.tfHeight - this.tfdH);
                shortTall.a1.visible = true;
                shortTall.a2.visible = false;
                this.game.ui.ToolTip.openWith({"str":"Set the chat pane to full height"});
            }
            else
            {
                this.game.ui.mcInterface.t1.y = t1Tally;
                this.tfHeight = (this.tfHeight + this.tfdH);
                shortTall.a1.visible = false;
                shortTall.a2.visible = true;
                this.game.ui.ToolTip.openWith({"str":"Return the chat pane to normal height"});
            };
            this.writeText(this.panelIndex);
        }

        public function unmuteMe(event:Event=null):void
        {
            this.mute.ts = 0;
            this.mute.cd = 0;
            this.muteData.clear();
            this.mute.timer.reset();
            this.pushMsg("server", "You have been unmuted. Chat privileges are restored.", "SERVER", "", 0);
        }

        private function onMouseWheelEvent(mouseEvent:MouseEvent):void
        {
            if (this.game.ui.mcInterface.t1.hitTestPoint(mouseEvent.stageX, mouseEvent.stageY))
            {
                if (mouseEvent.delta > 0)
                {
                    if (this.panelIndex > 0)
                    {
                        this.panelIndex--;
                    };
                }
                else
                {
                    if (this.panelIndex < (this.t1Arr.length - 1))
                    {
                        this.panelIndex++;
                    };
                };
                this.writeText(this.panelIndex);
            };
        }

        private function bShowChatMouseOut(mouseEvent:MouseEvent):void
        {
            this.game.closeToolTip();
        }

        private function bShowChatClick(mouseEvent:MouseEvent):void
        {
            this.toggleChatWindow();
        }

        private function bShowChatMouseOver(_arg1:MouseEvent):void
        {
            if (!this.game.chatSession.shown())
            {
                this.game.ui.ToolTip.openWith({"str":"Show the chat window"});
                return;
            };
            this.game.ui.ToolTip.openWith({"str":"Hide the chat window"});
        }

        private function bMinMaxMouseOut(mouseEvent:MouseEvent):void
        {
            this.game.closeToolTip();
        }

        private function bMinMaxClick(mouseEvent:MouseEvent):void
        {
            this.toggleChatPane();
        }

        private function bShortTallMouseOut(mouseEvent:MouseEvent):void
        {
            this.game.closeToolTip();
        }

        private function onCannedChatClick(mouseEvent:MouseEvent):void
        {
            this.mcCannedChat.visible = (!(this.mcCannedChat.visible));
        }

        private function onRollOver(event:MouseEvent):void
        {
            var cannedHeight:int;
            var parentHeight:int;
            var point:Point;
            var cannedOption:CannedOption = CannedOption(event.currentTarget);
            cannedOption.bg.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 25, 25, 25, 0);
            if (cannedOption.mcMoreOptions != null)
            {
                cannedOption.mcMoreOptions.visible = true;
                cannedHeight = (cannedOption.mcMoreOptions.numChildren * 23);
                parentHeight = ((cannedOption.parent.numChildren - cannedOption.numChildren) * 23);
                point = this.mcCannedChat.localToGlobal(new Point(cannedOption.x, ((cannedOption.y + cannedOption.mcMoreOptions.y) + (cannedHeight - parentHeight))));
                if (point.y > 478)
                {
                    cannedOption.mcMoreOptions.y = (cannedOption.mcMoreOptions.y - (point.y - 478));
                };
            };
        }

        private function onMouseClick(mouseEvent:MouseEvent):void
        {
            var menu:MovieClip = MovieClip(mouseEvent.currentTarget);
            switch (menu.id)
            {
                case "Emote History":
                case "emote":
                    this.submitMsg(("/" + menu.strMsg), "emote", this.game.network.myUserName);
                    break;
                case "Join History":
                    this.game.world.gotoTown(menu.strMsg, "Enter", "Spawn");
                    break;
                case "Chat History":
                    this.game.network.send("message", menu.strMsg);
                    break;
                case "Command History":
                    switch (menu.strMsg[0])
                    {
                        case "duel":
                            this.game.world.sendDuelInvite(menu.strMsg[1]);
                            break;
                        case "invite":
                            this.game.world.partyController.partyInvite(menu.strMsg[1]);
                            break;
                    };
                    break;
                case "Alliance Chat":
                    this.pmMode = 1;
                    this.chn.cur = this.chn.alliance;
                    this.formatMsgEntry(menu.strMsg[1]);
                    this.updateMsgEntry();
                    break;
                default:
                    this.game.network.send("cc", [menu.id]);
            };
            this.closeCannedChat();
        }

        private function closeCannedChatTimer(_arg1:TimerEvent):void
        {
            this.closeCannedChat();
        }

        private function timedWindowHide(_arg1:Event):void
        {
            this.game.ui.mcInterface.t1.visible = false;
        }

        private function bMinMaxMouseOver(_arg1:MouseEvent):void
        {
            if (!this.game.ui.mcInterface.t1.visible)
            {
                this.game.ui.ToolTip.openWith({"str":"Show the chat pane"});
                return;
            };
            this.game.ui.ToolTip.openWith({"str":"Hide the chat pane"});
        }

        private function bShortTallMouseOver(_arg1:MouseEvent):void
        {
            if (this.game.ui.mcInterface.t1.y == t1Shorty)
            {
                this.game.ui.ToolTip.openWith({"str":"Set the chat pane to full height"});
                return;
            };
            this.game.ui.ToolTip.openWith({"str":"Return the chat pane to normal height"});
        }

        private function chat_btnSend(_arg1:MouseEvent):void
        {
            this.chatSend();
        }

        private function chat_tebgClick(_arg1:MouseEvent):void
        {
            if (this.game.stage.focus != this.game.ui.mcInterface.te)
            {
                this.openMsgEntry();
            };
        }

        private function pmClick(mouseEvent:MouseEvent):void
        {
            if (mouseEvent.shiftKey)
            {
                this.openPMsg(MovieClip(mouseEvent.currentTarget).str);
                return;
            };
            this.game.world.onWalkClick();
        }

        private function checkMsgType(event:Event):void
        {
            var input:String;
            var command:String;
            var remainder:String;
            var separatorIndex:int;
            var lessThanIndex:int;
            var messageParts:Array;
            input = this.game.ui.mcInterface.te.text;
            var inputParts:Array = input.split(" ");
            if (inputParts.length > 1)
            {
                command = inputParts[0];
                remainder = input.substr((command.length + 1));
                switch (command.charAt(0))
                {
                    case "/":
                        this.handleSlashCommand(inputParts, command.substr(1), remainder);
                        break;
                    case ">":
                        if (this.pmSourceA.length)
                        {
                            this.pmMode = 1;
                            this.chn.cur = this.chn.whisper;
                            this.game.ui.mcInterface.te.text = remainder.substr(1);
                            this.formatMsgEntry(this.pmSourceA[0]);
                            this.updateMsgEntry();
                        };
                        break;
                    default:
                        separatorIndex = input.indexOf(" > ");
                        lessThanIndex = input.indexOf("<");
                        if (((separatorIndex > 1) && ((lessThanIndex == -1) || (separatorIndex < lessThanIndex))))
                        {
                            messageParts = input.split(" > ");
                            while (messageParts[0].charAt((messageParts[0].length - 1)) == " ")
                            {
                                messageParts[0] = messageParts[0].substr(0, (messageParts[0].length - 1));
                            };
                            this.pmMode = 1;
                            this.chn.cur = this.chn.whisper;
                            this.game.ui.mcInterface.te.text = messageParts[1];
                            this.formatMsgEntry(messageParts[0]);
                            this.updateMsgEntry();
                        };
                };
            };
        }

        private function onTextFieldLink(textEvent:TextEvent):void
        {
            var eventArray:Array = textEvent.text.split(":");
            switch (eventArray[0])
            {
                case "loadItem":
                    LPFLayoutChatItemPreview.linkItem(this.game.world.linkTree[eventArray[1]]);
                    break;
                case "loadUrl":
                    navigateToURL(new URLRequest(textEvent.text.split("loadUrl:")[1]), "_blank");
                    break;
                default:
                    this.game.world.onWalkClick();
            };
        }


    }
}//package 

// _SafeStr_1 = "goto" (String#9350)


