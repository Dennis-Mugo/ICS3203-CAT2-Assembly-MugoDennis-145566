section .bss
input resb 10            ; Reserve 10 bytes for user input
sensor_value resb 1      ; Simulated sensor value (integer converted from input)
motor_status resb 1      ; Motor status: 0 (off), 1 (on)
alarm_status resb 1      ; Alarm status: 0 (off), 1 (on)

section .data
prompt db "Enter sensor value (0-100): ", 0
prompt_len equ $ - prompt
motor_on_msg db "Motor Status: ON", 10, 0  ; Newline at the end
motor_off_msg db "Motor Status: OFF", 10, 0
alarm_on_msg db "Alarm Status: ON", 10, 0
alarm_off_msg db "Alarm Status: OFF", 10, 0

section .text
global _start

_start:
    ; Display prompt for sensor value input
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, prompt      ; Address of the prompt message
    mov rdx, prompt_len  ; Length of the message
    syscall

    ; Read user input for sensor value
    mov rax, 0           ; Syscall for read
    mov rdi, 0           ; File descriptor (stdin)
    mov rsi, input       ; Address to store input
    mov rdx, 10          ; Maximum input size
    syscall

    ; Convert ASCII input to integer
    xor rax, rax         ; Clear rax (to store the integer result)
    mov rsi, input       ; Address of the input buffer
.convert_input:
    movzx rbx, byte [rsi] ; Load the next byte of input into rbx
    cmp rbx, 10          ; Check for newline (ASCII 10)
    je .conversion_done  ; End conversion if newline is encountered
    sub rbx, '0'         ; Convert ASCII digit to integer
    imul rax, rax, 10    ; Multiply the current result by 10
    add rax, rbx         ; Add the new digit to the result
    inc rsi              ; Move to the next character in input
    jmp .convert_input

.conversion_done:
    mov [sensor_value], al ; Store the final integer result in sensor_value

    ; Read sensor value for decision-making
    mov al, [sensor_value] ; Load water level into AL register

    ; Decision logic based on water level
    cmp al, 70            ; Compare water level with high threshold
    ja .trigger_alarm     ; If water level > 70, trigger alarm

    cmp al, 30            ; Compare water level with moderate threshold
    jae .stop_motor       ; If water level is moderate (30-70), stop motor

    ; Turn on the motor (low water level)
    mov byte [motor_status], 1 ; Set motor status to ON
    mov byte [alarm_status], 0 ; Ensure alarm is OFF
    jmp .output_status

.trigger_alarm:
    ; Trigger alarm (high water level)
    mov byte [alarm_status], 1 ; Set alarm status to ON
    mov byte [motor_status], 0 ; Ensure motor is OFF
    jmp .output_status

.stop_motor:
    ; Stop motor (moderate water level)
    mov byte [motor_status], 0 ; Set motor status to OFF
    mov byte [alarm_status], 0 ; Ensure alarm is OFF

.output_status:
    ; Output motor status
    mov al, [motor_status]
    cmp al, 1
    je .motor_on          ; Jump if motor is ON
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, motor_off_msg ; Message for motor OFF
    mov rdx, 18          ; Length of the message
    syscall
    jmp .alarm_status

.motor_on:
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, motor_on_msg ; Message for motor ON
    mov rdx, 17          ; Length of the message
    syscall

.alarm_status:
    ; Output alarm status
    mov al, [alarm_status]
    cmp al, 1
    je .alarm_on          ; Jump if alarm is ON
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, alarm_off_msg ; Message for alarm OFF
    mov rdx, 18          ; Length of the message
    syscall
    jmp .end_program

.alarm_on:
    mov rax, 1           ; Syscall for write
    mov rdi, 1           ; File descriptor (stdout)
    mov rsi, alarm_on_msg ; Message for alarm ON
    mov rdx, 17          ; Length of the message
    syscall

.end_program:
    ; Exit the program
    mov rax, 60           ; Syscall for exit
    xor rdi, rdi          ; Exit code 0
    syscall
