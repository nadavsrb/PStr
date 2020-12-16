	.section	.rodata
.align	8	# Align address to multiple of 8
options:	# switch(opt)
.quad	opt50or60	# Case opt==50.
.quad	done		# Case opt==51.
.quad	opt52		# Case opt==52.
.quad	opt53		# Case opt==53.
.quad	opt54		# Case opt==54.
.quad	opt55		# Case opt==55.
.quad	done		# Case opt==56.
.quad	done		# Case opt==57.
.quad	done		# Case opt==58.
.quad	done		# Case opt==59.
.quad	opt50or60	# Case opt==60.

	.text	# beginning of the code:
	.globl run_func	# so, the linker would know this func
	.type	run_func, @function
run_func:
	# Set up the jump table access
	# we do alignment so the switch would start from 0 as an array index:
	# we sub 50 because the first case in the switch is 50.
	leaq	-50(%rdi),%rdi		# Compute opt = opt - 50

	cmpq	$10,%rsi			# Compare opt:10
	ja		done				# if opt > 10, then done
	jmp		*options(,%rsi,8) 	# else Goto options[8*opt], because every addrres is 8 bytes.

	# the switch's cases:
	opt50or60:
		jmp	done	# Goto done
	opt52:
		jmp	done	# Goto done
	opt53:
		jmp	done	# Goto done
	opt54:
		jmp	done	# Goto done
	opt55:
		# no need jmp because done is right after.
	done:
		ret	# returning from the func.
