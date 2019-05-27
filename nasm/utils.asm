; Definition of base values 
%define SYS_EXIT 0x2000001
%define SYS_READ 0x2000003
%define SYS_WRITE 0x2000004
%define STDIN_FLAG 0
%define STDOUT_FLAG 1
%define nl 10

extern _printf
extern _scanf

;; Checks that number is in required range.
%macro range_check 3
    push rsi
    push rdx
    mov rsi, %1
    mov rdx, %2
    cmp byte[%3], %1
    jl .input_error
    cmp byte[%3], %2
    jg .input_error
    pop rdx
    pop rsi
%endmacro

;; Multiplies two integers.
;; Returns integer value into RAX register.
%macro multiplier 2
    push rbx
    mov rax, %1
    mov rbx, %2
    imul rax, rbx
    pop rbx
%endmacro

;; Divides two integers.
;; Expects value into RCX register.
;; Returns integer values: DIV result into R13 register and MOD result into R14 register.
%macro divider 1
    push rax
    push rdx
    push rsi
    mov rax, rcx
    mov rdx, 0
    mov rsi, %1
    idiv rsi
    mov r13, rax
    mov r14, rdx
    pop rsi
    pop rdx
    pop rax
%endmacro

;; Prints string value
%macro print 1
    mov rsi, %1              ; Pointer to string 
    mov rdx, %1.length       ; Length of string
    call .print
%endmacro

;; Prints string value
%macro print 2
    mov rsi, %1              ; Pointer to string 
    mov rdx, %2              ; Length of string
    call .print
%endmacro

;; Reads integer value
%macro read_int 1
    mov rsi, %1
    call .read_int
%endmacro

;; Reads string value
%macro read_str 2
    mov rsi, %1
    mov rdx, %2
    call .read_str
%endmacro

;; BEGIN: Prints string value
.print:
    mov rax, SYS_WRITE
    mov rdi, STDOUT_FLAG     ; File descriptor
    syscall
    ret
;; END

;; BEGIN: Prints formatted string value
.printf:
    push rbx
    push rax
    mov rax, 0
    call _printf
    pop rax
    pop rbx
    ret

;; BEGIN: The function to print a new line
.println:
    push rdi
    lea rdi, [rel new_line]
    call .printf
    pop rdi
    ret
;; END

;; BEGIN: Reads integer value
.read_int:
    push rdi
    sub rsp, 8
    mov rdi, format_int
    mov al, 0
    call _scanf
    add rsp, 8
    pop rdi
;; END

;; BEGIN: Reads string value
.read_str:
    mov rax, SYS_READ
    mov rdi, STDIN_FLAG
    syscall
    ret
;; END

;; BEGIN: Randomizes integer value in range [0; 100000), returns integer value into RAX register.
.random:
    push rdx
    push rcx
    mov rax, [random_seed]
    mov rdx, 0
    mov rcx, 127773
    idiv rcx
    mov rcx, rax
    mov rax, 16807
    imul rdx
    mov rdx, rcx
    mov rcx, rax
    mov rax, 2836
    imul rdx
    sub rcx, rax
    mov rdx, 0
    mov rax, rcx
    mov [random_seed], rcx
    mov rcx, 100000
    idiv rcx
    mov rax, rdx
    pop rcx
    pop rdx
    ret
;; END

;; BEGIN: Randomizes integer value in range [R13; R14], returns integer value into RAX register.
.random_interval:
    push rdx
    push rcx
    mov rcx, r14
    sub rcx, r13
    inc rcx
    push r12
    call .random
    pop r12
    mov rdx, 0
    idiv rcx
    mov rax, rdx
    add rax, r13
    pop rcx
    pop rdx
    ret
;; END

;; BEGIN: Initialize random number generator
.random_init:
    push rax
    push rdx
    rdtsc
    xor rax, rdx
    mov [random_seed], rax
    pop rdx
    pop rax
    ret
;; END

;; BEGIN: The function to print about incorrect input number
.input_error:
    lea rdi, [rel input_error_msg]
    call .printf
    jmp .exit
;; END

;; BEGIN: The function to exit a program
.exit:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
;; END

section .rodata
    format_int:                 db      "%d", 0
    new_line:                   db      nl, 0
    input_error_msg:            db      "Incorrect input number! Choose number in range [%d, %d]", nl, 0

section .data
    random_seed:                dq      0