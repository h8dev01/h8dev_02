#
#	H8/3664F sample makefile
#	Copyright (c) 2001 Masahiro Ochiai
#

define EOL


endef

VERSION		=	0.1


TARGET		=	dst/h8led.mot

CFLAGS		=	-O -mh -g -mrelax -mint32 -DH8_3664

#old_hms_gcc:=111111

ifdef old_hms_gcc
TOOL_PREFIX	=	h8300-hms-
TOOL_PREFIX	=	/usr/bin/h8300-hitachi-coff-
LDSCRIPT	=	h8-3664.x
CRT0		=	3664crt0.S
else
TOOL_PREFIX	=	/home/bootH/vm3/VMs/topVM/VM.jg1/virtFS.jg1/r5h30211/gnuh8300_v12.02_elf-1-1.i386.rpm__/usr/share/gnuh8300_v12.02_elf-1/bin/h8300-elf-
TOOL_PREFIX	=	/home/bootH/bin/h8300-elf-
LDSCRIPT	=	h8300hnelf.x
CRT0		=	h8300hCrt0.S
endif

CC			=	$(TOOL_PREFIX)gcc
AS			=	$(TOOL_PREFIX)as
LD			=	$(TOOL_PREFIX)ld



ASRCS		=	
SRCS		=	led.c
objS		:=	$(foreach aa1,$(SRCS:.c=.o),dst/$(aa1))


gcc:=$(TOOL_PREFIX)gcc
objcopy:=$(TOOL_PREFIX)objcopy 
objdump:=$(TOOL_PREFIX)objdump
cOPT:= $(CFLAGS) -T $(LDSCRIPT) -nostdlib 

all : 
	@echo ; echo "$${help_text}" ; echo 

#	make all source trees
n nnn normal : clean $(TARGET)

$(foreach aa1,$(SRCS),$(eval dst/$(aa1:.c=.o) : $(aa1) $(EOL)	$(gcc) $(cOPT) -c $$^ -o $$@ ))

dst/h8led.mot: dst/h8led.exe
	$(objcopy) -O srec $^ $@
	$(objcopy) -I srec -O binary $@ $@.bin
	cat $@.bin |hexdump -C -v > $@.bin.hex.txt


dst/h8led.exe:  Makefile $(LDSCRIPT) $(objS) $(CRT0) $(ASRCS) $(LIBS)
	mkdir -p dst
#	$(TOOL_PREFIX)gcc $(CFLAGS) -T $(LDSCRIPT) -nostdlib $(CRT0) $(ASRCS) $(objS) -o $@ $(LIBS) -lc -lgcc
	$(TOOL_PREFIX)gcc $(CFLAGS) -T $(LDSCRIPT) -nostdlib $(CRT0) $(ASRCS) $(objS) -o $@ $(LIBS) 

#
# $ gcc -Wa,-adhln -g source_code.c > assembly_list.s
# The options:
# 
# -g: Produce debugging information
# -Wa,option: Pass option as an option to the assembler
# -adhln:
# a: turn on listings
# d: omit debugging directives; n: omit forms processing
# h: include high-level source
# l: include assembly
#

asmOPT11:=		-fverbose-asm -Wa,-adhln -g 
asmOPT12:=		-fverbose-asm -g -Wa,-a,-ad 
asmOPT13:=		-fverbose-asm -g -Wa,-adhln 
asmOPT21:=		-fverbose-asm -g -Wa,-aln=sss/aaa.21.s
asmOPT22:=		-fverbose-asm -g -Wa,-alndh=sss/aaa.22.s
asmOPT23:=		-fverbose-asm -g -Wa,-alnh=sss/aaa.23.s
asmOPT31:=		-fverbose-asm -g -Wa,-alnh=sss/aaa.31.s -save-temps 

s asm sss : asm.h8led_exe
asm.h8led_exe:
	mkdir -p sss
	$(foreach aa1,11 12 13, \
		$(gcc) $(asmOPT$(aa1)) \
		$(cOPT)    $(CRT0) $(ASRCS) $(SRCS)       \
		-o sss/bbb.coff.$(aa1).coff $(LIBS) > sss/ccc.$(aa1).lst $(EOL) \
		\
		cat sss/bbb.coff.$(aa1).coff |hexdump -C -v > sss/bbb.coff.$(aa1).coff.hex.txt $(EOL)\
		\
		$(objcopy) -O binary sss/bbb.coff.$(aa1).coff sss/ddd.coff.$(aa1).bin $(EOL) \
		\
		cat sss/ddd.coff.$(aa1).bin |hexdump -C -v > sss/ddd.coff.$(aa1).bin.hex.txt $(EOL)\
		)
	$(foreach aa1,21 22 23 24, \
		$(gcc) $(asmOPT$(aa1)) \
		$(cOPT)    $(CRT0) $(ASRCS) $(SRCS)       \
		-o sss/bbb.coff.$(aa1).coff $(LIBS) > sss/ccc.$(aa1).lst $(EOL)\
		\
		cat sss/bbb.coff.$(aa1).coff |hexdump -C -v > sss/bbb.coff.$(aa1).coff.hex.txt $(EOL)\
		\
		$(objcopy) -O binary sss/bbb.coff.$(aa1).coff sss/ddd.coff.$(aa1).bin $(EOL) \
		\
		cat sss/ddd.coff.$(aa1).bin |hexdump -C -v > sss/ddd.coff.$(aa1).bin.hex.txt $(EOL)\
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
		dst/*.bin \
		dst/*.bin.txt \
		sss/aaa.* \
		sss/bbb.* \
		sss/ccc.* \
		sss/ddd.* \
		)


c:clean
m:
	vim Makefile

gs :
	git status
gc :
	git commit -a
gd:
	git diff
up gu:
	git push -u origin master

fm format :
	$(objdump) -i

define help_text
	fm           : show obj format
	s asm sss    : build asm.h8led_exe using the origin mothed
	n nnn normal : build c use origin Makefile : $(TARGET)

endef
export help_text

