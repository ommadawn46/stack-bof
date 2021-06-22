from unittest import TestCase
import pwn
import time
import importlib

ret2win = __import__("0_ret2win.exploit").exploit
shellcode = __import__("1_shellcode.exploit").exploit
bypass_canary = __import__("2_bypass_canary.exploit").exploit
rop_chain = __import__("3_rop_chain.exploit").exploit
libc_leak = __import__("4_libc_leak.exploit").exploit
fsb_rop = __import__("5_fsb_rop.exploit").exploit


def check(exploit):
    importlib.reload(exploit)

    pwn.context.aslr = False  # ASLR disabled
    io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

    exploit.exploit(io)
    time.sleep(0.2)

    io.sendlines(["echo 'p'w'n'e'd'", "exit"])
    result = b"pwned" in io.recvuntil("pwned", timeout=1)

    return result


class TestExploitsNoAslr(TestCase):
    def test_ret2win(self):
        self.assertTrue(check(ret2win))

    def test_shellcode(self):
        self.assertTrue(check(shellcode))

    def test_bypass_canary(self):
        self.assertTrue(check(bypass_canary))

    def test_rop_chain(self):
        self.assertTrue(check(rop_chain))

    def test_libc_leak(self):
        self.assertTrue(check(libc_leak))

    def test_fsb_rop(self):
        self.assertTrue(check(fsb_rop))
