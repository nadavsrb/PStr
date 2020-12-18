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
