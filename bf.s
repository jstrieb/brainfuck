/***
 * Created by Jacob Strieb
 * July 2021
 */

.global _start

_start:
  /* Make space on the stack for the program memory */
  movq %rsp, %rbp
  subq $30000, %rsp  /* 30000 = 3750 x 8  =>  rsp is address-aligned */

  /* r14 holds the data pointer and r15 holds the code pointer */
  movq %rbp, %r14
  leaq -8(%rsp), %r15

  /* Zero out the Brainfuck program memory 8 bytes at a time */
  movq %rbp, %rdi
.L0:
  subq $8, %rdi
  movq $0, (%rdi)
  cmpq %rdi, %rsp
  jne .L0

  /* Read all code from standard input onto the stack (reversed)  */
  subq $8, %rsp
.L1:
  xorq %rdi, %rdi    /* stderr is file descriptor 0 */
  movq %rsp, %rsi
  movq $1, %rdx
  xorq %rax, %rax    /* SYS_read == 0 */
  syscall
  subq $1, %rsp

  test %eax, %eax
  jnz .L1

  /* Execute the code */

  /* Exit with code 0 */
  xor %rdi, %rdi
  mov $60, %rax  /* SYS_exit == 60 */
  syscall
