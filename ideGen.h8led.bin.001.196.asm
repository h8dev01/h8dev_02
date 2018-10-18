﻿

;
; +-------------------------------------------------------------------------+
; |   This file has been generated by The Interactive Disassembler (IDA)    |
; |           Copyright (c) 2017 Hex-Rays, <support@hex-rays.com>           |
; |                      License info: 48-3FBD-7F04-2C                      |
; |                      Jiang Ying, Personal license                       |
; +-------------------------------------------------------------------------+
;
; Input SHA256 : 6FE4AF8E4F44108603A227665298288E7C5D05D8034C83CB6A1A964EC65B26A7
; Input MD5    : 24C867493B19AE436AD1C0DC3BE887C2
; Input CRC32  : 59A4E30D

; File Name   : E:\h3e\1\h8dev_02\h8led.bin.001.196.bin
; Format      : Binary file
; Base Address: 0000h Range: 0000h - 00C4h Loaded length: 00C4h

; Processor       : h8300a
; Target assembler: GNU assembler
; Byte sex        : Big endian

                .h8300h

; ===========================================================================

; Segment type: Pure code
                .text; ROM
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x5E ; ^
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
                .byte    0
                .byte 0x34 ; 4
; ---------------------------------------------------------------------------
                mov.l   #0xFF80, sp
                mov.l   #0xC4, er0
                mov.l   #0xC4, er1
                mov.l   #0xC4, er2

loc_4C:                                 ; CODE XREF: ROM:00000056↓j
                mov.w   @er0, r3
                mov.w   r3, @er1
                adds    #2, er0
                adds    #2, er1
                cmp.l   er2, er1
                bcs     loc_4C:8

loc_58:                                 ; CODE XREF: ROM:0000005C↓j
                jsr     sub_8E:24
                bra     loc_58:8
; ---------------------------------------------------------------------------
                push.l  er6
                mov.l   sp, er6
                push.l  er2
                push.l  er3
                mov.l   #0xFFF6, er3
                mov.b   @er3, r2l
                and.b   #0x9F, r2l
                mov.b   r2l, @er3
                mov.b   #0xD4, r3l
                mov.b   @er3, r2l
                not.b   r2l
                mov.b   r2l, @er3
                pop.l   er3
                pop.l   er2
                pop.l   er6
                rte

; =============== S U B R O U T I N E =======================================

; Attributes: bp-based frame

sub_8E:                                 ; CODE XREF: ROM:loc_58↑p
                push.l  er6
                mov.l   sp, er6
                sub.b   r3l, r3l
                mov.b   r3l, @0xFFE0:32
                mov.b   #0xFF, r2l
                mov.b   r2l, @PCR1:32
                mov.b   r3l, @PDR1:32
                mov.b   #0x99, r2l
                mov.b   r2l, @0xFFA6:32
                mov.l   #0xFFF4, er3
                mov.b   @er3, r2l
                or.b    #0x40, r2l
                mov.b   r2l, @er3
                andc    #0x7F, ccr

loc_C0:                                 ; CODE XREF: sub_8E+34↓j
                sleep
                bra     loc_C0:8
; End of function sub_8E


                ; end