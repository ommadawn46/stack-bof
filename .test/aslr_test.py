import time
from unittest import TestCase

import pwn


def exploitable(exploit):
    pwn.context.aslr = True  # ASLR enabled

    elf = pwn.context.binary = pwn.ELF(exploit.elf_path)
    libc = pwn.ELF(exploit.libc_path)
    io = pwn.process(elf.path, cwd=exploit.script_dir)

    exploit.exploit(io, elf=elf, libc=libc)
    time.sleep(0.2)

    io.sendlines(["echo 'p'w'n'e'd'", "exit"])
    result = b"pwned" in io.recvuntil("pwned", timeout=1)

    return result


# When ASLR is enabled, some tests will fail probabilistically.
# It's not pretty, but if it succeeds within 10 times, the tests shall pass.
class TestExploitsAslr(TestCase):
    def test_ret2win(self):
        exploit = __import__("0_ret2win.exploit").exploit
        self.assertTrue(exploitable(exploit))

    def test_shellcode(self):
        exploit = __import__("1_shellcode.exploit").exploit
        with self.assertRaises(EOFError):
            exploitable(exploit)

    def test_bypass_canary(self):
        exploit = __import__("2_bypass_canary.exploit").exploit
        with self.assertRaises(EOFError):
            exploitable(exploit)

    def test_rop_chain(self):
        exploit = __import__("3_rop_chain.exploit").exploit
        with self.assertRaises(EOFError):
            exploitable(exploit)

    def test_libc_leak(self):
        exploit = __import__("4_libc_leak.exploit").exploit
        for i in range(10):
            try:
                self.assertTrue(exploitable(exploit))
                break
            except Exception:
                pass
        else:
            raise

    def test_fsb_rop(self):
        exploit = __import__("5_fsb_rop.exploit").exploit
        for i in range(10):
            try:
                self.assertTrue(exploitable(exploit))
                break
            except Exception:
                pass
        else:
            raise
