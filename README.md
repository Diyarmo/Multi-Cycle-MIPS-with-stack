# Multi-Cycle-MIPS-with-stack


In  this project we have desigend a Multi cycle stack-based proccessor

This proccessor supports 8 commands

ADD 	==> Which pops two top elements of stack and pushes sum of them into stack

SUM 	==> Which pops two top elements of stack and pushes subtract of them into stack

AND 	==> Which pops two top elements of stack and pushes bitwise and of them into stack

NOT 	==> Which pops the top element of stack and pushes its bitwise into stack

PUSH i 	==> Which pushes i-th element of memory into stack

POP i 	==> Which pops the top element of stack and saves it on i-th element of memory

JMP i 	==> Which jumps to i-th instruction

JZ i 	==> Which jumps to -ith instruction if top element of stack is zero
