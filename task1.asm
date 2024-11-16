section .data
    prompt db "Enter a number: ", 0
    positive_msg db "The number is POSITIVE", 10, 0
    negative_msg db "The number is NEGATIVE", 10, 0
    zero_msg db "The number is ZERO", 10, 0

section .bss
    user_input resb 10 ; Reserve space for the user input (up to 10 characters)

section .text
    global _start

_start:
    ; Prompt user for input
    mov eax, 4              ; sys_write syscall
    mov ebx, 1              ; File descriptor (stdout)
    mov ecx, prompt         ; Address of the prompt string
    mov edx, 17             ; Length of the prompt string
    int 0x80                ; Call kernel

    ; Read user input
    mov eax, 3              ; sys_read syscall
    mov ebx, 0              ; File descriptor (stdin)
    mov ecx, user_input     ; Address to store user input
    mov edx, 10             ; Max bytes to read
    int 0x80                ; Call kernel

    ; Convert ASCII input to integer
    xor ebx, ebx            ; Clear ebx (sign flag, 0 = positive, 1 = negative)
    mov ecx, user_input     ; Load the address of the input

    cmp byte [ecx], '-'     ; Check if the first character is '-'
    jne convert_number      ; If not '-', skip to conversion
    inc ecx                 ; Move to the next character (skip '-')
    mov bl, 1               ; Set sign flag to negative

convert_number:
    xor eax, eax            ; Clear eax (to store the number)
    xor edx, edx            ; Clear edx (to store the remainder)

convert_loop:
    mov dl, byte [ecx]      ; Load the current character
    cmp dl, 10              ; Check for newline (end of input)
    je check_sign           ; If newline, finish conversion
    sub dl, '0'             ; Convert ASCII to integer
    imul eax, eax, 10       ; Multiply current number by 10
    add eax, edx            ; Add the new digit to the number
    inc ecx                 ; Move to the next character
    jmp convert_loop        ; Repeat for the next digit

check_sign:
    cmp bl, 1               ; Check if the number is negative
    jne check_zero          ; If not, skip to zero check
    neg eax                 ; Negate the number (make it negative)

check_zero:
    cmp eax, 0              ; Compare eax with 0
    je is_zero              ; Jump to is_zero if eax == 0
    jl is_negative          ; Jump to is_negative if eax < 0

    ; If neither ZERO nor NEGATIVE, it must be POSITIVE
is_positive:
    ; Print "POSITIVE"
    mov eax, 4              ; sys_write syscall
    mov ebx, 1              ; File descriptor (stdout)
    mov ecx, positive_msg   ; Address of positive message
    mov edx, 26             ; Length of positive message
    int 0x80                ; Call kernel
    jmp end_program         ; Unconditional jump to program exit

is_negative:
    ; Print "NEGATIVE"
    mov eax, 4              ; sys_write syscall
    mov ebx, 1              ; File descriptor (stdout)
    mov ecx, negative_msg   ; Address of negative message
    mov edx, 26             ; Length of negative message
    int 0x80                ; Call kernel
    jmp end_program         ; Unconditional jump to program exit

is_zero:
    ; Print "ZERO"
    mov eax, 4              ; sys_write syscall
    mov ebx, 1              ; File descriptor (stdout)
    mov ecx, zero_msg       ; Address of zero message
    mov edx, 20             ; Length of zero message
    int 0x80                ; Call kernel

end_program:
    ; Exit program
    mov eax, 1              ; sys_exit syscall
    xor ebx, ebx            ; Return code 0
    int 0x80                ; Call kernel
