./0_ret2win/ret2win: ./0_ret2win/ret2win.c
	# no canary, nx disabled, no pie, partial relro
	gcc -no-pie -fno-stack-protector -z execstack -Wl,-z,relro,-z,lazy ./0_ret2win/ret2win.c -o ./0_ret2win/ret2win
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./0_ret2win/ret2win

./1_shellcode/shellcode: ./1_shellcode/shellcode.c
	# no canary, nx disabled, no pie, partial relro
	gcc -no-pie -fno-stack-protector -z execstack -Wl,-z,relro,-z,lazy ./1_shellcode/shellcode.c -o ./1_shellcode/shellcode
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./1_shellcode/shellcode

./2_bypass_canary/bypass_canary: ./2_bypass_canary/bypass_canary.c
	# nx disabled, no pie, partial relro
	gcc -no-pie -fstack-protector-all -z execstack -Wl,-z,relro,-z,lazy ./2_bypass_canary/bypass_canary.c -o ./2_bypass_canary/bypass_canary
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./2_bypass_canary/bypass_canary

./3_rop_chain/rop_chain: ./3_rop_chain/rop_chain.c
	# no pie, partial relro
	gcc -no-pie -fstack-protector-all -Wl,-z,relro,-z,lazy ./3_rop_chain/rop_chain.c -o ./3_rop_chain/rop_chain
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./3_rop_chain/rop_chain

./4_libc_leak/libc_leak: ./4_libc_leak/libc_leak.c
	# partial relro
	gcc -fstack-protector-all -Wl,-z,relro,-z,lazy ./4_libc_leak/libc_leak.c -o ./4_libc_leak/libc_leak
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./4_libc_leak/libc_leak

./5_got_overwrite/got_overwrite: ./5_got_overwrite/got_overwrite.c
	# partial relro
	gcc -fstack-protector-all -Wl,-z,relro,-z,lazy ./5_got_overwrite/got_overwrite.c -o ./5_got_overwrite/got_overwrite
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./5_got_overwrite/got_overwrite

./6_fsb_rop/fsb_rop: ./6_fsb_rop/fsb_rop.c
	# full relro
	gcc -fstack-protector-all -Wl,-z,relro,-z,now ./6_fsb_rop/fsb_rop.c -o ./6_fsb_rop/fsb_rop
	patchelf --set-rpath ../.lib/ --set-interpreter ../.lib/ld-linux-x86-64.so.2 ./6_fsb_rop/fsb_rop

.PHONY: all
all: ./0_ret2win/ret2win \
	./1_shellcode/shellcode \
	./2_bypass_canary/bypass_canary \
	./3_rop_chain/rop_chain \
	./4_libc_leak/libc_leak \
	./5_got_overwrite/got_overwrite \
	./6_fsb_rop/fsb_rop

.PHONY: clean
clean:
	rm -rf \
		./0_ret2win/ret2win \
		./1_shellcode/shellcode \
		./2_bypass_canary/bypass_canary \
		./3_rop_chain/rop_chain \
		./4_libc_leak/libc_leak \
		./5_got_overwrite/got_overwrite \
		./6_fsb_rop/fsb_rop

.PHONY: enable_aslr
enable_aslr:
	sudo bash -c 'echo 2 > /proc/sys/kernel/randomize_va_space'

.PHONY: disable_aslr
disable_aslr:
	sudo bash -c 'echo 0 > /proc/sys/kernel/randomize_va_space'
