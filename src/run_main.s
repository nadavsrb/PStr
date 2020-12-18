    .section    .rodata
.align  8   # Align address to multiple of 8

    .text   # beginning of the code:
    .globl  run_main # so, the linker would know this func
    .type   run_main, @function
run_main:
    # we wouldn't use %rbp but we will save the %rbp
    # for the func that called us.
    pushq	%r12        # callee save
    pushq	%r13        # callee save
    pushq	%r14        # callee save
    pushq	%r15        # callee save
    pushq	%rbp		# save the old frame pointer
	movq	%rsp, %rbp	# create the new frame pointer

    xorq    %r14, %r14  # initialize counter for scanning pstr.
    getPstr:
    dec     %rsp       
    movb    $0, (%rsp)      # we push the end of the pstr ('\0'==0)
    call    read_int        # read the pstr length
    subq    %rax, %rsp      # aading the space for the string
    dec     %rsp
    movb    %al, (%rsp)     # pushing the length
    movq    %rax, %r12      # saving length in callee save
    movq    $1, %r13        # initializing the counter to 1 (because from index 1 the string starts)
    getNextChar:
        cmp     %r13, %r12
        jb      checkContinue   # If i > n stop
        call    read_char       # read 1 char
        movb    %al, (%rsp, %r13)   # put the char in it's place in the memory

        inc     %r13            # ++i
        jmp     getNextChar
    checkContinue:
        cmpq    $0, %r14
        jne     stop            # If the second sptr scanned stop 
        movq    %rsp, %r15      # saving the pointer to the first pstr
        inc     %r14            # counter of the pstr scan ++
        jmp     getPstr         # get the second pstr               
    
    stop:
    movq    %rsp, %r14          # saving the pointer to the second pstr

    call    read_int            # getting the opt to run

    # setting args to run_func:
    movq    %rax, %rdi  # the opt to run
    movq    %r15, %rsi  # the first ptr pointer
    movq    %r14, %rdx  # the second ptr pointer
    call    run_func

    movq	%rbp, %rsp	# restore the old stack pointer - release all used memory.
	popq	%rbp		# restore old frame pointer (the caller function frame).
    popq	%r15        # restoring callee save.
    popq	%r14        # restoring callee save.
    popq    %r13        # restoring callee save
    popq    %r12        # restoring callee save.
	ret			# return to caller function.
