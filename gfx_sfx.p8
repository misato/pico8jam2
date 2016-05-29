pico-8 cartridge // http://www.pico-8.com
version 7
__lua__
-- gfx testing code
-- very crude and should not be learnt from :)
titley=0; titlesin=0
-- state=1 title-screen
-- state=2 game over-screen
state=1
palt(0,false); palt(14,true)
if (state==1) music(8)
if (state==2) music(12)

-- this function just returns the value
-- of sin(value) multiplied by then but
-- if the value is bigger then zero it
-- sets it to zero to get the "jumping"
-- effect
function sinjump(a)
 b=sin(a)*10
 if b>0 then b=0 end
 return b
end

-- prints text with a black outline
function printol(pstring,px,py,pcol)
 for printx=0,2 do
  for printy=0,2 do
   print(pstring,px+printx,py+printy,0)
  end
 end
 print(pstring,px+1,py+1,pcol)
end

function bgsinloop(bgspr)
 for lx=-2,17 do
  for ly=-2,17 do
  	spr(bgspr,lx*16+sin(titlesin)*30,ly*16+sin(titlesin/2+0.5)*30,2,2)
  end
 end
end

function drawtitlelogo()
 -- the
 spr(192,38,16+sinjump(titley),2,2)
 spr(194,56,16+sinjump(titley+0.9),2,2)
 spr(196,74,16+sinjump(titley+0.8),2,2)
 -- loot
 spr(198,30,40+sinjump(titley+0.85),2,2)
 spr(200,48,40+sinjump(titley+0.75),2,2)
 spr(200,66,40+sinjump(titley+0.65),2,2)
 spr(192,84,40+sinjump(titley+0.55),2,2)
 -- cave
 spr(204,30,64+sinjump(titley+0.7),2,2)
 spr(202,48,64+sinjump(titley+0.6),2,2)
 spr(206,66,64+sinjump(titley+0.5),2,2)
 spr(196,84,64+sinjump(titley+0.4),2,2)
end

function drawgameoverlogo()
 pal(2,1)
 pal(13,2)
 pal(9,8)
 pal(10,9)
 pal(7,10)
 -- game
 spr(226,12,16,2,2)
 spr(202,30,16,2,2)
 spr(228,48,16,2,2)
 spr(196,66,16,2,2)
 -- over
 spr(200,46,36,2,2)
 spr(206,64,36,2,2)
 spr(196,82,36,2,2)
 spr(230,100,36,2,2)
 pal()
 palt(0,false); palt(14,true)
end

function _draw()
 -- titlescreen draw loop, no need
 -- for cls() since the entire screen
 -- gets painted over anyway
 titley+=0.01 -- speed of jumping letters
 titlesin+=0.005 -- speed of the "camera"

 -- this loop paints the background
 if (state==1) bgsinloop(224)
 if (state==2) bgsinloop(232)

 -- draw the logo
 if (state==1) drawtitlelogo()
 if (state==2) drawgameoverlogo()

 if state==1 then 
  rectfill(0,0,127,2,1)
  rectfill(0,122,127,127,1)
  rectfill(0,3,127,5,0)
  line(0,4,127,4,3)
  rectfill(0,120,127,122,0)
  line(0,121,127,121,3)
  printol("press x to start",32,96,7)
  printol("by misato & jayminer",24,118,6)
 end
 if state==2 then
  printol("you scored xxxxx points",18,96,8)
  printol("try again!",46,110,8)
 end
end

