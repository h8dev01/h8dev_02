OUTPUT_FORMAT("elf32-h8300")
OUTPUT_ARCH(h8300h)
ENTRY("_start")
MEMORY
{
	vectors : o = 0x0000, l = 0x0034
	rom     : o = 0x0034, l = 0x7fcc
	ram     : o = 0xf780, l = 0x0400
	stack   : o = 0xff80, l = 0x0000
}

SECTIONS 				
{ 					
.vectors : {
	SHORT(ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(DEFINED(_int_nmi)?ABSOLUTE(_int_nmi):ABSOLUTE(_start))
	SHORT(DEFINED(_int_trap0)?ABSOLUTE(_int_trap0):ABSOLUTE(_start))
	SHORT(DEFINED(_int_trap1)?ABSOLUTE(_int_trap1):ABSOLUTE(_start))
	SHORT(DEFINED(_int_trap2)?ABSOLUTE(_int_trap2):ABSOLUTE(_start))
	SHORT(DEFINED(_int_trap3)?ABSOLUTE(_int_trap3):ABSOLUTE(_start))
	SHORT(DEFINED(_int_break)?ABSOLUTE(_int_break):ABSOLUTE(_start))
	SHORT(DEFINED(_int_sleep)?ABSOLUTE(_int_sleep):ABSOLUTE(_start))
	SHORT(DEFINED(_int_irq0)?ABSOLUTE(_int_irq0):ABSOLUTE(_start))
	SHORT(DEFINED(_int_irq1)?ABSOLUTE(_int_irq1):ABSOLUTE(_start))
	SHORT(DEFINED(_int_irq2)?ABSOLUTE(_int_irq2):ABSOLUTE(_start))
	SHORT(DEFINED(_int_irq3)?ABSOLUTE(_int_irq3):ABSOLUTE(_start))
	SHORT(DEFINED(_int_wkp)?ABSOLUTE(_int_wkp):ABSOLUTE(_start))
	SHORT(DEFINED(_int_timera)?ABSOLUTE(_int_timera):ABSOLUTE(_start))
	SHORT(ABSOLUTE(_start))
	SHORT(DEFINED(_int_timerw)?ABSOLUTE(_int_timerw):ABSOLUTE(_start))
	SHORT(DEFINED(_int_timerv)?ABSOLUTE(_int_timerv):ABSOLUTE(_start))
	SHORT(DEFINED(_int_sci3)?ABSOLUTE(_int_sci3):ABSOLUTE(_start))
	SHORT(DEFINED(_int_iic)?ABSOLUTE(_int_iic):ABSOLUTE(_start))
	SHORT(DEFINED(_int_adi)?ABSOLUTE(_int_adi):ABSOLUTE(_start))
        }  > vectors
.text 0x0034 : {
	*(.text) 				
	*(.strings)
	*(.rodata) 				
   	 _etext = . ; 
	} > rom
.tors : {
	___ctors = . ;
	*(.ctors)
	___ctors_end = . ;
	___dtors = . ;
	*(.dtors)
	___dtors_end = . ;
	}  > rom
.data : AT ( ADDR(.tors) + SIZEOF(.tors) ){
	___data = . ;
	*(.data)
	*(.tiny)
	 _edata = .;
	} > rom
.bss : AT ( LOADADDR(.data) + SIZEOF(.data) ) {
	 _bss_start = . ;
	*(.bss)
	*(COMMON)
	 _end = . ;  
	}  >ram
.stack : {
	 _stack = . ; 
	*(.stack)
	}  > stack
.stab 0 (NOLOAD) : {
	[ .stab ]
	}
.stabstr 0 (NOLOAD) : {
	[ .stabstr ]
	}
}
