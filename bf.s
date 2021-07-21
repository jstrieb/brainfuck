.global _start

_start:
  /* Exit with code 0 */
  xor %rdi, %rdi
  mov $60, %rax  /* SYS_exit == 60 */
  syscall
