This project is a refactoring and (hopefully) improved version of the pedagogical
MIPS multicycle processor design described in Ch. 7 of "Digital Design and
Computer Architecture" by David Harris and Sarah Harris.

Some key changes / improvements in this version:
1. Controller state machine using a sized enum for the state variables; this allows state values to be displayed symbolically during simulation.
2. Adds a package containing sized enums describing MIPS opcodes and function codes; this allows these values to be displayed symbolically during simulation.
3. Provides explicit extraction of instruction fields.  This increases the understandability of the code while reducing the chance of encountering common tool issues when using a bit selection in a port connection of a module instantiation.
