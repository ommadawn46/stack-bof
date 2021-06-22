from unittest import TestCase
import pwn
import time
import importlib

libc_leak = __import__("4_libc_leak.exploit").exploit
fsb_rop = __import__("5_fsb_rop.exploit").exploit


def check(exploit):
    importlib.reload(exploit)

    pwn.context.aslr = True  # ASLR enabled
    io = pwn.process(exploit.elf.path, cwd=exploit.script_dir)

    exploit.exploit(io)
    time.sleep(0.2)

    io.sendlines(["echo 'p'w'n'e'd'", "exit"])
    result = b"pwned" in io.recvuntil("pwned", timeout=1)

    return result


# If ASLR is enabled, the execution will fail probabilistically.
# It's not pretty, but if it succeeds within 10 times, the test shall pass.
class TestExploitsAslr(TestCase):
    def test_libc_leak(self):
        for i in range(10):
            try:
                self.assertTrue(check(libc_leak))
                break
            except:
                pass
        else:
            raise

    def test_fsb_rop(self):
        for i in range(10):
            try:
                self.assertTrue(check(fsb_rop))
                break
            except:
                pass
        else:
            raise
