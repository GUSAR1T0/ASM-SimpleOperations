;; -------------------------------------------------------------------------------------------------- ;;
;; - Program:     String                                                                            - ;;
;; - Parameters:  ---                                                                               - ;;
;; - Description: Replace all zeros with ones in the text, and ones with zeros, starting from the   - ;;
;; -              position in which the number of preceding ones exceeds the number of preceding    - ;;
;; -              zeros by 1.                                                                       - ;;
;; -------------------------------------------------------------------------------------------------- ;;

global _main
default rel

%include 'utils.asm'

%define STRING_SIZE 1024

section .rodata
    original_string_input_msg:  db      "Enter the original string:", nl
    .length:                    equ     $ - original_string_input_msg
    original_string_msg:        db      "The original string:", nl, 0
    .length:                    equ     $ - original_string_msg
    reworked_string_msg:        db      "The reworked string:", nl, 0
    .length:                    equ     $ - reworked_string_msg
    nothing_changed_msg:        db      "Nothing changed!", nl, 0
    .length:                    equ     $ - nothing_changed_msg

section .bss
    input:                      resb    STRING_SIZE

section .text
    _main:
        ;; BEGIN: Read string from keyboard and print it
        print original_string_input_msg
        read_str input, STRING_SIZE
        ;; END

        call .println

        ;; BEGIN: Print the original string
        print original_string_msg
        print input, STRING_SIZE
        ;; END

        ;; BEGIN: Replace symbols when the condition is reached
        mov r12, input
        mov r13, 0
        mov r14, 0
        mov rax, 0
        mov rcx, 0
        .replace_by_condition:
            push rcx

            cmp rax, 0
            je .continue
            call .replace_symbol
            jmp .break_out
            .continue:
                call .count_symbols
                mov r15, r14
                sub r15, r13
                cmp r15, 1
                jl .break_out
                inc rax
                cmp r15, 1
                call .replace_symbol
            .break_out:

            pop rcx
            inc rcx
            add r12, 1
            cmp rcx, STRING_SIZE
            jne .replace_by_condition

        mov r15, rax
        ;; END

        call .println

        ;; BEGIN: Print the reworked string
        print reworked_string_msg

        cmp r15, 1
        jne .nothing_changed
        print input, STRING_SIZE
        jmp .exit
        .nothing_changed:
            print nothing_changed_msg
        ;; END

        ;; BEGIN: The function to count symbols ('0' and '1')
        .count_symbols:
            cmp byte[r12], '0'
            jne .count_symbols_else_if
            inc r13
            jmp .count_symbols_end
            .count_symbols_else_if:
            cmp byte[r12], '1'
            jne .count_symbols_end
            inc r14
            .count_symbols_end:
            ret
        ;; END

        ;; BEGIN: The function to replace symbols ('0' -> '1' and '1' -> '0')
        .replace_symbol:
            cmp byte[r12], '0'
            jne .replace_symbol_else_if
            mov byte[r12], '1'
            jmp .replace_symbol_end
            .replace_symbol_else_if:
            cmp byte[r12], '1'
            jne .replace_symbol_end
            mov byte[r12], '0'
            .replace_symbol_end:
            ret
        ;; END
