./0_ret2win/ret2win: ./0_ret2win/ret2win.c
	gcc -no-pie -fno-stack-protector -z execstack ./0_ret2win/ret2win.c -o ./0_ret2win/ret2win

./1_shellcode/shellcode: ./1_shellcode/shellcode.c
	gcc -no-pie -fno-stack-protector -z execstack ./1_shellcode/shellcode.c -o ./1_shellcode/shellcode

./2_bypass_canary/bypass_canary: ./2_bypass_canary/bypass_canary.c
	gcc -no-pie -fstack-protector-all -z execstack ./2_bypass_canary/bypass_canary.c -o ./2_bypass_canary/bypass_canary

./3_rop_chain/rop_chain: ./3_rop_chain/rop_chain.c
	gcc -no-pie -fstack-protector-all ./3_rop_chain/rop_chain.c -o ./3_rop_chain/rop_chain
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./3_rop_chain/rop_chain

./4_libc_leak/libc_leak: ./4_libc_leak/libc_leak.c
	gcc -fstack-protector-all ./4_libc_leak/libc_leak.c -o ./4_libc_leak/libc_leak
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./4_libc_leak/libc_leak

.PHONY: all
all: ./0_ret2win/ret2win ./1_shellcode/shellcode ./2_bypass_canary/bypass_canary ./3_rop_chain/rop_chain ./4_libc_leak/libc_leak

.PHONY: clean
clean:
	rm -rf ./0_ret2win/ret2win ./1_shellcode/shellcode ./2_bypass_canary/bypass_canary ./3_rop_chain/rop_chain ./4_libc_leak/libc_leak

.PHONY: enable_aslr
enable_aslr:
	sudo bash -c 'echo 2 > /proc/sys/kernel/randomize_va_space'

.PHONY: disable_aslr
disable_aslr:
	sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space'
