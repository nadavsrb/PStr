    .section    .rodata
.align  8   # Align address to multiple of 8

pInvalidOpt:    # the string when invalid option eas chosen.
.string "invalid option!\n"

pFormat50or60:  # the string format for printf in opt 50 or 60 in the switch.
.string "first pstring length: %d, second pstring length: %d\n"

sChar:      	# the string format for scanf to read single char.
.string " %c"

sInt:			# the string format for scanf to read single char.
.string " %d"

pFormat52:      # the string format for printf in opt 52 in the switch.
.string "old char: %c, new char: %c, first string: %s, second string: %s\n"

pFormat53and54: # the string format for printf in opt 53 and 53 in the switch.
.string "length: %d, string: %s\n"

pFormat55:      # the string format for printf in opt 55 in the switch.
.string "compare result: %d\n"

options:    # switch(opt)
.quad   opt50or60   # Case opt==50.
.quad   invalidOpt  # Case opt==51.
.quad   opt52       # Case opt==52.
.quad   opt53       # Case opt==53.
.quad   opt54       # Case opt==54.
.quad   opt55       # Case opt==55.
.quad   invalidOpt  # Case opt==56.
.quad   invalidOpt  # Case opt==57.
.quad   invalidOpt  # Case opt==58.
.quad   invalidOpt  # Case opt==59.
.quad   opt50or60   # Case opt==60.

    .text   # beginning of the code:
    .globl run_func # so, the linker would know this func
    .type   run_func, @function
run_func:
    # first lets save the pstring* args in callee-save
    # saves the reg state (we are callee of some func)
    pushq   %r12
    pushq   %r13

    # save the pstring* args:
    leaq (%rsi),  %r12
    leaq (%rdx),  %r13

    # Set up the jump table access
    # we do alignment so the switch would start from 0 as an array index:
    # we sub 50 because the first case in the switch is 50.
    leaq    -50(%rdi), %rdi     # Compute opt = opt - 50
    cmpq    $10, %rdi           # Compare opt:10 (the index in options are: 0-10)
    ja      invalidOpt          # if 10 < opt (= no index in array), then invalidOpt
    jmp     *options(, %rdi, 8) # else Goto options[8*opt], because every addrres is 8 bytes.

    # the switch's cases:
    opt50or60:
        # setting vars to printf:
        movq    %r12, %rdi              # puting the first pstr arg.
        call    pstrlen                 # getting the length of this pstr.
        movq    %rax, %rsi

        movq    %r13, %rdi              # puting the second pstr arg.
        call    pstrlen                 # getting the length of this pstr.
        movq    %rax, %rdx

        movq    $pFormat50or60, %rdi    # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        jmp     done    # Goto done
    opt52:
        # get & save the old char
        call    read_char
        pushq   %rax

        # get & save the new char
        call    read_char
        pushq   %rax

        # change the first pstr
        movq    %r12, %rdi          # get the pstr
        movq    (%rsp), %rdx        # get the new char
        movq    8(%rsp), %rsi       # get the old char
        call    replaceChar         # doesn't change %rdx, %rsi

        # change the second pstr
        movq    %r13, %rdi          # get the pstr
        movq    (%rsp), %rdx        # get the new char
        movq    8(%rsp), %rsi       # get the old char
        call    replaceChar

        popq    %rdx            # get the new char
        popq    %rsi            # get the old char

        # getting only the string (first byte- length)
        leaq    1(%r12), %rax
        movq    %rax, %rcx

        # getting only the string (first byte- length)
        leaq    1(%r13), %rax
        movq    %rax, %r8

        movq    $pFormat52, %rdi # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        jmp done    # Goto done
    opt53:
	    # get & save the start index
        call    read_int
        pushq   %rax

        # get & save the end index
        call    read_int
        pushq   %rax

        movq    %r12, %rdi  # get the dest pstr
        movq    %r13, %rsi  # get the src pstr
        popq    %rcx        # get the end index
        popq    %rdx        # get the start index
        call    pstrijcpy

        # print the dest
        movq    %r12, %rdi
        call    pstrlen     # getting the length of the dest.
        movq    %rax, %rsi  # getting the length as arg to printf.
        leaq    1(%r12), %rdx  # getting the string as arg to printf.
        movq    $pFormat53and54, %rdi # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        # print the src
        movq    %r13, %rdi
        call    pstrlen     # getting the length of the src.
        movq    %rax, %rsi  # getting the length as arg to printf.
        leaq    1(%r13), %rdx  # getting the string as arg to printf.
        movq    $pFormat53and54, %rdi # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        jmp done    # Goto done
    opt54:
        # swapping the first pstr:
        movq    %r12, %rdi
        call    swapCase

        movq    %r12, %rdi
        call    pstrlen     # gets the string length
        movq    %rax, %rsi  # put the string length as arg for printf.

        leaq    1(%r12), %rdx  # getting the string as arg to printf.
        movq    $pFormat53and54, %rdi # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        # swapping the second pstr:
        movq    %r13, %rdi
        call    swapCase

        movq    %r13, %rdi
        call    pstrlen     # gets the string length
        movq    %rax, %rsi  # put the string length as arg for printf.

        leaq    1(%r13), %rdx  # getting the string as arg to printf.
        movq    $pFormat53and54, %rdi # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        jmp done    # Goto done
    opt55:
        # get & save the start index
        call    read_int
        pushq   %rax

        # get & save the end index
        call    read_int
        pushq   %rax
        
        movq    %r12, %rdi  # get pstr1
        movq    %r13, %rsi  # get pstr2
        popq    %rcx        # get the end index
        popq    %rdx        # get the start index
        call    pstrijcmp

        # print the result:
        movq    %rax, %rsi          # getting the cmp result as arg to printf.
        movq    $pFormat55, %rdi    # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf

        jmp     done
    invalidOpt:
        movq    $pInvalidOpt, %rdi # setting the format.
        # calling printf
        xorq    %rax, %rax # initializing %rax to 0.
        call    printf
        # no need jmp because done is right after.
    done:
        # restore callee reg
        popq    %r13
        popq    %r12

        ret # returning from the func.

    .type   read_char, @function
