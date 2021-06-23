import time
from unittest import TestCase

import pwn


def exploitable(exploit):
    pwn.context.aslr = False  # ASLR disabled

    elf = pwn.context.binary = pwn.ELF(exploit.elf_path)
    libc = pwn.ELF(exploit.libc_path)
    io = pwn.process(elf.path, cwd=exploit.script_dir)

    exploit.exploit(io, elf=elf, libc=libc)
    time.sleep(0.2)

    io.sendlines(["echo 'p'w'n'e'd'", "exit"])
    result = b"pwned" in io.recvuntil("pwned", timeout=1)

    return result


class TestExploitsNoAslr(TestCase):
    def test_ret2win(self):
        exploit = __import__("0_ret2win.exploit").exploit
        self.assertTrue(exploitable(exploit))

    def test_shellcode(self):
        exploit = __import__("1_shellcode.exploit").exploit
        self.assertTrue(exploitable(exploit))

    def test_bypass_canary(self):
        exploit = __import__("2_bypass_canary.exploit").exploit
        self.assertTrue(exploitable(exploit))

    def test_rop_chain(self):
        exploit = __import__("3_rop_chain.exploit").exploit
        self.assertTrue(exploitable(exploit))

    def test_libc_leak(self):
        exploit = __import__("4_libc_leak.exploit").exploit
        self.assertTrue(exploitable(exploit))

    def test_fsb_rop(self):
        exploit = __import__("5_fsb_rop.exploit").exploit
        self.assertTrue(exploitable(exploit))
