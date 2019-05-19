;; -------------------------------------------------------------------------------------------------- ;;
;; - Program:     Matrix                                                                            - ;;
;; - Paraneters:  ---                                                                               - ;;
;; - Description: Determine the line numbers, the arithmetic average of elements that are less than - ;;
;; -              the specified value.                                                              - ;;
;; -------------------------------------------------------------------------------------------------- ;;

global _main
extern _atoi
extern _printf
extern _randomize
default rel

%include 'utils.asm'

section .rodata
    count_matrix_rows_msg:      db      "Count of matrix rows: "
    .length:                    equ     $ - count_matrix_rows_msg
    count_matrix_cols_msg:      db      "Count of matrix cols: "
    .length:                    equ     $ - count_matrix_cols_msg
    comparison_number_msg:      db      "Number for average values comparison: "
    .length:                    equ     $ - comparison_number_msg
    matrix_info_msg:            db      "Matrix (size = %dx%d, total = %d):", nl, 0
    matrix_element_msg:         db      9, "%d", 0
    average_row_intro_msg:      db      "Row average values:", nl, 0
    average_row_msg:            db      9, "%d -> %d", nl, 0
    result_msg:                 db      "Rows comply the condition:", nl, 0
    unsuccess_msg:              db      9, "No such rows", nl, 0
    input_error_msg:            db      "Incorrect input number! Choose number in range [1, 20]", nl, 0

section .data
    matrix:         times 2048   dd      0
    sums:           times   64   dd      0

section .bss
    count_rows:                 resb    8
    count_cols:                 resb    8
    count_all:                  resb    8
    avg_number:                 resb    8

section .text
    _main:
        ;; BEGIN: Read data from keyboard (rows and cols)
        mov rax, SYS_WRITE
        mov rdi, STDOUT_FLAG                        ; File descriptor
        mov rsi, count_matrix_rows_msg              ; Pointer to string 
        mov rdx, count_matrix_rows_msg.length       ; Length of string
        syscall

        mov rax, SYS_READ
        mov rdi, STDIN_FLAG
        mov rsi, count_rows
        mov rdx, 8
        syscall

        to_int count_rows
        mov [count_rows], rax

        cmp byte[count_rows], 0
        je .input_error
        cmp byte[count_rows], 20
        jg .input_error

        mov rax, SYS_WRITE
        mov rdi, STDOUT_FLAG
        mov rsi, count_matrix_cols_msg
        mov rdx, count_matrix_cols_msg.length
        syscall

        mov rax, SYS_READ
        mov rdi, STDIN_FLAG
        mov rsi, count_cols
        mov rdx, 8
        syscall

        to_int count_cols
        mov [count_cols], rax

        cmp byte[count_cols], 0
        je .input_error
        cmp byte[count_cols], 20
        jg .input_error
        ;; END

        println

        ;; BEGIN: Get count of all elements
        multiplier [count_rows], [count_cols]
        mov [count_all], rax
        ;; END

        ;; BEGIN: Print general information
        push rbx
        lea rdi, [rel matrix_info_msg]
        mov rsi, [count_rows]
        mov rdx, [count_cols]
        mov rcx, [count_all]
        mov rax, 0
        call _printf
        pop rbx
        ;; END

        ;; BEGIN: Initialization of matrix
        mov r12, matrix
        mov rcx, 0
        .matrix_init:
            push rcx
            divider [count_cols]

            random 0, 100
            mov [r12], rax

            push rbx
            lea rdi, [rel matrix_element_msg]
            mov rsi, [r12]
            mov rax, 0
            call _printf
            pop rbx

            inc r14
            cmp r14, [count_cols]
            jne .matrix_init_end
            println
            .matrix_init_end:

            pop rcx
            inc rcx
            add r12, PTR_STEP
            cmp rcx, [count_all]
            jne .matrix_init
        ;; END

        ;; BEGIN: Calculate sum of all elements of each row
        mov r12, matrix
        mov r15, sums
        mov rcx, 0
        .matrix_sum:
            push rcx
            divider [count_cols]

            multiplier r13, PTR_STEP
            add r15, rax
            push rax
            mov rax, [r12]
            add [r15], rax
            pop rax
            sub r15, rax

            pop rcx
            inc rcx
            add r12, PTR_STEP
            cmp rcx, [count_all]
            jne .matrix_sum
        ;; END

        ;; BEGIN: Calculate row average values of sums 
        mov r15, sums
        mov rcx, 0
        .matrix_average:
            push rcx

            mov rcx, [r15]
            divider [count_cols]
            mov [r15], r13

            pop rcx
            inc rcx
            add r15, PTR_STEP
            cmp rcx, [count_rows]
            jne .matrix_average
        ;; END

        println

        ;; BEGIN: Print average row values
        push rbx
        lea rdi, [rel average_row_intro_msg]
        mov rax, 0
        call _printf
        pop rbx

        mov r15, sums
        mov rcx, 0
        .matrix_print:
            push rcx

            push rbx
            lea rdi, [rel average_row_msg]
            mov rsi, rcx
            inc rsi
            mov rdx, [r15]
            mov rax, 0
            call _printf
            pop rbx

            pop rcx
            inc rcx
            add r15, PTR_STEP
            cmp rcx, [count_rows]
            jne .matrix_print
        ;; END

        println

        ;; BEGIN: Read data from keyboard (number for comparison)
        mov rax, SYS_WRITE
        mov rdi, STDOUT_FLAG
        mov rsi, comparison_number_msg
        mov rdx, comparison_number_msg.length
        syscall

        mov rax, SYS_READ
        mov rdi, STDIN_FLAG
        mov rsi, avg_number
        mov rdx, 8
        syscall

        to_int avg_number
        mov [avg_number], rax
        ;; END

        println

        ;; BEGIN: Print result
        push rbx
        lea rdi, [rel result_msg]
        mov rax, 0
        call _printf
        pop rbx

        mov r15, sums
        mov r12, 0
        mov rcx, 0
        .matrix_result:
            push rcx

            mov rax, [r15]
            cmp rax, [avg_number]
            jge .matrix_result_end
            inc r12
            push rbx
            lea rdi, [rel average_row_msg]
            mov rsi, rcx
            inc rsi
            mov rdx, [r15]
            mov rax, 0
            call _printf
            pop rbx
            .matrix_result_end:

            pop rcx
            inc rcx
            add r15, PTR_STEP
            cmp rcx, [count_rows]
            jne .matrix_result

        cmp r12, 0
        jne .exit
        push rbx
        lea rdi, [rel unsuccess_msg]
        mov rax, 0
        call _printf
        pop rbx
        ;; END

        ;; BEGIN: Exit
        .exit:
            mov rax, SYS_EXIT
            mov rdi, 0
            syscall
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
