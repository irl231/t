// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mcSkel

package 
{
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.display.*;
    import Main.*;

    public class mcSkel extends MovieClip 
    {

        public var idlefoot:MovieClip;
        public var chest:MovieClip;
        public var weaponOff:MovieClip;
        public var frontthigh:MovieClip;
        public var cape:MovieClip;
        public var frontshoulder:MovieClip;
        public var weaponFistOff:MovieClip;
        public var hitbox:MovieClip;
        public var head:MovieClip;
        public var backshoulder:MovieClip;
        public var hip:MovieClip;
        public var backthigh:MovieClip;
        public var backhair:MovieClip;
        public var weaponFist:MovieClip;
        public var backshin:MovieClip;
        public var weaponTemp:MovieClip;
        public var robe:MovieClip;
        public var pvpFlag:MovieClip;
        public var weapon:MovieClip;
        public var frontshin:MovieClip;
        public var backfoot:MovieClip;
        public var backrobe:MovieClip;
        public var arrow:MovieClip;
        public var emoteFX:MovieClip;
        public var shield:MovieClip;
        public var frontfoot:MovieClip;
        public var backhand:MovieClip;
        public var fronthand:MovieClip;
        public var animLoop:int;
        public var avtMC:AvatarMC;
        public var projClass:Class;
        public var projMC:MovieClip;
        public var sp:Point;
        public var ep:Point;
        public var cloud:MovieClip;
        public var onMove:Boolean = false;

        public function mcSkel()
        {
            addFrameScript(0, this.frame1, 7, this.frame8, 8, this.frame9, 16, this.frame17, 20, this.frame21, 27, this.frame28, 32, this.frame33, 40, this.frame41, 45, this.frame46, 53, this.frame54, 67, this.frame68, 68, this.frame69, 71, this.frame72, 84, this.frame85, 85, this.frame86, 92, this.frame93, 98, this.frame99, 99, this.frame100, 116, this.frame117, 117, this.frame118, 130, this.frame131, 131, this.frame132, 155, this.frame156, 165, this.frame166, 166, this.frame167, 185, this.frame186, 186, this.frame187, 200, this.frame201, 209, this.frame210, 210, this.frame211, 244, this.frame245, 245, this.frame246, 249, this.frame250, 261, this.frame262, 262, this.frame263, 271, this.frame272, 280, this.frame281, 288, this.frame289, 289, this.frame290, 309, this.frame310, 312, this.frame313, 313, this.frame314, 345, this.frame346, 346, this.frame347, 364, this.frame365, 366, this.frame367, 367, this.frame368, 372, this.frame373, 392, this.frame393, 393, this.frame394, 457, this.frame458, 458, this.frame459, 475, this.frame476, 494, this.frame495, 502, this.frame503, 510, this.frame511, 511, this.frame512, 0x0200, this.frame513, 558, this.frame559, 559, this.frame560, 589, this.frame590, 590, this.frame591, 598, this.frame599, 599, this.frame600, 607, this.frame608, 620, this.frame621, 621, this.frame622, 632, this.frame633, 643, this.frame644, 653, this.frame654, 659, this.frame660, 677, this.frame678, 695, this.frame696, 702, this.frame703, 705, this.frame706, 721, this.frame722, 722, this.frame723, 725, this.frame726, 751, this.frame752, 752, this.frame753, 756, this.frame757, 780, this.frame781, 781, this.frame782, 785, this.frame786, 808, this.frame809, 809, this.frame810, 826, this.frame827, 827, this.frame828, 848, this.frame849, 849, this.frame850, 855, this.frame856, 856, this.frame857, 885, this.frame886, 886, this.frame887, 909, this.frame910, 910, this.frame911, 913, this.frame914, 930, this.frame931, 931, this.frame932, 934, this.frame935, 957, this.frame958, 958, this.frame959, 961, this.frame962, 983, this.frame984, 984, this.frame985, 987, this.frame988, 1001, this.frame1002, 1002, this.frame1003, 1013, this.frame1014, 1014, this.frame1015, 1017, this.frame1018, 1033, this.frame1034, 1034, this.frame1035, 1037, this.frame1038, 1048, this.frame1049, 1049, this.frame1050, 1070, this.frame1071, 1071, this.frame1072, 1082, this.frame1083, 1083, this.frame1084, 1087, this.frame1088, 1096, this.frame1097, 1097, this.frame1098, 1100, this.frame1101, 1111, this.frame1112, 1112, this.frame1113, 1121, this.frame1122, 1122, this.frame1123, 1126, this.frame1127, 1135, this.frame1136, 1136, this.frame1137, 1139, this.frame1140, 1150, this.frame1151, 1151, this.frame1152, 1162, this.frame1163, 1163, this.frame1164, 1166, this.frame1167, 1178, this.frame1179, 1179, this.frame1180, 1182, this.frame1183, 1191, this.frame1192, 1192, this.frame1193, 1203, this.frame1204, 1204, this.frame1205, 1207, this.frame1208, 1221, this.frame1222, 1222, this.frame1223, 1226, this.frame1227, 1243, this.frame1244, 1247, this.frame1248, 1253, this.frame1254, 1254, this.frame1255, 1257, this.frame1258, 1266, this.frame1267, 1267, this.frame1268, 1269, this.frame1270, 1283, this.frame1284, 1284, this.frame1285, 1295, this.frame1296, 1296, this.frame1297, 1297, this.frame1298, 1307, this.frame1308, 1319, this.frame1320, 1320, this.frame1321, 1339, this.frame1340, 1340, this.frame1341, 1354, this.frame1355, 1355, this.frame1356, 1370, this.frame1371, 1371, this.frame1372, 1404, this.frame1405, 1405, this.frame1406, 1442, this.frame1443, 1443, this.frame1444, 1451, this.frame1452, 1452, this.frame1453, 1524, this.frame1525, 1525, this.frame1526, 1562, this.frame1563, 1563, this.frame1564, 1578, this.frame1579, 1579, this.frame1580, 1588, this.frame1589, 1589, this.frame1590, 1620, this.frame1621, 1621, this.frame1622, 1624, this.frame1625, 1647, this.frame1648, 1648, this.frame1649, 1651, this.frame1652, 1673, this.frame1674, 1674, this.frame1675, 1690, this.frame1691, 1691, this.frame1692, 1704, this.frame1705, 1705, this.frame1706, 1724, this.frame1725, 1725, this.frame1726, 1766, this.frame1767, 1767, this.frame1768, 1769, this.frame1770, 1781, this.frame1782, 1782, this.frame1783, 1794, this.frame1795, 1795, this.frame1796, 1800, this.frame1801, 1818, this.frame1819, 1819, this.frame1820, 1821, this.frame1822, 1836, this.frame1837, 1850, this.frame1851, 1868, this.frame1869, 1888, this.frame1889, 1902, this.frame1903, 1931, this.frame1932, 1981, this.frame1982, 2025, this.frame2026, 2043, this.frame2044, 2076, this.frame2077, 2086, this.frame2087, 2104, this.frame2105, 2112, this.frame2113, 2126, this.frame2127, 2145, this.frame2146, 2173, this.frame2174, 2200, this.frame2201, 2210, this.frame2211, 2251, this.frame2252, 2265, this.frame2266, 2278, this.frame2279, 2293, this.frame2294, 2318, this.frame2319, 2347, this.frame2348);
            this.avtMC = AvatarMC(parent);
        }

        public function emoteLoopFrame():int
        {
            var frameCtr:int;
            while (frameCtr < currentLabels.length)
            {
                if (currentLabels[frameCtr].name == currentLabel)
                {
                    return (currentLabels[frameCtr].frame);
                };
                frameCtr++;
            };
            return (8);
        }

        public function emoteLoop(loopCount:int, isStop:Boolean=true):void
        {
            var emoteCtr:int = this.emoteLoopFrame();
            if (((emoteCtr > 8) && (++this.animLoop < loopCount)))
            {
                this.gotoAndPlay((emoteCtr + 1));
                return;
            };
            if (isStop)
            {
                this.gotoAndPlay("Idle");
            };
        }

        public function showIdleFoot():void
        {
            this.frontfoot.visible = false;
            this.idlefoot.visible = true;
        }

        public function showFrontFoot():void
        {
            this.idlefoot.visible = false;
            this.frontfoot.visible = true;
        }

        override public function gotoAndPlay(param1:Object, param2:String=null):void
        {
            var animName:String = String(param1);
            if (!this.handleAnimEvent(animName))
            {
                super.gotoAndPlay(param1);
            };
        }

        private function handleAnimEvent(animName:String):Boolean
        {
            var animEvents:Object = this.avtMC.AnimEvent;
            var animData:Array = animEvents[animName];
            if (((!(animData)) || (animData.length == 0)))
            {
                return (false);
            };
            var eventFunc:Function = animData[0];
            var playDefault:Boolean = animData[1];
            (eventFunc());
            if (animName == "Idle")
            {
                (this.robe.getChildAt(0) as MovieClip).gotoAndStop("Idleing");
                super.gotoAndPlay("Idle");
            };
            if (!playDefault)
            {
                return (true);
            };
            super.gotoAndPlay(animName);
            return (true);
        }

        private function frame1():void
        {
            this.animLoop = 0;
            this.gotoAndPlay("Idle");
        }

        private function frame8():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame54 ", e);
                };
            };
            this.avtMC.disableAnimations();
            stop();
        }

        private function frame9():void
        {
            gotoAndStop("Idle");
        }

        private function frame17():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndPlay("Move");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame17 ", e);
                };
            };
        }

        private function frame21():void
        {
            if (this.onMove)
            {
                this.gotoAndPlay("mountWalk");
            };
        }

        private function frame28():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndPlay("Move");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame28 ", e);
                };
            };
        }

        private function frame33():void
        {
            if (this.onMove)
            {
                this.gotoAndPlay("horseWalk");
            };
        }

        private function frame41():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndPlay("Move");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame41 ", e);
                };
            };
        }

        private function frame46():void
        {
            if (this.onMove)
            {
                this.gotoAndPlay("throneWalk");
            };
        }

        private function frame54():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndPlay("Move");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame54 ", e);
                };
            };
        }

        private function frame68():void
        {
            if (this.onMove)
            {
                this.gotoAndPlay("Walk");
            };
        }

        private function frame69():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame69 ", e);
                };
            };
        }

        private function frame72():void
        {
        }

        private function frame85():void
        {
            this.gotoAndPlay("Dance");
        }

        private function frame86():void
        {
            this.animLoop = 0;
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame86 ", e);
                };
            };
        }

        private function frame93():void
        {
            this.emoteLoop(3, false);
        }

        private function frame99():void
        {
            stop();
        }

        private function frame100():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame100 ", e);
                };
            };
        }

        private function frame117():void
        {
            stop();
        }

        private function frame118():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame118 ", e);
                };
            };
        }

        private function frame131():void
        {
            this.gotoAndPlay("Use");
        }

        private function frame132():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame131 ", e);
                };
            };
        }

        private function frame156():void
        {
            this.emoteLoop(3, false);
        }

        private function frame166():void
        {
            this.avtMC.endAction();
        }

        private function frame167():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame167 ", e);
                };
            };
        }

        private function frame186():void
        {
            this.avtMC.endAction();
        }

        private function frame187():void
        {
            this.animLoop = 0;
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame187 ", e);
                };
            };
        }

        private function frame201():void
        {
            this.emoteLoop(3, false);
        }

        private function frame210():void
        {
            this.avtMC.endAction();
        }

        private function frame211():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame211 ", e);
                };
            };
        }

        private function frame245():void
        {
            this.avtMC.endAction();
        }

        private function frame246():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame246 ", e);
                };
            };
        }

        private function frame250():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame262():void
        {
            this.gotoAndPlay("Airguitar");
        }

        private function frame263():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame263 ", e);
                };
            };
        }

        private function frame272():void
        {
            this.showFrontFoot();
        }

        private function frame281():void
        {
            this.showIdleFoot();
        }

        private function frame289():void
        {
            this.avtMC.endAction();
        }

        private function frame290():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame290 ", e);
                };
            };
        }

        private function frame310():void
        {
            if (scaleX < 0)
            {
                this.emoteFX.scaleX = 0;
            };
        }

        private function frame313():void
        {
            stop();
        }

        private function frame314():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame314 ", e);
                };
            };
        }

        private function frame346():void
        {
            if (this.onMove)
            {
                this.gotoAndPlay("Walk");
            };
            stop();
        }

        private function frame347():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame347 ", e);
                };
            };
        }

        private function frame365():void
        {
            this.showIdleFoot();
        }

        private function frame367():void
        {
            this.avtMC.endAction();
        }

        private function frame368():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame368 ", e);
                };
            };
        }

        private function frame373():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame393():void
        {
            this.gotoAndPlay("Dance2");
        }

        private function frame394():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame394 ", e);
                };
            };
        }

        private function frame458():void
        {
            this.gotoAndPlay("Swordplay");
        }

        private function frame459():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame458 ", e);
                };
            };
        }

        private function frame476():void
        {
            this.showFrontFoot();
        }

        private function frame495():void
        {
            stop();
        }

        private function frame503():void
        {
            this.animLoop = 0;
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame503 ", e);
                };
            };
        }

        private function frame511():void
        {
            this.emoteLoop(3);
        }

        private function frame512():void
        {
            stop();
        }

        private function frame513():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame513 ", e);
                };
            };
        }

        private function frame559():void
        {
            stop();
        }

        private function frame560():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame560 ", e);
                };
            };
        }

        private function frame590():void
        {
            stop();
        }

        private function frame591():void
        {
            this.animLoop = 0;
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame591 ", e);
                };
            };
        }

        private function frame599():void
        {
            this.emoteLoop(3);
        }

        private function frame600():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame600 ", e);
                };
            };
        }

        private function frame608():void
        {
            this.weapon.visible = true;
        }

        private function frame621():void
        {
            stop();
        }

        private function frame622():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame622 ", e);
                };
            };
        }

        private function frame633():void
        {
            stop();
        }

        private function frame644():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame654():void
        {
            this.avtMC.endAction();
        }

        private function frame660():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame678():void
        {
            this.avtMC.endAction();
        }

        private function frame696():void
        {
            this.avtMC.endAction();
        }

        private function frame703():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame703 ", e);
                };
            };
        }

        private function frame706():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame722():void
        {
            this.avtMC.endAction();
        }

        private function frame723():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame723 ", e);
                };
            };
        }

        private function frame726():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame752():void
        {
            this.avtMC.endAction();
        }

        private function frame753():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame753 ", e);
                };
            };
        }

        private function frame757():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame781():void
        {
            this.avtMC.endAction();
        }

        private function frame782():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame782 ", e);
                };
            };
        }

        private function frame786():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame809():void
        {
            this.avtMC.endAction();
        }

        private function frame810():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame810 ", e);
                };
            };
        }

        private function frame827():void
        {
            this.avtMC.endAction();
        }

        private function frame828():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame828 ", e);
                };
            };
        }

        private function frame849():void
        {
            stop();
        }

        private function frame850():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame850 ", e);
                };
            };
        }

        private function frame856():void
        {
            this.avtMC.endAction();
        }

        private function frame857():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame857 ", e);
                };
            };
        }

        private function frame886():void
        {
            this.avtMC.endAction();
        }

        private function frame887():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame887 ", e);
                };
            };
        }

        private function frame910():void
        {
            this.avtMC.endAction();
        }

        private function frame911():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame911 ", e);
                };
            };
        }

        private function frame914():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame931():void
        {
            this.avtMC.endAction();
        }

        private function frame932():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame932 ", e);
                };
            };
        }

        private function frame935():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame958():void
        {
            this.avtMC.endAction();
        }

        private function frame959():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame959 ", e);
                };
            };
        }

        private function frame962():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame984():void
        {
            this.avtMC.endAction();
        }

        private function frame985():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame985 ", e);
                };
            };
        }

        private function frame988():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1002():void
        {
            this.avtMC.endAction();
        }

        private function frame1003():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1003 ", e);
                };
            };
        }

        private function frame1014():void
        {
            stop();
        }

        private function frame1015():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1015 ", e);
                };
            };
        }

        private function frame1018():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1034():void
        {
            this.avtMC.endAction();
        }

        private function frame1035():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1035 ", e);
                };
            };
        }

        private function frame1038():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1049():void
        {
            this.avtMC.endAction();
        }

        private function frame1050():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1050 ", e);
                };
            };
        }

        private function frame1071():void
        {
            this.avtMC.endAction();
        }

        private function frame1072():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1072 ", e);
                };
            };
        }

        private function frame1083():void
        {
            stop();
        }

        private function frame1084():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1084 ", e);
                };
            };
        }

        private function frame1088():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1097():void
        {
            this.avtMC.endAction();
        }

        private function frame1098():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1098 ", e);
                };
            };
        }

        private function frame1101():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1112():void
        {
            this.avtMC.endAction();
        }

        private function frame1113():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1113 ", e);
                };
            };
        }

        private function frame1122():void
        {
            stop();
        }

        private function frame1123():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1123 ", e);
                };
            };
        }

        private function frame1127():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1136():void
        {
            this.avtMC.endAction();
        }

        private function frame1137():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1137 ", e);
                };
            };
        }

        private function frame1140():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1151():void
        {
            this.avtMC.endAction();
        }

        private function frame1152():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1152 ", e);
                };
            };
        }

        private function frame1163():void
        {
            stop();
        }

        private function frame1164():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1164 ", e);
                };
            };
        }

        private function frame1167():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1179():void
        {
            this.avtMC.endAction();
        }

        private function frame1180():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1167 ", e);
                };
            };
        }

        private function frame1183():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1192():void
        {
            this.avtMC.endAction();
        }

        private function frame1193():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1193 ", e);
                };
            };
        }

        private function frame1204():void
        {
            stop();
        }

        private function frame1205():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1205 ", e);
                };
            };
        }

        private function frame1208():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null);
        }

        private function frame1222():void
        {
            this.avtMC.endAction();
        }

        private function frame1223():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1223 ", e);
                };
            };
        }

        private function frame1227():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1244():void
        {
            this.avtMC.endAction();
        }

        private function frame1248():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1248 ", e);
                };
            };
        }

        private function frame1254():void
        {
            stop();
        }

        private function frame1255():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1255 ", e);
                };
            };
        }

        private function frame1258():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1267():void
        {
            this.avtMC.endAction();
        }

        private function frame1268():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1268 ", e);
                };
            };
        }

        private function frame1270():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1284():void
        {
            this.avtMC.endAction();
        }

        private function frame1285():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1285 ", e);
                };
            };
        }

        private function frame1296():void
        {
            this.showIdleFoot();
        }

        private function frame1297():void
        {
            this.avtMC.endAction();
        }

        private function frame1298():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1298 ", e);
                };
            };
        }

        private function frame1308():void
        {
            this.showIdleFoot();
        }

        private function frame1320():void
        {
            this.avtMC.endAction();
        }

        private function frame1321():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1321 ", e);
                };
            };
        }

        private function frame1340():void
        {
            this.avtMC.endAction();
        }

        private function frame1341():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1341 ", e);
                };
            };
        }

        private function frame1355():void
        {
            stop();
        }

        private function frame1356():void
        {
            this.showFrontFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1356 ", e);
                };
            };
        }

        private function frame1371():void
        {
            stop();
        }

        private function frame1372():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1372 ", e);
                };
            };
        }

        private function frame1405():void
        {
            this.avtMC.endAction();
        }

        private function frame1406():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1406 ", e);
                };
            };
        }

        private function frame1443():void
        {
            this.avtMC.endAction();
        }

        private function frame1444():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1444 ", e);
                };
            };
        }

        private function frame1452():void
        {
            this.gotoAndPlay("Cry2");
        }

        private function frame1453():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1453 ", e);
                };
            };
        }

        private function frame1525():void
        {
            this.gotoAndPlay("Spar");
        }

        private function frame1526():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1526 ", e);
                };
            };
        }

        private function frame1563():void
        {
            this.gotoAndPlay("Samba");
        }

        private function frame1564():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1563 ", e);
                };
            };
        }

        private function frame1579():void
        {
            this.gotoAndPlay("Stepdance");
        }

        private function frame1580():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1580 ", e);
                };
            };
        }

        private function frame1589():void
        {
            this.gotoAndPlay("Headbang");
        }

        private function frame1590():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1590 ", e);
                };
            };
        }

        private function frame1621():void
        {
            this.gotoAndPlay("Dazed");
        }

        private function frame1622():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1622 ", e);
                };
            };
        }

        private function frame1625():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null);
        }

        private function frame1648():void
        {
            this.avtMC.endAction();
        }

        private function frame1649():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1649 ", e);
                };
            };
        }

        private function frame1652():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null);
        }

        private function frame1674():void
        {
            this.avtMC.endAction();
        }

        private function frame1675():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1675 ", e);
                };
            };
        }

        private function frame1691():void
        {
            this.gotoAndPlay("Danceweapon");
        }

        private function frame1692():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1692 ", e);
                };
            };
        }

        private function frame1705():void
        {
            this.gotoAndPlay("Useweapon");
        }

        private function frame1706():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1706 ", e);
                };
            };
        }

        private function frame1725():void
        {
            this.avtMC.endAction();
        }

        private function frame1726():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1726 ", e);
                };
            };
        }

        private function frame1767():void
        {
            this.avtMC.endAction();
        }

        private function frame1768():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1768 ", e);
                };
            };
        }

        private function frame1770():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1782():void
        {
            this.avtMC.endAction();
        }

        private function frame1783():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1783 ", e);
                };
            };
        }

        private function frame1795():void
        {
            stop();
        }

        private function frame1796():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1796 ", e);
                };
            };
        }

        private function frame1801():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1819():void
        {
            this.avtMC.endAction();
        }

        private function frame1851():void
        {
            this.gotoAndPlay("Casting");
        }

        private function frame1869():void
        {
            stop();
        }

        private function frame1889():void
        {
            this.gotoAndPlay("Mining");
        }

        private function frame1903():void
        {
            this.avtMC.endAction();
        }

        private function frame1932():void
        {
            this.avtMC.endAction();
        }

        private function frame1982():void
        {
            this.avtMC.endAction();
        }

        private function frame2026():void
        {
            this.gotoAndPlay("Headscratch");
        }

        private function frame2044():void
        {
            stop();
        }

        private function frame2077():void
        {
            this.avtMC.endAction();
        }

        private function frame2087():void
        {
            stop();
        }

        private function frame2105():void
        {
            stop();
        }

        private function frame2113():void
        {
            stop();
        }

        private function frame2127():void
        {
            stop();
        }

        private function frame2146():void
        {
            stop();
        }

        private function frame2174():void
        {
            this.avtMC.endAction();
        }

        private function frame2201():void
        {
            stop();
        }

        private function frame2211():void
        {
            stop();
        }

        private function frame2252():void
        {
            this.gotoAndPlay("Toss");
        }

        private function frame2266():void
        {
            stop();
        }

        private function frame2279():void
        {
            this.gotoAndPlay("Spin");
        }

        private function frame2294():void
        {
            this.gotoAndPlay("Hop");
        }

        private function frame2319():void
        {
            stop();
        }

        private function frame2348():void
        {
            this.gotoAndPlay("Pant");
        }

        private function frame1820():void
        {
            this.showIdleFoot();
            try
            {
                this.cape.cape.gotoAndStop("Idle");
            }
            catch(e:Error)
            {
                if (Config.isDebug)
                {
                    trace("frame1820 ", e);
                };
            };
        }

        private function frame1822():void
        {
            this.avtMC.world.castSpellFX(this.avtMC.pAV, this.avtMC.spFX, null, this.avtMC.spellDur);
            this.avtMC.spellDur = 0;
        }

        private function frame1837():void
        {
            this.avtMC.endAction();
        }


    }
}//package 

