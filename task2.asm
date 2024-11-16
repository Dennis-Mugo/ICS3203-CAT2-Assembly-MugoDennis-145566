section .data
array db 1, 2, 3, 4       ; Array to reverse
array_len equ $ - array    ; Length of the array (4)
newline db 10, 0           ; Newline character for output

section .text
global _start

_start:
    ; Reverse the array in-place
    xor rsi, rsi             ; rsi = start index (0)
    mov rdi, array_len       ; rdi = end index (array_len - 1)
    dec rdi                  ; Adjust for 0-based indexing

.reverse_loop:
    cmp rsi, rdi             ; Check if start index >= end index
    jge .done_reverse        ; Exit loop if done

    ; Swap array[rsi] and array[rdi]
    mov al, [array + rsi]    ; Load array[rsi] into al
    mov bl, [array + rdi]    ; Load array[rdi] into bl
    mov [array + rsi], bl    ; Store bl into array[rsi]
    mov [array + rdi], al    ; Store al into array[rdi]

    ; Update indices
    inc rsi                  ; Increment start index
    dec rdi                  ; Decrement end index
    jmp .reverse_loop        ; Repeat loop

.done_reverse:
    ; Output only the first element of the reversed array
    mov al, [array]          ; Load the first element of the array into al
    add al, '0'              ; Convert the number to ASCII
    mov rsi, rsp             ; Use stack for temporary storage
    sub rsp, 1               ; Allocate space for 1 character
    mov [rsp], al            ; Store the ASCII character in memory
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, rsp             ; Address of the ASCII character
    mov rdx, 1               ; Write one character
    syscall
    add rsp, 1               ; Clean up the stack

    ; Print a newline for better formatting
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, newline         ; Address of the newline character
    mov rdx, 1               ; Write one character
    syscall

    
    mov al, [array + 1]          ; Load the second element of the array into al
    add al, '0'              ; Convert the number to ASCII
    mov rsi, rsp             ; Use stack for temporary storage
    sub rsp, 1               ; Allocate space for 1 character
    mov [rsp], al            ; Store the ASCII character in memory
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, rsp             ; Address of the ASCII character
    mov rdx, 1               ; Write one character
    syscall
    add rsp, 1               ; Clean up the stack

    ; Print a newline for better formatting
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, newline         ; Address of the newline character
    mov rdx, 1               ; Write one character
    syscall

    mov al, [array + 2]          ; Load the third element of the array into al
    add al, '0'              ; Convert the number to ASCII
    mov rsi, rsp             ; Use stack for temporary storage
    sub rsp, 1               ; Allocate space for 1 character
    mov [rsp], al            ; Store the ASCII character in memory
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, rsp             ; Address of the ASCII character
    mov rdx, 1               ; Write one character
    syscall
    add rsp, 1               ; Clean up the stack

    ; Print a newline for better formatting
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, newline         ; Address of the newline character
    mov rdx, 1               ; Write one character
    syscall

    mov al, [array + 3]          ; Load the fourth element of the array into al
    add al, '0'              ; Convert the number to ASCII
    mov rsi, rsp             ; Use stack for temporary storage
    sub rsp, 1               ; Allocate space for 1 character
    mov [rsp], al            ; Store the ASCII character in memory
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, rsp             ; Address of the ASCII character
    mov rdx, 1               ; Write one character
    syscall
    add rsp, 1               ; Clean up the stack

    ; Print a newline for better formatting
    mov rax, 1               ; Syscall for write
    mov rdi, 1               ; File descriptor (stdout)
    mov rsi, newline         ; Address of the newline character
    mov rdx, 1               ; Write one character
    syscall


    ; Exit the program
    mov rax, 60              ; Syscall for exit
    xor rdi, rdi             ; Exit code 0
    syscall
