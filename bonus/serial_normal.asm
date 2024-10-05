	.file	"serial.cpp"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"void Serial::ForwardElimination(double*, double*, int, int)"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"serial.cpp"
.LC3:
	.string	"diag_elem!=0"
	.text
	.p2align 4
	.globl	_ZN6Serial18ForwardEliminationEPdS0_ii
	.type	_ZN6Serial18ForwardEliminationEPdS0_ii, @function
_ZN6Serial18ForwardEliminationEPdS0_ii:
.LFB7388:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 48(%rsp)
	testl	%edx, %edx
	jle	.L12
	leal	1(%rdx), %eax
	movslq	%edx, %r11
	movl	$1, %r15d
	movq	%rsi, %r9
	movl	%eax, 36(%rsp)
	leal	-2(%rcx), %eax
	movl	%edx, %ebp
	movl	%ecx, %r13d
	movl	%eax, 32(%rsp)
	leaq	1(%r11), %rax
	xorl	%ebx, %ebx
	leaq	0(,%r11,8), %r10
	movq	%rax, 40(%rsp)
	leaq	16(%rdi), %rax
	vxorpd	%xmm3, %xmm3, %xmm3
	movq	%r11, 24(%rsp)
	movq	%r11, 16(%rsp)
	movl	$0, 12(%rsp)
	movl	$0, 8(%rsp)
	movq	%rax, 56(%rsp)
	cmpq	%r11, %r15
	je	.L12
.L16:
	movl	12(%rsp), %esi
	movslq	8(%rsp), %rax
	movq	%r15, %r12
	movq	%r15, %r8
	movq	48(%rsp), %rdx
	movq	24(%rsp), %r14
	subq	%rbx, %r12
	movslq	%esi, %rcx
	addl	%ebp, %esi
	subq	16(%rsp), %rcx
	salq	$3, %r12
	leaq	(%rdx,%rax,8), %rdi
	movl	32(%rsp), %eax
	movl	%esi, 12(%rsp)
	leaq	(%rdx,%r14,8), %rdx
	movq	56(%rsp), %rsi
	addq	%r14, %rax
	movl	%r15d, %r14d
	leaq	(%rsi,%rax,8), %rsi
	.p2align 4,,10
	.p2align 3
.L7:
	cmpl	%r14d, %r13d
	jle	.L3
	leaq	(%rdx,%r12), %rax
	.p2align 4,,10
	.p2align 3
.L6:
	vmovsd	(%rdi), %xmm1
	vucomisd	%xmm3, %xmm1
	jp	.L4
	je	.L15
.L4:
	vmovsd	(%rdx), %xmm0
	vdivsd	%xmm1, %xmm0, %xmm0
	vmovsd	(%rax), %xmm1
	vmulsd	(%rax,%rcx,8), %xmm0, %xmm2
	addq	$8, %rax
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovsd	%xmm1, -8(%rax)
	cmpq	%rax, %rsi
	jne	.L6
.L3:
	vmulsd	(%r9,%rbx,8), %xmm0, %xmm2
	vmovsd	(%r9,%r8,8), %xmm1
	subq	%r11, %rcx
	addq	%r10, %rsi
	vsubsd	%xmm2, %xmm1, %xmm1
	vmovsd	%xmm1, (%r9,%r8,8)
	addq	$1, %r8
	movq	$0x000000000, (%rdx)
	addq	%r10, %rdx
	cmpl	%r8d, %ebp
	jg	.L7
	addq	$1, %r15
	movl	36(%rsp), %edi
	addq	%r11, 16(%rsp)
	addq	$1, %rbx
	addl	%edi, 8(%rsp)
	movq	40(%rsp), %rdi
	subl	$1, 32(%rsp)
	addq	%rdi, 24(%rsp)
	cmpq	%r11, %r15
	jne	.L16
.L12:
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L15:
	.cfi_restore_state
	leaq	.LC1(%rip), %rcx
	movl	$27, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	__assert_fail@PLT
	.cfi_endproc
.LFE7388:
	.size	_ZN6Serial18ForwardEliminationEPdS0_ii, .-_ZN6Serial18ForwardEliminationEPdS0_ii
	.section	.rodata.str1.8
	.align 8
.LC4:
	.string	"void Serial::ForwardEliminationOptimized(double*, double*, uint_fast32_t, uint_fast32_t)"
	.text
	.p2align 4
	.globl	_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm
	.type	_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm, @function
