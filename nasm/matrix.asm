;; -------------------------------------------------------------------------------------------------- ;;
;; - Program:     Matrix                                                                            - ;;
;; - Parameters:  ---                                                                               - ;;
;; - Description: Determine the line numbers, the arithmetic average of elements that are less than - ;;
;; -              the specified value.                                                              - ;;
;; -------------------------------------------------------------------------------------------------- ;;

global _main
default rel

%include 'utils.asm'

%define PTR_STEP 12

section .rodata
    count_matrix_rows_msg:      db      "Count of matrix rows: ", 0
    .length:                    equ     $ - count_matrix_rows_msg
    count_matrix_cols_msg:      db      "Count of matrix cols: ", 0
    .length:                    equ     $ - count_matrix_cols_msg
    comparison_number_msg:      db      "Number for average values comparison: ", 0
    .length:                    equ     $ - comparison_number_msg
    matrix_info_msg:            db      "Matrix (size = %dx%d, total = %d):", nl, 0
    matrix_element_msg:         db      9, "%d", 0
    average_row_intro_msg:      db      "Row average values:", nl, 0
    average_row_msg:            db      9, "%d -> %d", nl, 0
    result_msg:                 db      "Rows comply the condition (x < %d):", nl, 0
    unsuccess_msg:              db      9, "No such rows", nl, 0

section .data
    matrix:      times 5120000  dd      0
    sums:        times  160000  dd      0

section .bss
    count_rows:                 resb    8
    count_cols:                 resb    8
    count_all:                  resb    8
    avg_number:                 resb    8

section .text
    _main:
        ;; BEGIN: Read data from keyboard (rows and cols)
        print count_matrix_rows_msg
        read_int count_rows
        range_check 1, 1000, count_rows

        print count_matrix_cols_msg
        read_int count_cols
        range_check 1, 1000, count_cols
        ;; END

        call .println

        ;; BEGIN: Get count of all elements
        multiplier [count_rows], [count_cols]
        mov [count_all], rax
        ;; END

        ;; BEGIN: Print general information
        lea rdi, [rel matrix_info_msg]
        mov rsi, [count_rows]
        mov rdx, [count_cols]
        mov rcx, [count_all]
        call .printf
        ;; END

        ;; BEGIN: Initialization of matrix
        call .random_init
        mov r12, matrix
        mov rcx, 0
        .matrix_init:
            push rcx

            mov r13, 0
            mov r14, 100
            call .random_interval
            mov [r12], rax

            divider [count_cols]

            lea rdi, [rel matrix_element_msg]
            mov rsi, [r12]
            call .printf

            inc r14
            cmp r14, [count_cols]
            jne .matrix_init_end
            call .println
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

        call .println

        ;; BEGIN: Print average row values
        lea rdi, [rel average_row_intro_msg]
        call .printf

        mov r15, sums
        mov rcx, 0
        .matrix_print:
            push rcx

            lea rdi, [rel average_row_msg]
            mov rsi, rcx
            inc rsi
            mov rdx, [r15]
            call .printf

            pop rcx
            inc rcx
            add r15, PTR_STEP
            cmp rcx, [count_rows]
            jne .matrix_print
        ;; END

        call .println

        ;; BEGIN: Read data from keyboard (number for comparison)
        print comparison_number_msg
        read_int avg_number
        range_check 0, 101, avg_number
        ;; END

        call .println

        ;; BEGIN: Print result
        lea rdi, [rel result_msg]
        mov rsi, [avg_number]
        call .printf

        mov r15, sums
        mov r12, 0
        mov rcx, 0
        .matrix_result:
            push rcx

            mov rax, [r15]
            cmp rax, [avg_number]
            jge .matrix_result_end
            inc r12
            lea rdi, [rel average_row_msg]
            mov rsi, rcx
            inc rsi
            mov rdx, [r15]
            call .printf
            .matrix_result_end:

            pop rcx
            inc rcx
            add r15, PTR_STEP
            cmp rcx, [count_rows]
            jne .matrix_result

        cmp r12, 0
        jne .exit
        lea rdi, [rel unsuccess_msg]
        call .printf
        call .exit
        ;; END
