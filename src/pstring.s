    .section    .rodata
.align  8   # Align address to multiple of 8

pInvalid:
.string "invalid input!\n"

    .text   # beginning of the code:
    .globl pstrlen # so, the linker would know this func
    .type   pstrlen, @function
pstrlen:
    # the length is the first byte
    # we would extends this length to the register,
    # notice that the length should always be positive
    # so we would extends it in unsigned (0 fill)
    xorq %rax, %rax
    movb (%rdi), %al
    ret

    .globl  replaceChar # so, the linker would know this func
    .type   replaceChar, @function
replaceChar:
    call    pstrlen     # getting the length of the pstr
    movq    %rax, %r8   # saving the length

    xorq    %rcx, %rcx  # initialize the counter to zero

    cmp     %rcx, %r8
    ja      loop1       # if i < n continue to loop.
    jmp     lend1       # else break out from loop.

    loop1:
        cmpb    %sil, 1(%rdi,%rcx)  # compare the next pstr char to old char.
        jne     continue1           # if not equals continue.
        movb    %dl, 1(%rdi,%rcx)   # if equals change the char.

        continue1:
        inc     %rcx
        cmp     %rcx, %r8
        ja      loop1       # if i < n continue to loop.
        # Else break out from loop:
    lend1:
    movq    %rdi, %rax  # return the pstr
    ret

    .globl  pstrijcpy # so, the linker would know this func
    .type   pstrijcpy, @function
pstrijcpy:
    # check valid: 0<=i<=j<lengths
    cmpb    $0, %dl
    jl      invalid1    # If 0 > i

    cmpb    %dl, %cl
    jl      invalid1    # If i > j

    call    pstrlen
    cmpb    %cl, %al     
    jle     invalid1   # If dest-len <= j

    pushq   %rdi       # saving dest-pstr

    movq    %rsi, %rdi
    call    pstrlen
    popq    %rdi       # restoring dest-pstr
    cmpb    %cl, %al     
    jle     invalid1   # If src-len <= j

    # If we got here the input is valid:
    loop2:
        movb    1(%rsi, %rdx), %r8b     # get the i char.
        movb    %r8b, 1(%rdi,%rdx)      # copy to the dest loc the char.
        inc     %dl                     # ++i
        cmpb    %dl, %cl
        jb      lend2                   # If j < i, end.
        jmp     loop2

    invalid1:
    movq    $pInvalid, %rdi # setting the format
    call    printf
    lend2:
    movq    %rdi, %rax      # return the dst pstr
    ret

    .globl  swapCase # so, the linker would know this func
    .type   swapCase, @function
swapCase:
    xorq    %rcx, %rcx  # initialize the counter

    call    pstrlen
    movq    %rax, %rsi  # saving the len

    cmpb    %cl, %sil
    jle     lend3       # if no i<n go to end.

    # calculating the convert const:
    movq    $'A', %r15
    subq    $'a', %r15
    loop3:
        # check if the char is between a-b
        cmpb    $'a', 1(%rdi, %rcx)
        jb      nextCheck
        cmpb    $'z', 1(%rdi, %rcx)
        ja      nextCheck
        
        # converting to UPPER CASE:
        movq    1(%rdi, %rcx), %r14
        addq    %r15, %r14
        movq    %r14, 1(%rdi, %rcx)

        jmp     continue3
        nextCheck:
        # check if the char is between A-B
        cmpb    $'A', 1(%rdi, %rcx)
        jb      continue3
        cmpb    $'Z', 1(%rdi, %rcx)
        ja      continue3

        # converting to LOWER CASE:
        movq    1(%rdi, %rcx), %r14
        subq    %r15, %r14
        movq    %r14, 1(%rdi, %rcx)
        continue3:
        inc     %cl         # ++i
        cmpb    %cl, %sil
        ja     loop3        # if i < n go to loop.
    lend3:
    movq    %rdi, %rax  # return the pstr
    ret

.globl  pstrijcmp # so, the linker would know this func
    .type   pstrijcmp, @function
pstrijcmp:
    # check valid: 0<=i<=j<lengths
    cmpb    $0, %dl
    jl      invalid2    # If 0 > i

    cmpb    %dl, %cl
    jl      invalid2    # If i > j

    call    pstrlen
    cmpb    %cl, %al     
    jle     invalid2   # If pstr1-len <= j

    pushq   %rdi       # saving pstr1

    movq    %rsi, %rdi
    call    pstrlen
    popq    %rdi       # restoring pstr1
    cmpb    %cl, %al     
    jle     invalid2   # If pstr2 <= j

    # If we got here the input is valid:

    loop4:
        movb    1(%rsi, %rdx), %r8b     # get the i char, in pstr2.

        cmpb    %r8b, 1(%rdi,%rdx)
        ja      pstr1Big                # If pstr1 > pstr2 (lexicographic...)
        jb      pstr2Big                # If pstr1 < pstr2 (lexicographic...)

        inc     %dl                     # ++i
        cmpb    %dl, %cl
        jb      equals                   # If j < i, end as equals.
        jmp     loop4
    
    pstr1Big:
    movq    $1, %rax    # return 1, pstr1 > pstr2 (lexicographic...)
    ret
    pstr2Big:
    movq    $-1, %rax    # return -1, pstr1 < pstr2 (lexicographic...)
    ret
    equals:
    xorq    %rax, %rax  # return 0 for equals.
    ret

    invalid2:
    movq    $pInvalid, %rdi # setting the format
    call    printf
    movq    $-2, %rax       # the invalid status is -2.
    ret
