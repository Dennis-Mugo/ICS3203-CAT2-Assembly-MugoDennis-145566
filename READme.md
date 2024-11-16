# CAT 2 Tasks

# Task 1
The purpose of this program is to classify a user-provided number as positive, negative, or zero and display the corresponding result to the user. It achieves this by first prompting the user to input a number, then converting the ASCII string input into an integer, handling both positive and negative numbers. The program uses branching logic through conditional and unconditional jumps to evaluate the input and route execution to the appropriate classification logic. By employing system calls for input and output, it interacts with the user via the terminal. This program demonstrates fundamental control flow, conditional logic, and system-level programming techniques, making it an excellent example of how low-level operations in assembly language can be used to solve basic computational tasks.


## Compiling and running the program
```bash
nasm -f elf32 task1.asm -o task1.o
ld -m elf_i386 task1.o -o task1
./task1
```

## Insights and challenges
One significant challenge in this task is handling user input and converting it from ASCII to a signed integer format. This involved solving several sub-challenges such as dealing with Multi-digit Numbers and Signed Number Conversion.


# Task 2
This program reverses an array of four integers in place and then displays each element of the reversed array one by one. The program uses a loop to swap elements at symmetric positions from the beginning and end of the array until the reversal is complete. After reversing, the program outputs each element as an ASCII character, converting the numeric values to their corresponding ASCII representation. It prints the array elements sequentially, each followed by a newline for formatting, and then terminates. The program demonstrates low-level memory manipulation, pointer arithmetic, and system call usage for output and program termination.

## Compiling and running the program
```bash
nasm -f elf64 task2.asm -o task2.o
ld task2.o -o task2
./task2
```

## Insights and challenges
Users may enter input of varying lengths (e.g., multi-digit numbers or single characters). The program must correctly process input byte by byte while maintaining appropriate counters and indexes, often requiring complex loops.

# Task 3
The program is designed to calculate the factorial of a number entered by the user in a Linux environment using x86-64 assembly language. It demonstrates efficient use of system calls for input and output operations, allowing the user to interact with the program through the terminal. The program reads the user's input, converts it from an ASCII string to an integer, and computes the factorial using a recursive subroutine. The result is then converted back to an ASCII string for display, showcasing the program's ability to handle mathematical computations and character manipulation. A newline character is appended to the output to ensure a clean and user-friendly display format. This program highlights the principles of low-level programming, such as register usage, stack operations, and system-level input/output management, making it a practical demonstration of assembly language capabilities.

## Compiling and running the program
```bash
nasm -f elf64 task3.asm -o task3.o
ld task3.o -o task3
./task3
```

## Insights and challenges
One challenge encountered in the program was handling the conversion of input from ASCII to an integer and back to ASCII for displaying the result, which required careful manipulation of registers and memory. Additionally, implementing a recursive factorial function in assembly posed a challenge in managing the stack and ensuring proper restoration of registers after each recursive call.

The caller-saved registers (rbp, rbx) are pushed onto the stack at the beginning of the factorial subroutine.
The base pointer (rbp) is pushed to preserve the caller's stack frame and allow for nested calls.


# Task 4
The purpose of this program is to simulate a control system that monitors a sensor value, such as water level, and performs appropriate actions based on predefined thresholds. It allows a user to input a simulated sensor value and determines whether to turn a motor ON or OFF or activate an alarm, simulating real-world scenarios like water level management in tanks. The program demonstrates efficient handling of user input, decision-making logic, and real-time output updates, making it a foundational example of embedded system control and monitoring using assembly language.

## Compiling and running the prgram
```bash
nasm -f elf64 task4.asm -o task4.o
ld task4.o -o task4
./task4
```

## Challenges
### Handling Multi-Digit Input:

- Converting multi-digit ASCII input into an integer required implementing a loop to process each character, which can be error-prone if not handled correctly.
Decision Logic Accuracy:

- Ensuring that the program correctly evaluates the sensor value against multiple thresholds and updates the motor and alarm statuses without conflicts or logical errors.