_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm:
.LFB7389:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-32, %rsp
	subq	$192, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rsi, 168(%rsp)
	movq	%rcx, 128(%rsp)
	testq	%rdx, %rdx
	je	.L48
	movq	%rdi, %r13
	leaq	1(%rdx), %rax
	movq	%rcx, %rdi
	movq	%rdx, %r15
	movq	%rax, 24(%rsp)
	leaq	8(%r13), %r14
	movq	%rdx, %r12
	vxorpd	%xmm4, %xmm4, %xmm4
	leaq	0(,%rax,8), %rbx
	leaq	0(,%rcx,8), %rax
	movq	%r13, %rcx
	movq	%rdi, 152(%rsp)
	negq	%rcx
	movq	%rbx, 16(%rsp)
	movq	%rcx, 40(%rsp)
	leaq	-1(%rdi), %rcx
	movq	%rcx, 112(%rsp)
	leaq	-8(%rbx), %rcx
	leaq	-8(%r13,%rcx), %rdi
	addq	%rcx, %rsi
	movq	%r13, 48(%rsp)
	movq	%rdi, 8(%rsp)
	leaq	(%rdx,%rdx), %rdi
	movq	%rcx, 136(%rsp)
	movq	%rsi, 144(%rsp)
	movq	$0, 160(%rsp)
	movq	$16, 32(%rsp)
	movq	$0, 176(%rsp)
	movq	%rdi, (%rsp)
	.p2align 4,,10
	.p2align 3
.L30:
	movq	48(%rsp), %rdi
	vmovsd	(%rdi), %xmm3
	vucomisd	%xmm4, %xmm3
	jp	.L19
	je	.L50
.L19:
	movq	176(%rsp), %rsi
	leaq	1(%rsi), %r10
	cmpq	%r10, %r15
	je	.L47
	subq	$8, %rax
	movq	112(%rsp), %rbx
	movq	%r15, %r8
	movq	%r12, %rdi
	movq	%rax, 64(%rsp)
	movq	8(%rsp), %rdx
	negq	%r8
	subq	%r15, %rdi
	movq	152(%rsp), %r11
	movq	168(%rsp), %rsi
	addq	32(%rsp), %rdx
	leaq	-1(%r11), %rax
	leaq	(%rsi,%r10,8), %rcx
	movq	%rax, 56(%rsp)
	leaq	-2(%r11), %rsi
	movq	40(%rsp), %rax
	movq	%rsi, 104(%rsp)
	movq	%rbx, %rsi
	andq	$-4, %rbx
	subq	$16, %rax
	subq	%rbx, %r11
	leaq	(%r10,%rbx), %r9
	movq	%rbx, 96(%rsp)
	movq	%rax, 120(%rsp)
	leaq	-1(%r11), %rax
	shrq	$2, %rsi
	movq	%r9, 88(%rsp)
	salq	$5, %rsi
	movq	%r11, 80(%rsp)
	movq	%rax, 72(%rsp)
	.p2align 4,,10
	.p2align 3
.L29:
	movq	176(%rsp), %rax
	vmovsd	-8(%rdx), %xmm1
	leaq	(%r12,%rax), %r9
	vdivsd	%xmm3, %xmm1, %xmm1
	cmpq	128(%rsp), %r10
	jnb	.L21
	movq	120(%rsp), %rax
	addq	%rdx, %rax
	cmpq	$16, %rax
	jbe	.L32
	cmpq	$2, 152(%rsp)
	je	.L32
	cmpq	$2, 104(%rsp)
	jbe	.L23
	vmovddup	%xmm1, %xmm2
	xorl	%eax, %eax
	vinsertf128	$1, %xmm2, %ymm2, %ymm2
	.p2align 4,,10
	.p2align 3
.L24:
	vmulpd	(%r14,%rax), %ymm2, %ymm0
	vmovupd	(%rdx,%rax), %ymm5
	vsubpd	%ymm0, %ymm5, %ymm0
	vmovupd	%ymm0, (%rdx,%rax)
	addq	$32, %rax
	cmpq	%rsi, %rax
	jne	.L24
	movq	96(%rsp), %rbx
	movq	112(%rsp), %rax
	cmpq	%rax, %rbx
	je	.L21
	cmpq	$2, 80(%rsp)
	movq	72(%rsp), %r11
	movq	88(%rsp), %rax
	je	.L26
	movq	%rax, 184(%rsp)
