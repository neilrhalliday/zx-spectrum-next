
asm : di : end asm                  ' disable interrupts?
									' These must be set before including the nextlib
#define NEX 						' If we want to produce a file NEX, LoadSDBank commands will be disabled and all data included
#define IM2							' This is required if you want to use IM2 and v7 Layer2 commands, comment out to find out why

#include <nextlib.bas>				' now include the nextlib library
#include <keys.bas>					' we are using GetKeyScanCode, inkey$ is not recommened when using our own IM routine
									' (infact any ROM routine that may requires sysvars etc should be avoided)

border 0 : paper 0 : ink 0
CLS256(0)							' clear layer 2 with the colour black

LoadSDBank("vt24000.bin",0,0,0,33) 	' load the music replay routine into bank 33
LoadSDBank("music.pt3",0,0,0,34) 	' load music.pt3 music file into bank 34
LoadSDBank("game.afb",0,0,0,45)

InitSFX(35)							' init the SFX engine. This has to be done whether we have SFX or not
                                    ' because without calling the InitSFX command, the SetUpIM() command will not work
                                    ' because InitSFX() initilises some global variables!
InitMusic(33,34,0000)				' init the music engine 33 has the player, 34 the pt3, 0000 the offset in bank 34
SetUpIM()							' init the IM2 code 
PlaySFX(0)                          ' Without this call here, the .ayfxbankinplaycode and .afxBnkAdr globals are undefined and you get a compilation error
EnableMusic                         ' start the music playing

do 
	WaitRetrace2(1)					' wait VBL?
loop 