read_char:
	# save callee save we would use
	pushq	%r12
    # setting vars to scanf:
    
	movq	$1, %rdi		# char needs 1 byte.
	movq    $continue1, %rsi
	jmp    round_rsp		# adding place to data.
	continue1:
    
	movq    %rax, %r12		# saving how mach we need to return.
    leaq    (%rsp), %rsi	# were to put the read data.

	movq    $sChar, %rdi    # setting the format.

    # calling scanf for first char
    xorq    %rax, %rax # initializing %rax to 0.
    call    scanf

    # get the char:
    movsbl  (%rsp), %eax

	# delete the data from the stack
    addq    %r12, %rsp

	# restore callee save we have used.
	popq	%r12
    ret

    .type   read_char, @function
read_int:
	# save callee save we would use
	pushq	%r12
    # setting vars to scanf:
    
	movq	$4, %rdi		# int needs 4 byte.
	movq    $continue2, %rsi
	jmp    round_rsp		# adding place to data.
	continue2:
    
	movq    %rax, %r12		# saving how mach we need to return.
    leaq    (%rsp), %rsi	# were to put the read data.

	movq    $sInt, %rdi    # setting the format.

    # calling scanf for first char
    xorq    %rax, %rax # initializing %rax to 0.
    call    scanf

    # get the int:
    movslq  (%rsp), %rax

	# delete the data from the stack
    addq    %r12, %rsp

	# restore callee save we have used.
	popq	%r12
    ret

round_rsp:  # rounds %rsp to the next 16th mult.
	# first we want the next rsp so we dec 1:
	subq %rdi, %rsp

    # compute modulo a power of two,
	# using bitwise AND:
	# If b is a power of two, a % b == a & (b - 1).
	# in our case b = 16-1 = 15:
	movq $15, %rax
	andq %rsp, %rax
    subq %rax, %rsp

    addq %rdi, %rax      # we add how match we add at the first line.
    jmp *%rsi


