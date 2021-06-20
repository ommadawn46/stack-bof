from unittest import TestCase
import pwn


class TestExploits(TestCase):
    def test_ret2win(self):
        exploit = __import__("0_ret2win.exploit").exploit
        pwn.context.aslr = True
        io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

        exploit.exploit(io)
        io.sendline("echo pwned")
        self.assertTrue(b"pwned" in io.recvuntil("pwned", timeout=1))

    def test_shellcode(self):
        exploit = __import__("1_shellcode.exploit").exploit
        pwn.context.aslr = False
        io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

        exploit.exploit(io)
        io.sendline("echo pwned")
        self.assertTrue(b"pwned" in io.recvuntil("pwned", timeout=1))

    def test_bypass_canary(self):
        exploit = __import__("2_bypass_canary.exploit").exploit
        pwn.context.aslr = False
        io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

        exploit.exploit(io)
        io.sendline("echo pwned")
        self.assertTrue(b"pwned" in io.recvuntil("pwned", timeout=1))

    def test_rop_chain(self):
        exploit = __import__("3_rop_chain.exploit").exploit
        pwn.context.aslr = False
        io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

        exploit.exploit(io)
        io.sendline("echo pwned")
        self.assertTrue(b"pwned" in io.recvuntil("pwned", timeout=1))

    def test_libc_leak(self):
        exploit = __import__("4_libc_leak.exploit").exploit
        pwn.context.aslr = True
        io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

        exploit.exploit(io)
        io.sendline("echo pwned")
        self.assertTrue(b"pwned" in io.recvuntil("pwned", timeout=1))
