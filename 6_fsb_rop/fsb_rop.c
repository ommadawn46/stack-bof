#include <stdio.h>

void vuln()
{
    char buf[64];
    while (1)
    {
        fgets(buf, sizeof(buf), stdin); // no bof
        printf(buf);
    }
}

int main(void)
{
    vuln();
    return 0;
}