__gfx__
000000004949499466d6dd6dddccdc6c444944940000000000000000000000000000000000000000000000000000000000000000011111000000000000000000
00000000949a94497766d676dc76cdc6454445440000000000000000000000000000000000000000000000000000000000000000116d2d100000000010000000
00000000a94949a976676776c66c6cdc59459454000000000000000000000000000000000000000000000000000000000000000016d112210000000011000000
00000000994a94946dd6d66ddccdcdcd4444444400000000000000000000000000000000000000000000000000000000000000001d1d2020000010101d111010
00000000449aa949d7766776cddc676c454454450000000000000000000000000000000000000000000000000000000000000000011221210001212112122121
000000009a49a494677667666cc676cd44944945000000000000000000000000000000000000000000000000000000000000000000101220000012201d201220
00000000a99494496766d666c6dc6cdc444444440000000000000000000000000000000000000000000000000000000000000000000122100001221001222210
0000000094444994d66dd66ddcddcdcd554454540000000000000000000000000000000000000000000000000000000000000000000010000000100000101000
24d424d24d42224242d42d425dd55dd55dd555d55dd55dd55d55d5d55dd5ddd5d55dd5d555555555555555555552525501111100000000000000110000001100
422242422424d424242242245d6d5d6dd55d6d565d6d56d5d6dddd6dd66d5d6ddd5d6dd5252525252525552525252525116d2d100000000000012d1000012d10
d424d424424ddd424224d42d5dd55dd5d5d6dd5d5ddd5d55d6d656d5d666d6d5d555dd5552525252525252525252525216d11221000000000000122100001221
412142122124d421d214d4241551155155ddd555155515115d5d5d5d5ddd5d5d55d5555d2222222222222222222222221d1d2020010110100101202000012020
1242144214124212414242125115511511555115d111d1dd55551555155515551551515521212121212221212122212112122121121221211212212100012121
212421242442212121121421d515d515d5111511d51551551515151551115115511555151212121212121212121212121d2012201d2012201d20122000001220
1212111212211211121121215111511155115d515115111511111111111111111101110111111111112111111111211101222210012222100122221000012210
01010011011001010101101110011001110011101001000100110101100011000000100000101001001010010010100100101000001010000010100000001000
00010151000000000001511000100001000001510000015100000000000000000001015100010151000016d15350535000001350000000000000000000000000
010001100000000011001100100110150000001000000110010000000000000001000110010001100101606d3330333000001330000000000000000011000000
151000000000000015100000000151010000000000000000151000000000000015100000151000001516007d1510151000001510000000000000000015100000
0100100000000000010001001001100000000000000010000100100000000000010010000100d0000100676d0001000500010005000100010000000100010000
00015101000000000000151001000001000001010000010100015101000000000001510103d030d3000606d15053505300001053101510150000101550535053
100110001000100001101100151001001000100000001000100110000000100000001000003515301001d0003033303300001033305330530000105330333033
51000001510000011511001101001110510000010000000151000001000000010000000150000000510000001015101500011015101510150000101510151015
10000010100000100110001000001510100000100000001010000010000000100000001010000000100000100100010000000100010001000000010001000100
21112111000000000001211100012111211121110000000000000000211121112111211111111211111111215350535000001350535053505350535000000000
2211111200000000000011120000111222111112000000001000000022b11b122211111212211112112221113330333000005330333033303330333000000000
21122111000000000000211100002111211221110000000021000000231221312112211112212212122222111510151000001510151015101530151000000000
112222111100001110022211000122111122221100011001112110011122b2111122221121112211122222120001000500010005000100050001003500000000
21122112211221122112211200012112011221120001211221122112231231122112d11211211111112221110015505310535053501510535053535300000000
221111222211112222111122000011220011112200001122221111222213112223d131d312221221211111110001303330333033305550333333303300000000
211121122111211221112112000021120001211200002112211121122b1121322135153212221221221221120000101510151015101110151035101500000000
11211121112111211121112100011121000111210001112111211121113111211111111121111111211221110000010001000100010001000100010000000000
eeeeeeeeee676deeeeeeeeeeeeeeeeeeeed77de7eeeeeeeeeeeeeeeeeed66deeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000ee
ee676deeedc66cdeee676deeeed77de7edd66dd6eed77de7eed66deeed6cccdeeed66deeeeeeeeeeeeeeeeeeee9982eeeeeeeeeeeeeeeeeeeeeeeeeeee0c7c0e
edc66cde56dccd6dedc66cdeedd66dd656dddd5dedd66dd6ed6cccdee5d6ccdeed6cccdeeeeeeeeee899882ee9a9982eeeeeeeeeeeeeeeeeeeeeeeeee0d6c6d0
56dccd6d6d6dd6dd56dccd6d56dddd5d6dd66dd6d6dddd5de5d6ccdee15dddeee5d6ccdee899882e89a9988289999882eeeeeeeeeeeeeeeeeeeeeeeee07d6d60
6d6dd6d57567765d6d6dd6d6ddd66dd6d5dddd557dd66dd6e15dd777e5d6d777e15dd77789a998828999988288998882eeeeeeeeeeeeeeeeeeeeeeeee05ddd50
7567765575d66d557567765655dddd5555d66d5e65dddd55e5d666eee55d66eee5d666ee889988828899888228888822eeeeeeeeeeeeeeeeeeeeeeeee0d6d6d0
75d6dd55e56dd65e75dd6d5de55d6d5ee56dd65e55d6d55ee55dd6dee5d5ddeeed5dd5ee288888202888882002888220eeeeeeeeeeeeeeeeeeeeeeeee05d5d50
e567d55ee5d55d5ee55d765ee155d65ee5d55d5ee56d551ee115d6dee15d6d5eed6d51eee222220ee222220ee022220eeeeeeeeeeeeeeeeeeeeeeeeeee00000e
eb3ee3beeeeeeeeeeb3ee3beeeeeeeeeeb3eeeeeeeeeeeeeeeebbeeeeeeeeeeeeeebbeeeeeeeeeeeeeebbeeeeeeeeeeeeeeeeeeeeee98eeeeeeeeeeeeeeeeeee
e3b77b3eeb3ee3bee3bbbb3eeb3ee3bee3bb7b3eeb3eeeeeee6bb6eeeeebbeeeee6bb6eeeeebbeeeee6bb6eeeeebbeeeeeeeeeeeeee98eeeeeeeeeeeeeeeeeee
e13bb31ee3b77b3ee133331ee3bbbb3ee13bbb3ee3bb7b3eee6336eeee6bb6eeee6336eeee6bb6eeee6336eeee6bb6eeeeeeeeeeeee98eeeeeeeeeeeaaaaaaaa
13133131e13bb31e13133131e133331ee3b333eee13bbb3ee76dd66eee6336eee66dd67eee6336eeee6dd6eeee6336eeeeeeeeeeeee98eee9999999977777777
313aa31333133131313333133313313113b139eee3b333eee755555ee76dd66ee555557ee66dd67eee55777eee6dd6eeeeeeeeeeeee98eee88888888aaaaaaaa
e13bb31eb33ab311e13bb31eb333331113b13bee1b31393ee75555eee755555eee55556ee555557eee5565eeee55777eeeeeeeeeeee98eeeeeeeeeee99999999
13133131e13b331113133131e13b3311e13111ee1313331eee5555eee75555eeee5555eeee55556eee5555eeee5565eeeeeeeeeeeee98eeeeeeeeeeeeeeeeeee
3b3113b33bb3311e3b3113b33bb3311ee3b7b3ee3b731b3eeee22eeeee5555eeeee22eeeee5555eeeee22eeeee5555eeeeeeeeeeeee98eeeeeeeeeeeeeeeeeee
e677776ee677776ee677776eeec7ceeeeeeeeeeeeec7ceeeeeeeeeeeeec7ceeeeeeeeeeee7eeee7eeeeeeeeee7eeee7eeeeeeeeee7eeeeeeeeeeeeeeeea7a9ee
877777766777777867777776eccccceeeec7ceeeec7ccceeeec7ceeeec7ccdeeeec7ceeee68aa86ee7eeee7ee689986ee7eeee7eee6aa8eee7eeeeeeeea7a9ee
d678778dd877877dd687787dedcccd7eeccccceeeccccceeec7ccceeeccccdeeec7ccdeee809908ee68aa86ee8888886e6899866e899808eee6aa8eeeea7a9ee
d666666dd666666dd666666de9ddd97eedcccd7ee9ccc9eeeccccceee9ccd9eeeccccdeee488884ee8099084e488884648888886e488884ee899808eeea7a9ee
ed6666deed6666deed6666def49994fee9ddd97ef49a94fee9ccc9eee4a994eee9ccd9ee42244224e48888424224422424888844e224422ee488884eeea7a9ee
e00dd00ee00dd00ee00dd00ee14441eef49994fe714441eef49a94fee14f77eee4a994ee652222124224422e21222212e2244222e126666ee226666eeea7a9ee
000000000000000000000000ee111eeee14441ee7e111eee714441eeee111eeee14f77ee6522221e6522221ee122221ee122221ee124555ee124555eeea7a9ee
e000000ee000000ee000000eee2e2eeeee1112eeee2e2eee72111eeeeee2eeeee21112eeedd11dde65221dd1edd11ddee1221dd1ee1dd1ee1d1221d1eea7a9ee
eeeeeeeeeeeeeeeeeeeeeeeeee333eeeeedddeeeeedddeeeee888eeeeecceeeeeec7eeeeeeecceee7ceceeeeceeeeeeec7eeeeeeeceeeeeeeeeeeceeeeeeceee
eee8eeeeeeeeeeeeee2222eee3bbb3eeed666deeedcccdeee89998eeeec7ceeceeecceeeeee7eceeccceceeec7eee7eeecceeeeeeec7eeeeeeeeeeeeeeee7eee
ee8a8eeeee8982eee2aaaa2e3b777b3ed67776dedc777cde8977798eeeecceceeeec7eeece7ceeeeec77ceeeeccecceeee7ceeeeeeecceceeeeeceeeeceec7ee
ee979eeee8a7a82e29aaaa9213bbb31e5d666d5e2dcccd2e2899982eecec7c7eeee7ceeec7ceeeeeeeec7ceeee7ceeeeeee7ceececc77c7cec7ceceeceeeecce
ee8a8eeeee8982ee29777792133b331e5dd6dd5e2ddcdd2e2889882eeecc7ceececceceeec7eec7ceeeecceeeee7ceeeecc7ceccc7ccccc77cc7c7ccc7ceeec7
ee282eeeeeeeeeee2a9999a2e13b31eee5d6d5eee2dcd2eee28982eeeeecceeeecc7ceeceecec7eeeec7e7ceeececceeeeecc7cecceeceecceeecc77ee7c7c7c
eee2eeeeeeeeeeeee222222eee131eeeee5d5eeeee2d2eeeee282eeeeeec7ceeee7ceeeeee7cceeeeceeee7cee7ce7ceeeeeec7eeeeceeeeeeeeeceeeee7ceee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeec7ceeeee7ceeeeeec7eeeeeeeeeec7eeecee7ceeeeeecceeeeeeeeeeeeceeeeecceeee
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e00000000000000ee000000ee000000eee0000000000000ee000000eeeeeeeeeee000000000000eeee000000000000eeee000000000000eee000000ee000000e
0d9aaaaaaaaaa9d00d9aaa9009aaa9d0e09aaaaaaaaaa9d009aaaa90eeeeeeeee09aaaaaaaaaa90ee09aaaaaaaaaa90ee0aaaaaaaaaaaa0e09aaaa9009aaaa90
09aa77777777aa9009a777a00a777a9009aa77777777aa900aa77aa0eeeeeeee09aa77777777aa9009aa77777777aa900aa7777777777aa00a7777a00a7777a0
099aaaaaaaaaa99009aaaaa00aaaaa90099aaaaaaaaaa99009aaaa90eeeeeeee099aaaaaaaaaa990099aaaaaaaaaa99009aaaaaaaaaaaa9009aaaa9009aaaa90
09999aaaaaa99990099aaaa00aaaa99009999aaaaaa99990099aa990eeeeeeee09999aaaaaa9999009999aaaaaa999900999aaaaaaaa9990099aa990099aa990
0d999999999999d009999aaaaaa9999009999999999999d009999990eeeeeeee0999999999999990099999999999999009999999999999d00999999009999990
00dd99999999dd0009999999999999900999999d0000000e09999990eeeeeeee0999999dd99999900999999dd99999900999999ddddddd0e0999999009999990
e000d999999d000e099999999999999009999999aaa90eee09999990eeeeeeee09999990099999900999999009999990099999d0000000ee0999999009999990
eeee09999990eeee099999999999999009999999999d0eee0999999d0000000e09999990099999900999999009999990099999d0000000ee0d999990099999d0
eeee09999990eeee09999999999999900999999d0000000e09999999aaaaaa900999999aa99999900999999aa99999900999999aaaaaaa0e0d99999aa99999d0
eeee09999990eeee0999999dd999999009999999aaaaaa90099999999999999009999999999999900999999999999990099999999999999002d9999999999d20
eeee09999990eeee0d999990099999d00d999999999999d00d999999999999d00d999999999999d00d99999dd99999d00d999999999999d0e0dd99999999dd0e
eeee0d9999d0eeee0ddd99d00d99ddd00ddd99999999ddd00ddd99999999ddd00dd9999999999dd00ddd99d00d99ddd00ddd99999999ddd0e02dd999999dd20e
eeee02dddd20eeee02dddd2002dddd2002dddddddddddd2002dddddddddddd2002dddddddddddd2002dddd2002dddd2002dddddddddddd20ee02dddddddd20ee
eeee002dd200eeee002dd200002dd200e02dddddddddd200002dddddddddd200e02dddddddddd20ee02dd20ee02dd20ee02dddddddddd20eeee02dddddd20eee
eeeee000000eeeeee000000ee000000eee0000000000000ee00000000000000eee000000000000eeee0000eeee0000eeee000000000000eeeeee00000000eeee
1222422112944444ee0000000000000eee000000000000eeee000000000000ee0000000000000000000000000000000000000000000000000000000000000000
1211111112249942e09aaaaaaaaaa9d0e09aaaaaaaaaa90ee09aaaaaaaaaa90e0105011002220500000000000000000000000000000000000000000000000000
111444211222442209aa77777777aa9009aa77777777aa9009aa77777777aa90005d011002220d50000000000000000000000000000000000000000000000000
1144444212224422099aaaaaaaaaa990099aaaaaaaaaa990099aaaaaaaaaa9900105d0100020d500000000000000000000000000000000000000000000000000
149444442122422109999aaaaaa9999009999aaaaaa9999009999aaaaaa9999001100005d5000020000000000000000000000000000000000000000000000000
124994492111111109999999999999d009999999999999900999999999999990011100dd6dd00220000000000000000000000000000000000000000000000000
12224994211442110999990000000000099999d99d9999900999999dd99999d001110d00d00d0220000000000000000000000000000000000000000000000000
112224442144442109999909aaaaaa9009999909909999900999999009999d0e00000600d0060000000000000000000000000000000000000000000000000000
21122442219499440999990d999999900999990dd099999009999990099990ee00000d00600d0000000000000000000000000000000000000000000000000000
2211224211494442099999000009999009999900009999900999999aa999990e022205d666d50110000000000000000000000000000000000000000000000000
21111111112442220999999aaaa999900999990ee09999900999999999999990022200d555d00110000000000000000000000000000000000000000000000000
11124442111242220d999999999999d00d99990ee09999d00d99999dd99999d002000050d0500000000000000000000000000000000000000000000000000000
12444444411122210ddd99999999ddd00dd99d0ee0d99dd00ddd99d00d99ddd00055d0005000d550000000000000000000000000000000000000000000000000
149444992111111102dddddddddddd2002dddd0ee0dddd2002dddd2002dddd20020d022000110d00000000000000000000000000000000000000000000000000
1224994221124421e02dddddddddd200e02dd0eeee0dd20ee02dd20ee02dd20e0220222001111010000000000000000000000000000000000000000000000000
1222442211244441ee0000000000000eee000eeeeee000eeee0000eeee0000ee0000000000000000000000000000000000000000000000000000000000000000
__gff__
0003000000000000000000000000000001010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010125200101010101010102020202333902020202333002020202030303032c2b2b3d2b2b2b2b030303030404041f1c1c1c1c1c1c1c1c1c04040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0112111012111225221112111210110102131415333013141315333a15141302031817182c3e2b2b2b2b2b2b1816170304191a1f1c1c1c1c1c1c1c1c1c191b0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0127212121212124202621212121210102353131323a36313131323036313102032e2d2d3c2b2b2b2b2b3e2b2f2d2d03040e1d1e1c1c1c1c1c1c1c1c1c0f1d0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01252320222023202022202a202020011333303a303030393039303830303014032c3d2b2b2b2b2b3d2b2b2b2b2b2b03041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0125202923202020202322202320200131323930383030303030303039303a36172c2b2b2b3d2b2b2b2b2b2b2b3e2b16041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
012522202020222023202920202320013a30303030393a303a303930303930302d3c2b2b2b2b2b2b2b2b2b2b2b2b2b2f041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1125202020232020202320202220201102343a303930393030303030303030022b2b2b2b2b2b2b3e2b2b2b2b2b2b2b3e191f1c1c1c1c1c1c1c1c1c1c1c1c1c1a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
21242020202020202220202320202026023330303030303030303930303a30022b2b3e2b2b2b2b2b2b2b2b2b3d2b2b3d1d1e1c1c1c1c1c1c1c1c1c1c1c1c1c0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
222020232022202020202320202320200233383039303a30303a3030373030022b3d2b2b2b2b2b2b2b2b2b2b3e2b2b2b1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0128202029202023202020202020200102333030303030393038303030303a022b2b2b2b3d2b3e2b2b2b2b2b2b2b2b3e040d1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
012523202220202020202223202220011433303a303930303030303a393030152b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0125202020202a2320202020292020013132303030303039303030303a3030362b2b2b2b2b2b2b2b2b2b3d2b2b2b2b2b041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
012520202020202020232020202223013030303030373030303a303930303930033b2b2b2b3e2b2b2b2b2b2b2b2b2b03041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0125232220202023292020232020200102343039303030303a39303930393002032c2b2b2b2b2b3d2b2b2b3e2b2b2b03041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0125202020202020202020202020200102333030303030393030393038303002032c3e2b2b2b2b2b2b2b2b2b2b3d2b03041f1c1c1c1c1c1c1c1c1c1c1c1c1c0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01010101010101282001010101010101020202343a0202020202023430020202030303033b2b2b2b2b2b2b2b030303030404040d1c1c1c1c1c1c1c1c1c04040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000145701557016570185701b570205702857035570005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000100000c2300e2500f26011260112701227013270132701327013270132601226012250112300f2100e2300a220052100020000200002000020000200002000020000200002000020000200002000020000200
000100000b3100f32011330143401634013340113400f3400c3300b3300d320103101231015310133200f3300b340003000030000300003000030000300003000030000300003000030000300003000030000300
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0110002013070170301a0701f030230701f0301a0701703013070170301a0701f030230701f0301a070170301207016030190701e030220701e03019070160301207016030190701e030220701e0301907016030
012000001a1721a14223172231422117221142211221f1721e1721e1421e1221e112191721914219122191121f1721f1422317223142261722614223172231422217222152221422213222132221222212222112
01100010286551c60028615286251c453106052861528625286550000028655000001c07300000286112862100000000000000000000000000000000000000000000000000000000000000000000000000000000
0120000013711137311375113771137611374113721137111e7111e7311e7511e7711e7611e7411e7211e7111a7111a7311a7511a7711a7611a7411a7211a7111971119731197511977119761197411972119711
012000001c755177251f7551c725237551f72528755237251a755157251e7551a725217551e725267552172517755127251a755177251e7551a725237551e72518755137251c755187251f7551c725247551f725
012000001304213022130121302217041170221701217022150411502215012150220e0410e0220e0120e02212041120221201212022170411702217012170221804118022180121802213041130221301213022
0004002025630296202c6202d6102d6102a610266103e600000000000000000000000c6000a60006600016000c0500a0410703103011000000000000000000000461006600000000000004620000000000000000
0130000010745000000b74500000077450000004745000000274500000067450000009745000000e7450000010745000000b74500000077450000004745000000074500000047450000007745000000c74500000
0130000010312103211033110321103111032110331103210e3110e3210e3310e3210e3110e3210e3310e3210b3110b3210b3310b3210b3110b3210b3310b3210731107321073310732107311073210733107321
013000002f0252b025280252b0252f0252b025280252b0252d0252a025260252a0252d0252a025260252a0252a0252602523025260252a0252602523025260252b0252802524025280252b025280252402528025
012000002b7452b7451f7002b7452f745237002d7452b7452a7452a745217002a7452d7452d7002b7452a74526745267452f700267452a7452a7002d7452a7452b7452b745247002b74528745287002b70028700
01200000285752857500505285750050526575005052357521575215752150521575005051f575005052157523575235750050526575005052557500505235751f5751f57500505245750050528575005052b575
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 13101244
00 13101244
00 11101244
02 11101244
00 41424344
00 41424344
00 41424344
00 41424344
01 14151644
00 1415161a
00 1415161a
02 1415161b
03 17181944
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

