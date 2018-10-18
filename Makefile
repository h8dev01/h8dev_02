#
#	H8/3664F sample makefile
#	Copyright (c) 2001 Masahiro Ochiai
#

define EOL


endef

VERSION		=	0.1


TARGET		=	dst/h8led.mot

CFLAGS		=	-O -mh -g -mrelax -mint32 -DH8_3664

TOOL_PREFIX	=	h8300-hms-

CC			=	$(TOOL_PREFIX)gcc
AS			=	$(TOOL_PREFIX)as
LD			=	$(TOOL_PREFIX)ld

LDSCRIPT	=	h8-3664.x
CRT0		=	3664crt0.S
ASRCS		=	
SRCS		=	led.c
objS		:=	$(foreach aa1,$(SRCS:.c=.o),dst/$(aa1))


gcc:=$(TOOL_PREFIX)gcc
objcopy:=$(TOOL_PREFIX)objcopy 
cOPT:= $(CFLAGS) -T $(LDSCRIPT) -nostdlib 

#	make all source trees
all : $(TARGET)


$(foreach aa1,$(SRCS),$(eval dst/$(aa1:.c=.o) : $(aa1) $(EOL)	$(gcc) $(cOPT) -c $$^ -o $$@ ))

dst/h8led.mot: dst/h8led.exe
	$(objcopy) -O srec $^ $@
	$(objcopy) -I srec -O binary $@ $@.bin
	cat $@.bin |hexdump -C -v > $@.bin.txt


dst/h8led.exe:  Makefile $(LDSCRIPT) $(objS) $(CRT0) $(ASRCS) $(LIBS)
	mkdir -p dst
#	$(TOOL_PREFIX)gcc $(CFLAGS) -T $(LDSCRIPT) -nostdlib $(CRT0) $(ASRCS) $(objS) -o $@ $(LIBS) -lc -lgcc
	$(TOOL_PREFIX)gcc $(CFLAGS) -T $(LDSCRIPT) -nostdlib $(CRT0) $(ASRCS) $(objS) -o $@ $(LIBS) 

asmOPT11:=		-Wa,-adhln -g 
asmOPT12:=		-g -Wa,-a,-ad 
asmOPT21:=		-g -Wa,-aln=sss/aaa.21.s
asmOPT22:=		-g -Wa,-alndh=sss/aaa.22.s
asmOPT23:=		-g -Wa,-alnh=sss/aaa.23.s
asmOPT31:=		-g -Wa,-alnh=sss/aaa.31.s -save-temps 

s asm: asm.h8led_exe
asm.h8led_exe:
	mkdir -p sss
	$(foreach aa1,11 12, \
		$(gcc) $(asmOPT$(aa1)) \
		$(cOPT)    $(CRT0) $(ASRCS) $(SRCS)       \
		-o sss/bbb.coff.$(aa1) $(LIBS) > sss/ccc.$(aa1).lst $(EOL)\
		cat sss/bbb.coff.$(aa1) |hexdump -C -v > sss/bbb.coff.$(aa1).txt $(EOL)\
		)
	$(foreach aa1,21 22 23 24, \
		$(gcc) $(asmOPT$(aa1)) \
		$(cOPT)    $(CRT0) $(ASRCS) $(SRCS)       \
		-o sss/bbb.coff.$(aa1) $(LIBS) > sss/ccc.$(aa1).lst $(EOL)\
		cat sss/bbb.coff.$(aa1) |hexdump -C -v > sss/bbb.coff.$(aa1).txt $(EOL)\
		$(objcopy) -O binary $@ $@.bin
		)

tar:
	cd .. && tar zcvf h8led-$(VERSION)-`date '+%Y%m%d'`.tar.gz h8led

clean :
	rm -f \
		$(wildcard \
		dst/*.exe \
		dst/*.o \
		dst/*.s \
		dst/*.mot \
		dst/*.mot.bin \
		dst/*.mot.bin.txt \
		sss/aaa.* \
		sss/bbb.* \
		sss/ccc.* \
		)


c:clean
m:
	vim Makefile