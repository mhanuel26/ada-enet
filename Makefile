BOARD=stm32f769
BOARD_DIR=stm32f769disco
MODE=-XBUILD=Debug -XBUILD_RTS=Debug

all:	ping echo dns time

ping:
	arm-eabi-gnatmake $(MODE) -Pping -p -cargs -mno-unaligned-access
	arm-eabi-objcopy -O binary obj/${BOARD_DIR}/ping ping.bin

time:
	arm-eabi-gnatmake $(MODE) -Ptime -p -cargs -mno-unaligned-access
	arm-eabi-objcopy -O binary obj/${BOARD_DIR}/time time.bin

echo:
	arm-eabi-gnatmake $(MODE) -Pecho -p -cargs -mno-unaligned-access
	arm-eabi-objcopy -O binary obj/${BOARD_DIR}/echo echo.bin

dns:
	arm-eabi-gnatmake $(MODE) -Pdns -p -cargs -mno-unaligned-access
	arm-eabi-objcopy -O binary obj/${BOARD_DIR}/dns dns.bin

ethdemo:
	arm-eabi-gnatmake -Panet -p -cargs -mno-unaligned-access
	arm-eabi-objcopy -O binary obj/${BOARD_DIR}/ethdemo ethdemo.bin

flash-time:		time
	st-flash write time.bin 0x8000000

flash-ping:		ping
	st-flash write ping.bin 0x8000000

flash-echo:		all
	st-flash write echo.bin 0x8000000

flash-dns:		dns
	st-flash write dns.bin 0x8000000

checkout:
	git submodule update --init --recursive

clean:
	rm -rf obj ping.bin echo.bin dns.bin time.bin

.PHONY: ping echo time dns

