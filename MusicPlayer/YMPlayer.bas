' Atari ST YM Player for the ZX Spectrum Next
' Written by Neil Halliday
' March 2024

'asm : di : end asm                  ' disable interrupts?
									' These must be set before including the nextlib
#define NEX 						' If we want to produce a file NEX, LoadSDBank commands will be disabled and all data included

#include <nextlib.bas>				' now include the nextlib library
#include <keys.bas>					' we are using GetKeyScanCode, inkey$ is not recommened when using our own IM routine
									' (infact any ROM routine that may requires sysvars etc should be avoided)

border 0 : paper 0 : ink 15
CLS256(0)							' clear layer 2 with the colour black

InitSoundChip()

print "YM Replay v0.1"
Print ""
print "Playing 'Think Twice' by Mad Max"

do
    WaitRetrace2(1)					' wait VBL?
    PlayNextFrame()
loop

asm
    writeay:
            LD BC, $FFFD        ; Turbo Sound Next Control Register
            OUT (C), A          ; Select register

            LD A,D              ; Copy value into A
            LD BC, $BFFD        ; PSG value write
            OUT (C), A          ; Write value to PSG
            RET                 ; Return

    frames:
        dw 1921+1
    ymfile:
        incbin "data/thinktwice.bin"
    ymend:
    ympos:
        dw 0
    frameno:
        dw 0    
end asm

sub InitSoundChip()
    asm
	    LD BC, $FFFD		; Turbo Sound Next Control Register
	    LD A, %11111101		; Enable left+right audio, select AY2
	    OUT (C), A

	    ; Setup mapping of chip channels to stereo channels
	    NEXTREG $08, %00010010	; Use ABC, enable internal speaker & turbosound
	    NEXTREG $09, %00000000	; Enable mono for AY0-2

        LD HL, ymfile
        LD (ympos), HL          ; Set the memory address of the frame
        LD HL, 0
        LD (frameno), HL        ; Reset the frame number to zero
    end asm
end sub

sub PlayNextFrame()
    asm
        LD HL, (ympos)          ; Get the memory address of the frame

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 0                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 1                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 2                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 3                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 4                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 5                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 6                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 7                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 8                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 9                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 10                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 11                 ; A is the PSG register number
	    CALL writeay      ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 12                 ; A is the PSG register number
	    CALL writeay            ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD A, (HL)	            ; Read next byte from (HL)
        LD D, A                 ; Copy the value to D
	    LD A, 13                 ; A is the PSG register number
	    CALL writeay            ; Write the value to the PSG
        INC HL                  ; Move to the next byte

        LD (ympos), HL          ; Save the memory address of the frame  

        LD HL, (frameno)        ; Get the frame number
        INC HL                  ; Increase the frame number
        LD (frameno), HL        ; Save the frame number

        LD DE,(frames)
        SBC HL,DE                ; Subtract the number of frames
        JR NZ,cont               ; If not zero, skip

    reset:
        LD HL, ymfile
        LD (ympos), HL          ; Set the memory address of the frame
        LD HL, 0
        LD (frameno), HL        ; Reset the frame number to zero

    cont:
                     
    end asm
end sub



