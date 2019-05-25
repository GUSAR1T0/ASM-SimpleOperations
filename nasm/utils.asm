; Definition of base values 
%define SYS_EXIT 0x2000001
%define SYS_READ 0x2000003
%define SYS_WRITE 0x2000004
%define STDIN_FLAG 0
%define STDOUT_FLAG 1
%define PTR_STEP 12
%define STRING_SIZE 1024
%define nl 10

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

;; Converts string value to integer.
;; Returns integer value into RAX register.
%macro to_int 1
    push rdi
    mov rdi, %1
    call _atoi
    pop rdi
%endmacro

;; Randomizes integer value in range [v1; v2]
;; Returns integer value into RAX register.
%macro random 2
    push rdi
    push rsi
    mov rdi, %1
    mov rsi, %2
    call _randomize
    pop rsi
    pop rdi
%endmacro

;; BEGIN: The function to print a new line
.println:
    push rbx
    push rax
    lea rdi, [rel new_line]
    mov rax, 0
    call _printf
    pop rax
    pop rbx
    ret
;; END

;; BEGIN: The function to print about incorrect input number
.input_error:
    push rbx
    lea rdi, [rel input_error_msg]
    mov rax, 0
    call _printf
    pop rbx
    jmp .exit
;; END

;; BEGIN: The function to exit a program
.exit:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
;; END

section .rodata
    new_line:                   db      nl, 0
    input_error_msg:            db      "Incorrect input number! Choose number in range [%d, %d]", nl, 0
