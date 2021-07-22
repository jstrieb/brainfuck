.global _start

_start:
  /* Make space on the stack for the program memory */
  pushq %rbp
  movq %rsp, %rbp
  subq $30000, %rsp

  /* Zero out the Brainfuck program memory */
  movq %rbp, %rdi
.L0:
  subq $1, %rdi
  movb $0, (%rdi)
  cmpq %rdi, %rsp
  jne .L0

  /* Read in all of the code from the standard input onto the stack */

  /* Execute the code */

  /* Exit with code 0 */
  xor %rdi, %rdi
  mov $60, %rax  /* SYS_exit == 60 */
  syscall
