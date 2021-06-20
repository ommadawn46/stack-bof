.PHONY: enable_aslr
enable_aslr:
	sudo bash -c 'echo 1 > /proc/sys/kernel/randomize_va_space'

.PHONY: disable_aslr
disable_aslr:
	sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space'

.PHONY: all
all: ./shellcode/shellcode ./ret2win/ret2win ./bypass_canary/bypass_canary ./rop_chain/rop_chain ./libc_leak/libc_leak

./shellcode/shellcode: ./shellcode/shellcode.c
	gcc -no-pie -fno-stack-protector -z execstack ./shellcode/shellcode.c -o ./shellcode/shellcode

./ret2win/ret2win: ./ret2win/ret2win.c
	gcc -no-pie -fno-stack-protector -z execstack ./ret2win/ret2win.c -o ./ret2win/ret2win

./bypass_canary/bypass_canary: ./bypass_canary/bypass_canary.c
	gcc -no-pie -fstack-protector-all -z execstack ./bypass_canary/bypass_canary.c -o ./bypass_canary/bypass_canary

./rop_chain/rop_chain: ./rop_chain/rop_chain.c
	gcc -no-pie -fstack-protector-all ./rop_chain/rop_chain.c -o ./rop_chain/rop_chain
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./rop_chain/rop_chain

./libc_leak/libc_leak: ./libc_leak/libc_leak.c
	gcc -fstack-protector-all ./libc_leak/libc_leak.c -o ./libc_leak/libc_leak
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./libc_leak/libc_leak

.PHONY: clean
clean:
	rm -rf ./shellcode/shellcode ./ret2win/ret2win ./bypass_canary/bypass_canary ./rop_chain/rop_chain ./libc_leak/libc_leak
