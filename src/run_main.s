    .section    .rodata # read only data section
    .align  8   # Align address to multiple of 8

sChar:      	# the string format for scanf to read single char.
    .string " %c"

sInt:			# the string format for scanf to read single int.
    .string "%d"

    .text   # beginning of the code:

# this func get from the user two pstr & opt and run the opt
# on the pstr by run_func.
    .globl  run_main    # so, the linker would know this func
    .type   run_main, @function
run_main:
    pushq	%r12    # callee save
    pushq	%r13    # callee save
    pushq	%r14    # callee save
    pushq	%r15    # callee save
    pushq	%rbp    # save the old frame pointer
	movq	%rsp, %rbp  # create the new frame pointer

    xorq    %r14, %r14  # initialize counter to 0 for scanning pstr.
getPstr:    # label to get one pstr.
    dec     %rsp    # we add place to '\0' in the pstr.
    movb    $0, (%rsp)  # we push the end of the pstr ('\0'==0)
    call    read_int    # read the pstr length
    subq    %rax, %rsp  # aading the space for the string
    dec     %rsp    # we add place to the size of the pstr
    movb    %al, (%rsp) # pushing the length
    movq    %rax, %r12  # saving length in callee save
    movq    $1, %r13    # initializing the counter to 1 (because from index 1 the string starts)
getNextChar:    # label to read the next char of the pstr from the client.
    cmp     %r13, %r12
    jb      checkContinue   # If i > n we stop this pstr and ggo to the next one.
    call    read_char   # read 1 char
    movb    %al, (%rsp, %r13)   # put the char in it's place in the memory

    inc     %r13    # ++i
    jmp     getNextChar # gets the next char.
checkContinue:  # check if we can stop or get the next pstr from the user.
    cmpq    $1, %r14    # if %r14 is 1 we got two pstr from the user and should stop.
    je      stop    # If the second sptr scanned stop 
    movq    %rsp, %r15  # saving the pointer to the first pstr
    inc     %r14    # counter of the pstr scan ++
    jmp     getPstr # get the second pstr               
    
stop:
    movq    %rsp, %r14  # saving the pointer to the second pstr

    call    read_int    # getting the opt to run

    # setting args to run_func:
    movq    %rax, %rdi  # the opt to run
    movq    %r15, %rsi  # the first ptr pointer
    movq    %r14, %rdx  # the second ptr pointer
    call    run_func    # run the run_func on the inputs.

    movq	%rbp, %rsp  # restore the old stack pointer - release all used memory.
	popq	%rbp    # restore old frame pointer (the caller function frame).
    popq	%r15    # restoring callee save.
    popq	%r14    # restoring callee save.
    popq    %r13    # restoring callee save
    popq    %r12    # restoring callee save.
	ret	    # return to caller function.

# this func reads one char and return it. 
    .type   read_char, @function
read_char:
	pushq	%r12    # save callee save we would use
    pushq	%rbp    # save the old frame pointer
	movq	%rsp, %rbp  # create the new frame pointer

    # setting space to scanf:
	movq	$1, %rdi    # char needs 1 byte.
	movq    $continue1, %rsi    # we put the loc we want to ret to.
	jmp    round_rsp    # adding place to data.

continue1:
    # setting vars to scanf:
    leaq    (%rsp), %rsi	# were to put the read data.
	movq    $sChar, %rdi    # setting the format.

    # calling scanf:
    xorq    %rax, %rax # initializing %rax to 0.
    call    scanf

    # get the char:
    movsbl  (%rsp), %eax

    movq	%rbp, %rsp  # restore the old stack pointer - release all used memory.
	popq	%rbp    # restore old frame pointer (the caller function frame).
	popq	%r12    # restore callee save we have used.
    ret

# this func reads one int and return it. 
    .type   read_int, @function
read_int:
	pushq	%r12    # save callee save we would use
    pushq	%rbp    # save the old frame pointer
	movq	%rsp, %rbp  # create the new frame pointer

    # setting space to scanf:
	movq	$4, %rdi		# int needs 4 byte.
	movq    $continue2, %rsi    # the place to return to.
	jmp    round_rsp		# adding place to data.

continue2:
    # setting vars to scanf:
    leaq    (%rsp), %rsi	# were to put the read data.
	movq    $sInt, %rdi    # setting the format.

    # calling scanf for first char
    xorq    %rax, %rax  # initializing %rax to 0.
    call    scanf

    # get the int:
    movslq  (%rsp), %rax

    movq	%rbp, %rsp  # restore the old stack pointer - release all used memory.
	popq	%rbp    # restore old frame pointer (the caller function frame).
	popq	%r12    # restore callee save we have used.
    ret

# this label is a peace of code that rounds %rsp to the next 16th mult
# that contain at list enough bytes as specify in %rdi.
# and then to run the code to the place %rsi points to.
# this code is to prepare the stack for scanf func.
# it also returns the num of bytes we added to the stack (in %rax).
round_rsp:
	# first we want the next rsp that contains enough bytes,
    # so we add the space:
	subq %rdi, %rsp

    # compute modulo a power of two,
	# using bitwise AND:
	# If b is a power of two, a % b == a & (b - 1).
	# in our case b = 16-1 = 15:
	movq $15, %rax
	andq %rsp, %rax

    subq %rax, %rsp # we add the space to the stack.

    addq %rdi, %rax      # we add how match we add at the first line.
    jmp *%rsi   # jmp to were we told to.
