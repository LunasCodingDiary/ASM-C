;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  file name   : factorial_sub.asm                          ;
;  author      : Lu Fang
;  description : LC4 Assembly program to compute the    ;
;                factorial of a number, using subroutine                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
;;; pseudo-code of factorial algorithm
;
; A = 5 ;  // example to do 5!
; B = A ;  // B=A! when while loop completes
;
; while (A > 1) {
; 	A = A - 1 ;
; 	B = B * A ;
; }
;

;;; TO-DO: Implement the factorial algorithm above using LC4 Assembly instructions

MAIN 
  CONST R0, #6    ; A = 6
  ADD R1, R0, #0    ; B = A
  JSR SUB_FAC     ; CALL TO SUBROUTINE, B = sub_factorial (A) 
  JMP END  

.FALIGN  ;aligns the subroutine
SUB_FAC 
  
  CMPI R0, #0 ; NZP(A-0)
  BRp CONTINUE ;  continue
    SUB R1, R1, R0 
    ADD R1, R1, #-1 ; B=-1
    JMP END_FAC ; end subroutine
  
  CONTINUE  
  CMPI R0, #8 ;NZP(A-8), 65535 is the max that hex byte can represent 
  BRnz CONTINUE_2 ; continue
    SUB R1, R1, R0 
    ADD R1, R1, #-1 ; B=-1
    JMP END_FAC ; end subroutine
  
  CONTINUE_2
  CMPI R0, #1     ; sets  NZP (A-1), while loop
  BRnz END        ; tests NZP (was A-1 neg or zero?, if yes, goto END)
  ADD R0, R0, #-1 ; A=A-1
  MUL R1, R1, R0  ; B=A*B
  BRnzp SUB_FAC   ; goto LOOP
  END_FAC
  RET ;end subroutine


END ;end program 