.L31:
	movq	160(%rsp), %rax
	leaq	1(%r9,%rbx), %r9
	vmovddup	%xmm1, %xmm0
	leaq	0(%r13,%r9,8), %r9
	leaq	1(%rbx,%rax), %rbx
	vmovupd	(%r9), %xmm6
	movq	184(%rsp), %rax
	vmulpd	0(%r13,%rbx,8), %xmm0, %xmm0
	vsubpd	%xmm0, %xmm6, %xmm0
	vmovupd	%xmm0, (%r9)
	movq	%r11, %r9
	andq	$-2, %r9
	addq	%r9, %rax
	cmpq	%r11, %r9
	je	.L21
.L26:
	leaq	(%r12,%rax), %r9
	addq	%rdi, %rax
	vmulsd	0(%r13,%rax,8), %xmm1, %xmm2
	leaq	0(%r13,%r9,8), %r9
	vmovsd	(%r9), %xmm0
	vsubsd	%xmm2, %xmm0, %xmm0
	vmovsd	%xmm0, (%r9)
.L21:
	vmovsd	(%rcx), %xmm0
	addq	%r15, %r12
	addq	$8, %rcx
	subq	%r15, %r8
	movq	168(%rsp), %rax
	addq	136(%rsp), %rdx
	vmulsd	-8(%rax,%r10,8), %xmm1, %xmm1
	vsubsd	%xmm1, %xmm0, %xmm1
	vmovsd	%xmm1, -8(%rcx)
	cmpq	%rcx, 144(%rsp)
	jne	.L29
	movq	(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%r10, 176(%rsp)
	addq	%rcx, 48(%rsp)
	leaq	(%rax,%rdi), %r12
	movq	56(%rsp), %rdi
	addq	%rcx, %r14
	addq	%rcx, 32(%rsp)
	subq	%rcx, 40(%rsp)
	movq	64(%rsp), %rax
	movq	%rdi, 152(%rsp)
	movq	24(%rsp), %rdi
	subq	$1, 112(%rsp)
	addq	%rdi, 160(%rsp)
	jmp	.L30
	.p2align 4,,10
	.p2align 3
.L32:
	movq	64(%rsp), %rbx
	movq	%rdx, %rax
	leaq	(%rbx,%rdx), %r9
	.p2align 4,,10
	.p2align 3
.L22:
	vmulsd	(%rax,%r8,8), %xmm1, %xmm2
	vmovsd	(%rax), %xmm0
	addq	$8, %rax
	vsubsd	%xmm2, %xmm0, %xmm0
	vmovsd	%xmm0, -8(%rax)
	cmpq	%rax, %r9
	jne	.L22
	jmp	.L21
.L23:
	movq	%r10, 184(%rsp)
	movq	56(%rsp), %r11
	xorl	%ebx, %ebx
	jmp	.L31
.L47:
	vzeroupper
.L48:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L50:
	.cfi_restore_state
	leaq	.LC4(%rip), %rcx
	movl	$53, %edx
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	vzeroupper
	call	__assert_fail@PLT
	.cfi_endproc
.LFE7389:
	.size	_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm, .-_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm
	.p2align 4
	.globl	_ZN6Serial20BackwardSubstitutionEPdS0_S0_ii
	.type	_ZN6Serial20BackwardSubstitutionEPdS0_S0_ii, @function
_ZN6Serial20BackwardSubstitutionEPdS0_S0_ii:
.LFB7390:
	.cfi_startproc
	movq	%rsi, %r10
	movl	%ecx, %esi
	subl	$1, %esi
	js	.L61
	movl	%ecx, %eax
	movslq	%esi, %rcx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	imull	%eax, %esi
	movl	%eax, %r11d
	negl	%eax
	notl	%r11d
	movslq	%eax, %r9
	movslq	%r11d, %r11
	salq	$3, %r9
	movslq	%esi, %rsi
	salq	$3, %r11
	leaq	(%rsi,%rcx), %rdi
	leaq	(%rbx,%rsi,8), %rsi
	leaq	(%rbx,%rdi,8), %rdi
	.p2align 4,,10
	.p2align 3
.L55:
	vmovsd	(%r10,%rcx,8), %xmm1
	leal	1(%rcx), %eax
	vmovsd	%xmm1, (%rdx,%rcx,8)
	cmpl	%eax, %r8d
	jle	.L53
	cltq
	.p2align 4,,10
	.p2align 3
.L54:
	vmovsd	(%rsi,%rax,8), %xmm0
	vmulsd	(%rdx,%rax,8), %xmm0, %xmm0
	addq	$1, %rax
	vsubsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, (%rdx,%rcx,8)
	cmpl	%eax, %r8d
	jg	.L54
.L53:
	vdivsd	(%rdi), %xmm1, %xmm1
	vmovsd	%xmm1, (%rdx,%rcx,8)
	subq	$1, %rcx
	addq	%r11, %rdi
	addq	%r9, %rsi
	testl	%ecx, %ecx
	jns	.L55
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L61:
	.cfi_restore 3
	ret
	.cfi_endproc
.LFE7390:
	.size	_ZN6Serial20BackwardSubstitutionEPdS0_S0_ii, .-_ZN6Serial20BackwardSubstitutionEPdS0_S0_ii
	.p2align 4
	.globl	_ZN6Serial29BackwardSubstitutionOptimizedEPdS0_mm
	.type	_ZN6Serial29BackwardSubstitutionOptimizedEPdS0_mm, @function
_ZN6Serial29BackwardSubstitutionOptimizedEPdS0_mm:
.LFB7391:
	.cfi_startproc
	movq	%rdx, %r10
	subq	$1, %r10
	js	.L74
	leaq	1(%rdx), %rax
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %rbp
	movq	%rdx, %r8
	imulq	%r10, %rax
	movq	%r8, %r11
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	notq	%r11
	movq	%rcx, %rsi
	leaq	(%rdi,%r10,8), %rdx
	salq	$3, %r11
	leaq	0(%rbp,%rax,8), %r9
	movq	%r10, %rax
	leaq	8(%r11), %rbx
	imulq	%r8, %rax
	leaq	0(%rbp,%rax,8), %rcx
	.p2align 4,,10
	.p2align 3
.L68:
	vmovsd	(%rdx), %xmm1
	cmpq	%r8, %rsi
	jbe	.L66
	movq	%r8, %rax
	.p2align 4,,10
	.p2align 3
.L67:
	vmovsd	(%rcx,%rax,8), %xmm0
	vmulsd	(%rdi,%rax,8), %xmm0, %xmm0
	addq	$1, %rax
	vsubsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, (%rdx)
	cmpq	%rax, %rsi
	ja	.L67
.L66:
	vdivsd	(%r9), %xmm1, %xmm1
	subq	$8, %rdx
	addq	%r11, %r9
	addq	%rbx, %rcx
	vmovsd	%xmm1, 8(%rdx)
	cmpq	$1, %r8
	je	.L77
	movq	%r10, %r8
	subq	$1, %r10
	jmp	.L68
	.p2align 4,,10
	.p2align 3
.L77:
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L74:
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE7391:
	.size	_ZN6Serial29BackwardSubstitutionOptimizedEPdS0_mm, .-_ZN6Serial29BackwardSubstitutionOptimizedEPdS0_mm
	.p2align 4
	.globl	_ZN6Serial5SolveEPdS0_S0_ii
	.type	_ZN6Serial5SolveEPdS0_S0_ii, @function
_ZN6Serial5SolveEPdS0_S0_ii:
.LFB7392:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	.cfi_offset 15, -24
	movq	%rdi, %r15
	pushq	%r14
	.cfi_offset 14, -32
	movslq	%ecx, %r14
	pushq	%r13
	.cfi_offset 13, -40
	movq	%rdx, %r13
	movq	%r14, %rdx
	pushq	%r12
	.cfi_offset 12, -48
	movslq	%r8d, %r12
	pushq	%rbx
	movq	%r12, %rcx
	.cfi_offset 3, -56
	movq	%rsi, %rbx
	andq	$-32, %rsp
	call	_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm
	movq	%r14, %r10
	subq	$1, %r10
	js	.L85
	leaq	0(,%r14,8), %rcx
	leaq	1(%r14), %rax
	movq	%r14, %r8
	movq	%r14, %rsi
	imulq	%r10, %rax
	leaq	(%rbx,%rcx), %rdx
	notq	%r8
	imulq	%r10, %rcx
	salq	$3, %r8
	leaq	8(%r8), %r9
	leaq	(%r15,%rax,8), %rdi
	addq	%r15, %rcx
	.p2align 4,,10
	.p2align 3
.L84:
	vmovsd	-8(%rdx), %xmm1
	cmpq	%rsi, %r12
	jbe	.L82
	movq	%rsi, %rax
	.p2align 4,,10
	.p2align 3
.L83:
	vmovsd	(%rcx,%rax,8), %xmm0
	vmulsd	(%rbx,%rax,8), %xmm0, %xmm0
	addq	$1, %rax
	vsubsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, -8(%rdx)
	cmpq	%rax, %r12
	ja	.L83
.L82:
	vdivsd	(%rdi), %xmm1, %xmm1
	subq	$8, %rdx
	vmovsd	%xmm1, (%rdx)
	addq	%r8, %rdi
	leaq	-1(%rsi), %rax
	addq	%r9, %rcx
	cmpq	$1, %rsi
	je	.L85
	movq	%rax, %rsi
	jmp	.L84
	.p2align 4,,10
	.p2align 3
.L85:
	testq	%r14, %r14
	je	.L105
	leaq	8(%rbx), %rdx
	movq	%r13, %rax
	subq	%rdx, %rax
	cmpq	$16, %rax
	jbe	.L92
	cmpq	$3, %r10
	jbe	.L92
	movq	%r14, %rdx
	xorl	%eax, %eax
	shrq	$2, %rdx
	salq	$5, %rdx
	.p2align 4,,10
	.p2align 3
.L87:
	vmovupd	(%rbx,%rax), %ymm2
	vmovupd	%ymm2, 0(%r13,%rax)
	addq	$32, %rax
	cmpq	%rdx, %rax
	jne	.L87
	movq	%r14, %rax
	andq	$-4, %rax
	testb	$3, %r14b
	je	.L104
	vmovsd	(%rbx,%rax,8), %xmm0
	leaq	1(%rax), %rcx
	leaq	0(,%rax,8), %rdx
	vmovsd	%xmm0, 0(%r13,%rax,8)
	cmpq	%rcx, %r14
	jbe	.L104
	vmovsd	8(%rbx,%rdx), %xmm0
	addq	$2, %rax
	vmovsd	%xmm0, 8(%r13,%rdx)
	cmpq	%rax, %r14
	jbe	.L104
	vmovsd	16(%rbx,%rdx), %xmm0
	vmovsd	%xmm0, 16(%r13,%rdx)
	vzeroupper
.L105:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L104:
	.cfi_restore_state
	vzeroupper
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L92:
	.cfi_restore_state
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L86:
	vmovsd	(%rbx,%rax,8), %xmm0
	vmovsd	%xmm0, 0(%r13,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %r14
	jne	.L86
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7392:
	.size	_ZN6Serial5SolveEPdS0_S0_ii, .-_ZN6Serial5SolveEPdS0_S0_ii
	.section	.text.unlikely,"ax",@progbits
.LCOLDB6:
	.text
.LHOTB6:
	.p2align 4
	.globl	_ZN6Serial11SerialSolveEiPPcRfi
	.type	_ZN6Serial11SerialSolveEiPPcRfi, @function
_ZN6Serial11SerialSolveEiPPcRfi:
.LFB7393:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA7393
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdx, -192(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	testl	%ecx, %ecx
	je	.L143
.L107:
	movq	-56(%rbp), %rax
	subq	%fs:40, %rax
	jne	.L144
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L143:
	.cfi_restore_state
	leaq	-144(%rbp), %rax
	pushq	$0
	leaq	-128(%rbp), %r13
	pushq	$0
	leaq	-160(%rbp), %r14
	movq	%r13, %rcx
	leaq	-164(%rbp), %r9
	leaq	-168(%rbp), %r8
	movq	%rax, -216(%rbp)
	movq	%r14, %rdx
	movq	%rax, -160(%rbp)
	leaq	-112(%rbp), %rax
	movq	%rax, -224(%rbp)
	movq	%rax, -128(%rbp)
	leaq	-80(%rbp), %rax
	movq	$0, -152(%rbp)
	movb	$0, -144(%rbp)
	movq	$0, -120(%rbp)
	movb	$0, -112(%rbp)
	movq	%rax, -208(%rbp)
	movq	%rax, -96(%rbp)
	movq	$0, -88(%rbp)
	movb	$0, -80(%rbp)
.LEHB0:
	.cfi_escape 0x2e,0x10
	call	_ZN7Utility15ParseFilesNamesEiPPcRNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES8_PiS9_bPS7_@PLT
	popq	%rax
	movl	-168(%rbp), %ebx
	movl	-164(%rbp), %eax
	popq	%rdx
	movl	%eax, -196(%rbp)
	imull	%ebx, %eax
	cltq
	movq	%rax, %rdi
	shrq	$60, %rdi
	jne	.L109
	leaq	0(,%rax,8), %rdi
	.cfi_escape 0x2e,0
	call	_Znam@PLT
	movq	%rax, %r12
	movslq	%ebx, %rax
	movq	%rax, %rdi
	shrq	$60, %rdi
	jne	.L145
	leaq	0(,%rax,8), %rdi
	call	_Znam@PLT
	movq	%rax, -184(%rbp)
	movslq	-196(%rbp), %rax
	movq	%rax, %rdi
	shrq	$60, %rdi
	jne	.L146
	leaq	0(,%rax,8), %rdi
	call	_Znam@PLT
	movq	%rax, %r15
	movl	-196(%rbp), %eax
	pushq	$0
	movl	%ebx, %r9d
	pushq	$0
	movq	-184(%rbp), %rcx
	movq	%r15, %r8
	movq	%r12, %rdx
	pushq	$0
	movq	%r13, %rsi
	movq	%r14, %rdi
	pushq	%rax
	.cfi_escape 0x2e,0x20
	call	_ZN7Utility15InitializeArrayERNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEES6_PdS7_S7_iibPS5_S7_@PLT
	addq	$32, %rsp
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	movslq	-168(%rbp), %r14
	movslq	-164(%rbp), %r13
	movq	%r12, %rdi
	movq	-184(%rbp), %rsi
	movq	%rax, %rbx
	movq	%r13, %rcx
	movq	%r14, %rdx
	call	_ZN6Serial27ForwardEliminationOptimizedEPdS0_mm
	movq	%r14, %rcx
	subq	$1, %rcx
	js	.L121
	leaq	0(,%r14,8), %rsi
	leaq	1(%r14), %rax
	movq	%r14, %r8
	movq	-184(%rbp), %r11
	imulq	%rcx, %rax
	notq	%r8
	imulq	%rsi, %rcx
	salq	$3, %r8
	leaq	(%r11,%rsi), %rdx
	movq	%r14, %rsi
	leaq	8(%r8), %r9
	leaq	(%r12,%rax,8), %rdi
	addq	%r12, %rcx
	.p2align 4,,10
	.p2align 3
.L120:
	vmovsd	-8(%rdx), %xmm1
	cmpq	%rsi, %r13
	jbe	.L118
	movq	%rsi, %rax
	.p2align 4,,10
	.p2align 3
.L119:
	vmovsd	(%rcx,%rax,8), %xmm0
	vmulsd	(%r11,%rax,8), %xmm0, %xmm0
	addq	$1, %rax
	vsubsd	%xmm0, %xmm1, %xmm1
	vmovsd	%xmm1, -8(%rdx)
	cmpq	%rax, %r13
	ja	.L119
.L118:
	vdivsd	(%rdi), %xmm1, %xmm1
	subq	$8, %rdx
	vmovsd	%xmm1, (%rdx)
	addq	%r8, %rdi
	leaq	-1(%rsi), %rax
	addq	%r9, %rcx
	cmpq	$1, %rsi
	je	.L147
	movq	%rax, %rsi
	jmp	.L120
	.p2align 4,,10
	.p2align 3
.L147:
	movq	%r11, -184(%rbp)
.L121:
	testq	%r14, %r14
	je	.L117
	movq	-184(%rbp), %rsi
	leaq	0(,%r14,8), %rdx
	movq	%r15, %rdi
	call	memcpy@PLT
.L117:
	call	_ZNSt6chrono3_V212steady_clock3nowEv@PLT
	vxorps	%xmm0, %xmm0, %xmm0
	movl	-164(%rbp), %edx
	movq	%r15, %rdi
	subq	%rbx, %rax
	movl	-168(%rbp), %esi
	vcvtsi2ssq	%rax, %xmm0, %xmm0
	movq	-192(%rbp), %rax
	vdivss	.LC5(%rip), %xmm0, %xmm0
	vmovss	%xmm0, (%rax)
	.cfi_escape 0x2e,0
	call	_ZN7Utility13PrintSolutionEPdii@PLT
.LEHE0:
	movq	%r12, %rdi
	call	_ZdaPv@PLT
	movq	-184(%rbp), %rdi
	call	_ZdaPv@PLT
	movq	%r15, %rdi
	call	_ZdaPv@PLT
	movq	-96(%rbp), %rdi
	cmpq	-208(%rbp), %rdi
	je	.L123
	movq	-80(%rbp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L123:
	movq	-128(%rbp), %rdi
	cmpq	-224(%rbp), %rdi
	je	.L124
	movq	-112(%rbp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L124:
	movq	-160(%rbp), %rdi
	cmpq	-216(%rbp), %rdi
	je	.L107
	movq	-144(%rbp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
	jmp	.L107
.L144:
	call	__stack_chk_fail@PLT
.L145:
	jmp	.L111
.L134:
	jmp	.L135
.L146:
	jmp	.L113
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA7393:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE7393-.LLSDACSB7393
.LLSDACSB7393:
	.uleb128 .LEHB0-.LFB7393
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L134-.LFB7393
	.uleb128 0
.LLSDACSE7393:
	.text
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC7393
	.type	_ZN6Serial11SerialSolveEiPPcRfi.cold, @function
_ZN6Serial11SerialSolveEiPPcRfi.cold:
.LFSB7393:
.L109:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -56
	.cfi_offset 6, -16
	.cfi_offset 12, -48
	.cfi_offset 13, -40
	.cfi_offset 14, -32
	.cfi_offset 15, -24
.LEHB1:
	call	__cxa_throw_bad_array_new_length@PLT
.LEHE1:
.L132:
.L135:
	movq	-96(%rbp), %rdi
	movq	%rax, %rbx
	cmpq	-208(%rbp), %rdi
	je	.L140
	movq	-80(%rbp), %rax
	leaq	1(%rax), %rsi
	vzeroupper
	call	_ZdlPvm@PLT
.L127:
	movq	-128(%rbp), %rdi
	cmpq	-224(%rbp), %rdi
	je	.L128
	movq	-112(%rbp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L128:
	movq	-160(%rbp), %rdi
	cmpq	-216(%rbp), %rdi
	je	.L129
	movq	-144(%rbp), %rax
	leaq	1(%rax), %rsi
	call	_ZdlPvm@PLT
.L129:
	movq	%rbx, %rdi
.LEHB2:
	call	_Unwind_Resume@PLT
.LEHE2:
.L111:
.LEHB3:
	call	__cxa_throw_bad_array_new_length@PLT
.L140:
	vzeroupper
	jmp	.L127
.L113:
	call	__cxa_throw_bad_array_new_length@PLT
.LEHE3:
	.cfi_endproc
.LFE7393:
	.section	.gcc_except_table
.LLSDAC7393:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC7393-.LLSDACSBC7393
.LLSDACSBC7393:
	.uleb128 .LEHB1-.LCOLDB6
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L132-.LCOLDB6
	.uleb128 0
	.uleb128 .LEHB2-.LCOLDB6
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB3-.LCOLDB6
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L132-.LCOLDB6
	.uleb128 0
.LLSDACSEC7393:
	.section	.text.unlikely
	.text
	.size	_ZN6Serial11SerialSolveEiPPcRfi, .-_ZN6Serial11SerialSolveEiPPcRfi
	.section	.text.unlikely
	.size	_ZN6Serial11SerialSolveEiPPcRfi.cold, .-_ZN6Serial11SerialSolveEiPPcRfi.cold
.LCOLDE6:
	.text
.LHOTE6:
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I__ZN6Serial18ForwardEliminationEPdS0_ii, @function
_GLOBAL__sub_I__ZN6Serial18ForwardEliminationEPdS0_ii:
.LFB7924:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	_ZStL8__ioinit(%rip), %rbp
	movq	%rbp, %rdi
	call	_ZNSt8ios_base4InitC1Ev@PLT
	movq	_ZNSt8ios_base4InitD1Ev@GOTPCREL(%rip), %rdi
	movq	%rbp, %rsi
	popq	%rbp
	.cfi_def_cfa_offset 8
	leaq	__dso_handle(%rip), %rdx
	jmp	__cxa_atexit@PLT
	.cfi_endproc
.LFE7924:
	.size	_GLOBAL__sub_I__ZN6Serial18ForwardEliminationEPdS0_ii, .-_GLOBAL__sub_I__ZN6Serial18ForwardEliminationEPdS0_ii
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I__ZN6Serial18ForwardEliminationEPdS0_ii
	.local	_ZStL8__ioinit
	.comm	_ZStL8__ioinit,1,1
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC5:
	.long	1315859240
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
