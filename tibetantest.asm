 .include	"tn28def.inc"

.def  scratch = R16

.def  scratch2 = R17

.def  counterA0 = R18

.def  counterCB = R19

.def  counterED = R20

.def  parodyleft = R21

.def  parodyright = R22

.def  function = R23

.equ  FQ0 = 0

.def  FQ1 = R24

.def FQ2 = R25

.equ  FQ3 = 3

.equ  Q0 = 0

.equ  Q1 = 1

.equ  Q2 = 2

.equ  Q3 = 3

.equ  AQ0 = 4

.equ  AQ1 = 5

.equ  AQ2 = 6

.equ  AQ3 = 7

.equ  BQ0 = 0

.equ  BQ1 = 1

.equ  BQ2 = 2

.equ  BQ3 = 3

.equ  CQ0 = 4

.equ  CQ1 = 5

.equ  CQ2 = 6

.equ  CQ3 = 7

.equ  DQ0 = 0

.equ  DQ1 = 1

.equ  DQ2 = 2

.equ  DQ3 = 3

.equ  EQ0 = 4

.equ  EQ1 = 5

.equ  EQ2 = 6

.equ  EQ3 = 7



loop:

wait:

waitloop:

sbis  pinB,0

rjmp waitloop


ser scratch

out ddrd,scratch

clr scratch

sbrc parodyleft,0

sbr scratch,0x01

sbrc parodyright,0

sbr scratch,0x04

out portd,scratch

clr scratch

mov FQ1,scratch

mov FQ2,scratch

ser scratch

sbic PINB,3

mov FQ1,scratch

sbic pinB,4

mov FQ2,scratch


clr parodyright

clr parodyleft


clr scratch

ldi  scratch2,0X01

add  counterA0,scratch2

adc  counterCB,scratch

adc  counterED,scratch


clr parodyleft

clr parodyright


termAZ01:

sbrs  counterA0,Q0

rjmp termAZ02

sbrc  counterCB,CQ0

inc  parodyleft


termAZ02:

sbrs  counterA0,Q1

rjmp  termAZ11

sbrc  counterCB,CQ1

inc  parodyleft


termAZ11:

sbrs  counterA0,Q2

rjmp  termAZ12

sbrc  counterCB,CQ2

inc  parodyleft


termAZ12:

sbrs  counterA0,Q3

rjmp  termAZ21

sbrc counterCB,CQ3

inc parodyleft


termAZ21:

sbrs  counterA0,AQ0

rjmp  termAZ22

sbrc  counterCB,BQ0

inc  parodyleft


termAZ22:

sbrs  counterA0,AQ1

rjmp termAZ31

sbrc counterCB, BQ1

inc parodyleft


termAZ31:

sbrs  counterA0,AQ0

rjmp termAZ32

sbrc counterCB,BQ2

inc parodyleft


termAZ32:

sbrs  counterA0,AQ1

rjmp  termBZ01

sbrc  counterCB,BQ3

inc parodyleft


termBZ01:

sbrs  counterCB,BQ0

rjmp  termBZ02

sbrc  counterED,DQ0

inc parodyleft


termBZ02: 

sbrs  counterCB,BQ1

rjmp  termBZ11

sbrc counterED,DQ1

inc parodyleft


termBZ11:

sbrs counterCB,BQ2

rjmp termBZ12

sbrc  counterED,DQ2

inc parodyleft


termBZ12:

sbrs counterCB,BQ3

rjmp  termEZ01

sbrc  counterED,DQ3

inc parodyleft 


termEZ01:

clr  scratch

sbrs  counterA0,Q0

rjmp  termEZ02

sbrs  counterCB,CQ0

rjmp  termEZ02

sbrc  counterED,EQ2

rjmp  termEZ02

ldi  scratch,01



termEZ02:

sbrs counterA0,Q3

rjmp termEZ03

sbrs  counterCB,CQ1

rjmp  termEZ03

sbrs  counterED,EQ2

rjmp  termEZ03

ldi  scratch,01


termEZ03:

add  parodyright,scratch

clr scratch

sbrs  counterED,EQ1

rjmp  termEZ04

sbrs  counterED,EQ2

rjmp termEZ04

rjmp termEZ05


termEZ04:

sbrs  counterA0,Q1

rjmp  termEZ05

sbrs counterCB,CQ1

rjmp  termEZ05

ldi  scratch,01


termEZ05:

sbrs counterA0,Q2

rjmp termEZ11

sbrs counterCB,CQ3

rjmp termEZ11

sbrs counterED,EQ3

rjmp termEZ11

sbrs counterED,EQ1

rjmp termEZ11

sbrs counterED,EQ2

rjmp termEZ11

ldi  scratch,01


termEZ11:

add parodyright,scratch



sbrs counterA0,Q2

rjmp  termEZ12

sbrc  counterCB,CQ2

inc parodyright


termEZ12:

sbrs  counterA0,Q3

rjmp  termEZ21

sbrc counterCB,CQ3

inc parodyright



termEZ21:

clr scratch

sbrs counterA0,AQ0

rjmp termEZ22

sbrs counterCB,BQ1

rjmp termEZ22

sbrc  FQ1,0

rjmp  termEZ22

ldi  scratch,01


termEZ22:

sbrs counterA0,AQ0

rjmp termEZ23

sbrs  counterCB,BQ0

rjmp  termEZ23

sbrs FQ1,0

rjmp  termEZ23

ldi  scratch,01


termEZ23:

add parodyright,scratch

clr scratch

sbrs  counterA0,AQ1

rjmp  termEZ24

sbrs  counterCB,BQ0

rjmp  termEZ24

sbrc  FQ1,0

rjmp termEZ24

ldi scratch,01



termEZ24:

sbrs counterA0,AQ1

rjmp termEZ31

sbrs counterCB,BQ1

rjmp termEZ31

sbrs  FQ1,0

rjmp termEZ31

ldi scratch,01


termEZ31:

add parodyright,scratch

sbrs counterA0,AQ0

rjmp termEZ32

sbrc counterCB,BQ2

inc  parodyright


termEZ32:

sbrs  counterA0,AQ1

rjmp termFZ01 

sbrc  counterCB,BQ3

inc parodyright


termFZ01:

sbrs counterCB,BQ0

rjmp termFZ02

sbrc  counterED,DQ0

inc parodyright



termFZ02:

sbrs counterCB,BQ1

rjmp termFZ11

sbrc counterED,DQ1

inc parodyright


termFZ11:

clr scratch

sbrs  counterCB,BQ2

rjmp termFZ12

sbrs counterED,DQ2

rjmp termFZ12

sbrc FQ2,0

rjmp termFZ12

ldi scratch,01


termFZ12:

sbrs counterCB,BQ2

rjmp termFZ13

sbrs counterED,DQ3

rjmp termFZ13

sbrs FQ2,0

rjmp termFZ13

ldi scratch,01


termFZ13:

add parodyright,scratch

clr scratch

sbrs  counterCB,BQ3

rjmp termFZ14

sbrs counterED,DQ3

rjmp termFZ14

sbrc FQ2,0

rjmp termFZ14

ldi scratch,01



termFZ14:

sbrs counterCB,BQ3

rjmp termsexit

sbrs counterED,DQ2

rjmp termsexit

sbrs FQ2,0

rjmp termsexit


termsexit:

add parodyright,scratch



rjmp loop



























 




























































