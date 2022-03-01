;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : dmem_fact.asm                          ;
;  author      : Lu Fang
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number, using subroutine                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
.DATA ;lines below are DATA memory
.ADDR x4020 ; where to start in DATA memory

global_array
.FILL #6 ; x4020 =6
.FILL #5 ; x4021 =5
.FILL #8 ; x4022 =8
.FILL #10 ; x4023 =10
.FILL #-5 ; x4024 =-5

.CODE ;lines below are Program memory
.ADDR x0000 ; where to start in Program Memory

INIT 
 LEA R0, global_array ; load starting address of data to R0
 CONST R1 #5   ;loop counter

FOR_LOOP
 CMPI R1, #0 ;subtract 0 from the loop counter (R1), set NZP
 BRnz END; if R1 is <=0, done, jump to END
 LDR R2, R0, #0 ;LOAD the data (at R0) into R2
 ADD R3, R2, #0 ; R3=R2, to be updated in the subroutine
 JSR SUB_FAC     ; CALL TO SUBROUTINE, R3 = sub_factorial (R2) 
 CONTINUE
 STR R3, R0, #0; write in the data at R3 to the data address at R0
 ADD R0, R0, 1 ; increment REG holding address 
 ADD R1, R1, #-1 ;reduce for loop counter by 1
 SUB R3, R3, R3; reset R3 to 0
 JMP FOR_LOOP ;go on loop
END ;end program 

.FALIGN  ;aligns the subroutine
SUB_FAC 
  CMPI R2, #0 ; NZP(A-0)
  BRp CONTINUE_1 ;  continue
    SUB R3, R3, R2 
    ADD R3, R3, #-1 ; B=-1
    JMP END_FAC ; end subroutine
  
  CONTINUE_1  
  CMPI R2, #8 ;NZP(A-8), 65535 is the max that hex byte can represent 
  BRnz CONTINUE_2 ; continue
    SUB R3, R3, R2 
    ADD R3, R3, #-1 ; B=-1
    JMP END_FAC ; end subroutine
  
  CONTINUE_2
  CMPI R2, #1     ; sets  NZP (A-1), while loop
  BRnz CONTINUE    ; tests NZP (was A-1 neg or zero?, if yes, goto END)
  ADD R2, R2, #-1 ; A=A-1
  MUL R3, R3, R2  ; B=A*B
  BRnzp SUB_FAC   ; goto LOOP
  END_FAC ; end of loop
  RET ;end subroutine

