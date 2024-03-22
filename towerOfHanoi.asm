# Luis Miguel Fontes Cardona - 741547
# Victor Sebastian Huerta Silva - 740347
# Ing. en Sistemas Computacionales
# Organizacion y arquitectura de computadoras
# Practica 1: Torres de Hanoi
# ---------- Torres de Hanoi ---------- #

.text
	addi t0, zero, 1 	# i = 1 (ciclo for)
	addi t1, zero, 1	# Inicializacion en 1 para el caso default
	addi a2, zero, 8	# n = 8 (8 discos)

	slli s0, a2, 2		# Multiplicar por 4

	lui s1, 0x10010		# Apuntador al Arreglo A
	add s2, s1, s0		# Apuntador al Arreglo B
	add s3, s2, s0		# Apuntador al Arreglo C

for:				# Ciclo for para inicializar los valores de la torre
	blt a2, t0, endfor	# Condicion del ciclo for: i < n
	sw t0, 0(s1)		# Inicializamos el valor de i en la torre A
	addi s1, s1, 4		# Nos movemos 4 bits para la siguiente posicion
	addi s2, s2, 4
	addi s3, s3, 4
	addi t0, t0, 1		# i++
	jal for

endfor:
	addi s1, s1, -4		# Como el ciclo for se ejecuta 1 vez mas de lo necesario
	addi s2, s2, -4		# Se tiene que restar -4 para no perder la referencia al
	addi s3, s3, -4		# ultimo espacio correspondiente de la torre

	jal towerOfHanoi
	jal endcode

towerOfHanoi:
	beq a2, t1, default	# if n == 1 -> default

	# Necesitamos crear espacio en el SP (Push al stack), para esto restamos -4 al SP
	addi sp, sp, -4
	sw ra, 0(sp)		# Metemos el return (ra)
	addi sp, sp, -4
	sw s1, 0(sp)		# Metemos la Primera torre (A)
	addi sp, sp, -4
	sw s2, 0(sp)		# Metemos la Segunda torre (B)
	addi sp, sp, -4
	sw s3, 0(sp)		# Metemos la Tercera torre (C)
	addi sp, sp, -4
	sw a2, 0(sp)		# Metemos el numero de discos (n)

	# Modificacion de argumentos
	addi a2, a2, -1		# n - 1 de los discos

	addi s1, s1, -4		# Recorremos los apuntadores
	addi s2, s2, -4
	addi s3, s3, -4

	# Switch de las torres
	addi t3, s2, 0 		# Asignacion de s2 a un auxiliar
	addi s2, s3, 0		# Switch de s2 con s3
	addi s3, t3, 0		# Switch de s3 con auxiliar

	jal towerOfHanoi	# Llamada recursiva

	# Pop del stack
	lw a2, 0(sp)
	addi sp, sp, 4
	lw s3, 0(sp)
	addi sp, sp, 4
	lw s2, 0(sp)
	addi sp, sp, 4
	lw s1, 0(sp)
	addi sp, sp, 4
	lw ra, 0(sp)
	addi sp, sp, 4

	# Hacemos el swap de discos
	sw zero, 0(s1) 		# Pop al disco
	sw a2, 0(s3)		# Push al disco

	# Necesitamos crear espacio en el SP (Push al stack), para esto restamos -4 al SP
	addi sp, sp, -4
	sw ra, 0(sp)		# Metemos el return (ra)
	addi sp, sp, -4
	sw s1, 0(sp)		# Metemos la Primera torre (A)
	addi sp, sp, -4
	sw s2, 0(sp)		# Metemos la Segunda torre (B)
	addi sp, sp, -4
	sw s3, 0(sp)		# Metemos la Tercera torre (C)
	addi sp, sp, -4
	sw a2, 0(sp)		# Metemos el numero de discos (n)

	# Modificacion de argumentos
	addi a2, a2, -1		# n - 1 de los discos

	addi t2, s1, 0 		# Asignacion de s1 a un auxiliar
	addi s1, s2, 0		# Switch de s1 con s2
	addi s2, t2, 0		# Switch de s2 con auxiliar

	addi s1, s1, -4		# Recorremos los apuntadores
	addi s2, s2, -4
	addi s3, s3, -4

	jal towerOfHanoi	# Llamada recursiva

	# Necesitamos crear espacio en el SP (Push al stack), para esto restamos -4 al SP
	lw a2, 0(sp)
	addi sp, sp, 4
	lw s3, 0(sp)
	addi sp, sp, 4
	lw s2, 0(sp)
	addi sp, sp, 4
	lw s1, 0(sp)
	addi sp, sp, 4
	lw ra, 0(sp)
	addi sp, sp, 4

	jalr ra			# Retornamos el valor

default:
	add t3, zero, ra	# Guardamos el valor de ra
	
	# Hacemos el swap de discos
	sw zero, 0(s1) 		# Pop al disco
	sw a2, 0(s3)		# Push al disco
	
	add ra, zero, t3 	# Se suma en ra

	jalr ra			# Retorno del valor

endcode: nop
