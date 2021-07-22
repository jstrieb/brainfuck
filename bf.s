/***
 * Created by Jacob Strieb
 * July 2021
 */

.global _start

_start:
  /* Make space on the stack for the program memory */
  mov %rsp, %rbp
  sub $30000, %rsp  /* 30000 = 3750 x 8  =>  rsp is address-aligned */

  /* r14 holds the data pointer and r15 holds the code pointer */
  mov %rbp, %r14
  lea -8(%rsp), %r15

  /* Zero out the Brainfuck program memory 8 bytes at a time */
  mov %rbp, %rdi
.L0:
  sub $8, %rdi
  movq $0, (%rdi)
  cmp %rdi, %rsp
  jne .L0

  /* Read all code from standard input onto the stack (reversed)  */
  sub $8, %rsp
.L1:
  xor %rdi, %rdi    /* stderr is file descriptor 0 */
  mov %rsp, %rsi
  mov $1, %rdx
  xor %rax, %rax    /* SYS_read == 0 */
  syscall
  sub $1, %rsp

  test %eax, %eax
  jnz .L1

  /* Execute the code */

  /* Exit with code 0 */
  xor %rdi, %rdi
  mov $60, %rax  /* SYS_exit == 60 */
  syscall
