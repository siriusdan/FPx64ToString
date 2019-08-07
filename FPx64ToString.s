.data
      msg1: .asciiz "Entre un numero:"
      msg2: .ascii "El numero en hexa es: 0x"
      msg3: .asciiz "00000000\n"
      hexa: .ascii "0123456789ABCDEF"
      msg4: .ascii "El signo es: 0x"
      sig:  .asciiz "00000000\n"
      msg5: .ascii "El exponente en exceso es: 0x"
      expe: .asciiz "00000000\n"
      msg6: .ascii "El exponente es: 0x"
      exp:  .asciiz "00000000\n"

.text
      main:
            li $v0, 4 
            la $a0, msg1
            syscall		      #imprime mensaje  "Entre un numero:"

            li $f0, 7
            syscall		      #espera un numero 
            move $a0, $f0
            
            slt $t3, $0, $f0        #compara con 0 para saber el signo, guarda el resultado en t3

            la $a1, msg3	      #a1 = "00000000\n"

            jal i2hs		      #va a la funcion i2hs

            li $v0, 4
            la $a0, msg2
            syscall		      #imprime mensaje  "El numero en hexa es: 0x"

            li $v0, 10
            syscall		      #finaliza el programa

      i2hs: 
            addi $sp, $sp, -8       #pide espacio en el stack
            sw  $a1, 0($sp)	      #guarda en el stack 
            sw  $a0, 4($sp)

            la   $t1, hexa
            li   $t2, 8
            addi $a1, $a1, 7		#mueve a1 a la pos 7 del array 

      L1:   
            andi $t0, $a0, 0xf	#creo que este es el error andi $t0, $a0, 0xf
            add  $t0, $t1, $t0	#
            lb   $t0, ($t0)
            sb   $t0, ($a1)
            srl  $a0, $a0, 4		
            addi $a1, $a1, -1
            addi $t2, $t2, -1
            beqz $t2, E1
            j L1

      E1:   
            lw  $a1, 0($sp)
            lw  $a0, 4($sp)
            jr $ra
            
