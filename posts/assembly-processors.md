---
title: Assembly derailing, how processors work and losing myself in random links
date: 2026-04-07
tags: assembly, mos-6052, cpu, processors
---

# Assembly derailing, how processors work and losing myself in random links

To me, learning is a chaotic and exciting process. It scares me but it is also energizing. It hurts to be held in confusion while stuck in a small thing I couldn't figure and it makes everything bright when smth clicks and many apparently disconnected information suddenly make sense together. These derailing notes are a mirror of my process, a way to make sense of things and to not get completely lost into chaos.

Feel free to suggest changes or corrections as this article, as notes of my discovering process while explaining stuff to myself as I see them at the moment, is inherently prone to mistakes and confusion.

First Questions

- What is a [shebang](#what-is-a-shebang)?
- What are [interpreted and compiled languages](#so-a-break-what-are-interpreted-and-compiled-languages)?
- If Assembly has such a close relation to processor architecture, [how does a processor work?](#how-do-cpus-read-machine-code)
- Assembly 6502

This Easter I got lost into assembly. This is a summary of my derailing journey. My background is very basic: some electric circuits and PLC visual programming but yeah... that's pretty much it.

## What is a shebang?

This started because I was looking into [this issue](https://github.com/lobsters/lobsters/pull/1827).
Then... What is [database consistency](https://github.com/djezzzl/database_consistency)? It is a gem build to address or at least alert of missing or broken constraints, validations, associations etc between ruby models and database schema, more precisely SQLite3, PostgreSQL and MySQL dbs.

The first line of the code in [database_consistency bin](https://github.com/djezzzl/database_consistency/blob/master/bin/database_consistency) is

```bash
#!/usr/bin/env ruby
```

What would that be? I ask myself, looks like a comment but... not quite. After some googling I discover this funny line even has its own name: it is called a shebang.

A [Shebang](https://www.reddit.com/r/bash/comments/ugoz97/today_i_understood_the_importance_of_the_shebang/) is the first line in a program, which tells the system which interpreter it should use to interpret the programming language we are using. Very nice... You can be use a ruby interpreter, python interpreter and so on. But... What does it mean to _interpret a language_?

Oh I remember, programming languages can be _interpreted_ or _compiled_ in most cases, and I don't know what that is.

## What are the types of programming languages and what is all that?

[This video](https://www.youtube.com/watch?v=KsZLPTRSleI) brings a nice and concise explanation.

Programming languages can be _interpreted_, _compiled_, or _assembly_. The first being in the _higher level_ end and the latter being in the _lower level_ end.

### The lowest low

Lower level is to say such language is closer to how the computer operates in the physical level, to the actual setting of wires, circuits and small pieces inside. Very low level programming languages like Assembly (ASM) are, in a way, a mirror of the physical electronic micro circuits in the processor, it's completely dependent on its architecture so that different architectures will have a different ASM each. If all programs are spells, Assembly (the lowest level above machine language) would be very literal and basic ones: "this $0200 place in memory keeps this #$02 number". Assembly spells are the least magic of all, the most realistic only beaten in their magiclessness by the actial binary code.

Example in [6502 Assembly](https://jumplink.eu/Learn6502/#instructions):

```
LDA #$c0  ;Load the hex value $c0 into the A register
TAX       ;Transfer the value in the A register to X
INX       ;Increment the value in the X register
ADC #$c4  ;Add the hex value $c4 to the A register
BRK       ;Break - we're done
```

[Machine code](https://en.wikipedia.org/wiki/Machine_code) corresponds directly to the actual binary the processor reads. It causes the CPU to perform a specific task like:

- Load a word from memory to a CPU register
- Execute an arithmetic logic unit (ALU) operation on one or more registers or memory locations
- Jump or skip to an instruction that is not the next one

It kinda works idk why

```
LDX #$FF
LDY #$05
LDA #01

loop:
  STA X
  ADC #01
  DEX
  BNE loop
  BRK
```

I watched this [lovely sequence](https://www.youtube.com/playlist?list=PLowKtXNTBypFbtuVMUVXNR0z1mu7dp7eH) of videos and below are my comments of the most significant parts for me.

### [“Hello, world” from scratch on a 6502 — Part 1](https://www.youtube.com/watch?v=LnzuMJLZRdU)

_When something is too complicated to undertand I run away to Portuguese. Other times it feels better to write in English, I am sorry for the mess._

Neste vídeo o Ben coloca um processador 6502 (com um design um pouco mais moderno) conecta-o a uma placa de pinos e conecta algumas coisas no processador a partir das informações da datasheet desse processador.

O que está conectado ao processador:

- Clock
- Um arduíno para ler os registers(?) e o databus(?)
- Um input binário é forçado com resistores
- Claro, o processador é ligado a uma fonte de energia.
- input e outputs estão sendo monitorados para descobrirmos o que o processador está fazendo no fim das contas.

Mas que pergunta estou tentando responder? Bom, o que eu queria saber é como um processador funciona. É muito fácil se perder mas, no meio de tantas informações que entendo pela metade ou menos, o que estou tentando capturar? É possível que eu nem mesmo consiga uma resposta para essas perguntas.

More questions:

- O que faz uma unidade lógica aritmética?
- O que é um databus?
- O que cada comando do Assembly quer dizer sobre as operações físicas que o processador faz?
- O que significa quando uma entrada é de 8 ou 16 bits?

  Acho que é o número de pinos com valor 0 ou 1. Se há 8 pinos que podem ou não estar recebendo corrente, temos um número de 8 bits. Um número de 8 bits pode ir de 00000000 a 11111111, o que em algarismos decimais é: 0 a 255, em hexadecimal é: 0 a ff. Existem 255 (decimal) combinações diferentes que podem ser feitas com essa quantidade de bits e por tanto 255 coisas diferentes podem ser representadas. É um registro de pauzinhos aprimorado, Em vez de riscar em um pedaço de madeira, mudamos a corrente elétrica em cada pino.

  Analogamente, se uma entrada tem 16 bits ela tem 16 pinos, podendo representar números binários de 0000000000000000 a 1111111111111111, 0 a 65535 (decimal), ou ainda 0 a ffff (hexa).

Random questions:

- Is it possible to work with hexadecimals in the soroban?

- O que é low byte e high byte? (https://www.scs.stanford.edu/05au-cs240c/lab/i386/s02_02.htm)

  Bytes, palavras e palavras duplas são os tipos de dados fundamentais. Um byte é feito de oito bits contiguos começando de qualquer endereço lógico. Os bits são numerados de 1 a 7. Uma palavra é composta de 2 bytes contíguos começando de qualquer endereço. Uma palavra contém 16 bits. Os bits de uma palavra são numerados de 0 a 15. O bit 0 é o menos significativo:

  ```
  0  0  0  1  0  1  0  0    0  1  0  0  1  0  0  1 just a random binary number
  15 14 13 12 11 10 9  8    7  6  5  4  3  2  1  0
  high                      low
  ```

Neste primeiro vídeo o proc (processador, 6502) ao ser acionado o circuito que gera o sinal de reset lê dos endereços de memória fffc e fffd (wow, quer dizer que esse dispositivo tem até 5 bytes de memória, é o que vimos antes), ele está lendo do data bus. O que leva à pergunta anterior:

- O que é um databus? (https://en.wikipedia.org/wiki/Bus_(computing))

  É um sistema de comunicação que transfere dados entre componentes dentro de um computador. Em português acredito que o nome seja barramento: barramento de memória, barramento de programa... [Esta imagem](<https://en.wikipedia.org/wiki/Bus_(computing)#/media/File:Computer_system_bus.svg>) é muito boa.

[24:01](https://youtu.be/LnzuMJLZRdU?si=dsn43RQJ1bvXEXRI) Aqui o processador está lendo o que tem dentro do endereço 'eaea', and tries to read an instruction out of that address in the databus. And it gets ea out of that address and tries to interpret it as an instruction. Pra falar a verdade a distinção entre databus, control bus and address bus ainda é obscura para mim. Sobre os dois últimos acredito que o address bus, tirando pelo nome, é onde estão os endereços de memória. Onde ficam esses endereços de memória? Porque se a memória vai até ffff, então em algum lugar precisa ter (provavelmente dentro do processador) 65535 lugares que podem guardar valores, cada um podendo conter até 16 bits(?) ou 8 bits(?), acho que são 8, de informação. Isso quer dizer que em algum lugar há uma memória, tem que haver pelo menos 65535\*8 bits = 524280 pinos ~ 64 kbytes de memória.

How's the process going to interpret 'ea' as an instruction? [Datasheet](https://eater.net/datasheets/w65c02s.pdf)!
From the table in page 22 we can learn that the most significant digit 'e' (line) and least significant digit 'a' (column) are equivalent to the command NOP (there is a little i below it), which stands for 'no operation' do nothing. NOP takes to clock cyles to execute. The little 'i' means 'implied', and instructions in the imply address mode take two clock cyles to execute. (page 22).

_One lesson learned:_ pointers refer to an actual physical structure in a computer. That is to say, the memory is where the actual information is, but there is a memory bus which holds the addresses for all the actual places in memory. So *p in C, would mean, the p is an address held in the memory bus, and *p would be the actual value held into that place in memory.

### [How do CPUs read machine code? — 6502 part 2](https://www.youtube.com/watch?v=yl8vPW5hydQ)

In the video, the guy is now gonna plug an [EEPROM 25c256](https://en.wikipedia.org/wiki/EEPROM) which is a non-volatile memory that can be programmed and erased in-circuit. That will serve to be plugged, conneced to the data lines of the microprocessor.

Now he is programming the EEPROM with the NOP instruction to check if the microprocessor behaves the same.
Writting instructions to the ROM, he creates an array filled with 'ea's in each position of memory:

```python
rom = bytearray([0xea] * 32768) # which is the number of positions in memory

with open("rom.bin", "wb") as out_file:
out_file.write(rom);
```

In bash:

```bash
python makerom.py
hexdump -C rom.bin
minipro -p AT28C256 -w rom.bin #write the binaries to the EEPROM
```

Little endian: means that the low byte is stored first like 'ea' 'ff' reads as 'ffea'
Big endian: higher byte is stored first. 'ea' 'ff' reads as 'eaff'

The microp. has codes in hexadecimal for each function. It starts in the example of this video reading from 8000 position in memory.

```python
rom[0] = 0xa9 # writes a9 to the 0 position in rom, which is 8000 in the microp. a9 corresponds to load some value to the A register -> LDA
rom[1] = 0x42 # just a random value, which is the next value being read, and then, as a9 receives an argument, 42 will be this argument.
# LDA 42
rom[2] = 0x8d #store value to an address
rom[3] = 0x00
rom[4] = 0x60 #stores value to 6000 address
```

#### How do CPUs read machine code?

Actually the CPU starts reading from a portion of memory and each command in assembly language (which, of course, relates directly to a binary command, which we are seing in this video in actual hexadecimals) and those commands will sometimes receive arguments which can be understood as addresses in memory or actual numbers. The commands are dependent on the architecture of the microprocessor and can be directly read from the datasheet of that processor.

This is how from electric signals we can get an actual program. Each word is composed of some pins 00000000 lets say, and to be one each pin is receiving an electric signal and to be zero it is not receiving that electric signal. The circuits inside the processor map some combinations of signal, non-signal, 1s and 0s to circuits which trigger some specific behaviours and those behaviors are what we call commands.

In 6502 it uses the same bus for memory and data and everything is being transfered at once. So if you want to store data you output it is necessary to attach another device to store that data, otherwise it is only going to be store for one clock cycle. Some other device to [latch data](<https://en.wikipedia.org/wiki/Flip-flop_(electronics)#Asynchronous_set-reset_latches>).

Then a bit part of the video is how to set up the device to keep the output data, the W65C22.

At this point I'm seriously considering if haven't I been too deep in this understanding how computers work rabit hole. I decide it's a 'no' and keep on with this playlist. However a break wouldn't hurt. Which of the first questions were actually answered?

### So a break: What are interpreted and compiled languages?

**Compiled languages** are, translated into machine code, they somehow map to how a computer works better, are lower level than interpreted languages. Some examples are Rust, Go, C, C++. There is a program like GCC or Clang that will actually read the code written in a compiled language and compile it to code that the computer can read. At this point we know that this code is memory addresses (defined not necessarily in the program but somewhere in the middle until it gets to the processor as such), numbers, strings... that map to binaries that a CPU can understand. Compiled language don't change depending on the architecture of your processor. The compiler will figure the correct translation without the need of the programmer to worry about it.

The binaries work in processors probably very similarly to what was seen [above](#how-do-cpus-read-machine-code--6502-part-2).

**Interpreted languages**, like Python, Ruby, JavaScript are not converted into machine code in this sense. There is, however, another program, called _the interpreter_ that will receive the Python program (CPython is the interpreter in this case) as input. The interpreter is compiled to machine code, but it will receive the .py file, read each chunk and immeadiately translate that into machine code that the CPU can read. The .py program won't be compiled but 'interpreted' [just in time](https://pt.wikipedia.org/wiki/JIT) as if it was part of the interpreter program.

This is a bit confusing.

Interpreted languages don't translate so directly to the functions of the processor, so how each instruction will be interpreted probably depends a lot on the implementation of the interpreter.

### Now going back to the [Learn 6502](https://jumplink.eu/Learn6502).

What is zero page: it is the first 256 bytes of memory (in case of MOS 6502) which allows for faster access. Nowadays it has more of a historical importance since it is less expensive to add more registers in the cpu and cpu operations are faster than RAM access. This first part of memory was used to calculate address in memory. I'm not sure I understand this.

#### Instructions/ Exercises:

_This can be run in the simulation console in the Learn 6502 course_

1. You’ve seen TAX. You can probably guess what TAY, TXA and TYA do, but write some code to test your assumptions.

```
LDA #$aa; A(register) is a mem place in the CPU?
TAY
STA $0200
ADC #$c4
STA $0201
BRK
```

```
LDA $aa; Lê da memória o conteúdo do end aa
TAX
LDA ($44, X) ; Soma o valor no end. 44 com o valor em X
BRK
```

2. Rewrite the first example in this section to use the Y register instead of the X register.

```
LDA #$c0  ;Load the hex value $c0 into the A register
TAY       ;Transfer the value in the A register to Y
INY       ;Increment the value in the Y register
ADC #$c4  ;Add the hex value $c4 to the A register
BRK
```

3. The opposite of ADC is SBC (subtract with carry). Write a program that uses this instruction.

```
LDA #$44
SBC #$11
BRK
```

```
A=$32 X=$00 Y=$00; Why is A 32 instead of 33 ?
SP=$ff PC=$0605
NV-BDIZC
00110001 ; How does Carry flag work?
```

#### Branching

Some variation:

```
  LDX #$42
wonderland:
  DEX
  STX $0200
  CPX #$40
  BNE wonderland
  STX $0201
  BRK
```

The tag `wonderland` is called a branch.

- `LDX #$42` loads hex 42 in the register X
- `wonderland` defines a branch of code to be executed in case of some condition, thos could have any name!
- `DEX` decrements X by 1
- `STX $0200` stores X in position $0200 in memory
- `CPX #$40` compares X to hex 40
- `BNE wonderland` Branches to wonderland in case X does not equal 40, else, does nothing.
- `STX $0201` stores X in position $0201 in memory

Exercises

1. The opposite of BNE is BEQ. Try writing a program that uses BEQ.

```
  LDX #$42
wonderland:
  DEX
  STX $0200
  CPX #$40
  BEQ wonderland
  STX $0201
  BRK
```

2. BCC and BCS (“branch on carry clear” and “branch on carry set”) are used to branch on the carry flag. Write a program that uses one of these two.

_How does Carry flag work?_
