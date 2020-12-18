    .section    .rodata
.align  8   # Align address to multiple of 8

pInvalid:
.string "invalid option!\n"

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
