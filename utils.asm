; Definition of base values 
%define SYS_EXIT 0x2000001
%define SYS_READ 0x2000003
%define SYS_WRITE 0x2000004
%define STDIN_FLAG 0
%define STDOUT_FLAG 1
%define PTR_STEP 12
%define STRING_SIZE 1024
%define nl 10

;; Prints new line
%macro println 0
    push rbx
    lea rdi, [rel new_line]
    mov rax, 0
    call _printf
    pop rbx
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

section .rodata
    new_line:       db      nl, 0