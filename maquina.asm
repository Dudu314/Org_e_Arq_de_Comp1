.data
	C_CAFE: .word 20
	C_LEITE: .word 20
	C_CHOCOLATE: .word 20
	OPCOES: .asciiz "Escolha uma das seguintes op��es: \n 1: Caf� \n 2: Caf� com leite \n 3: Chocolate quente \n"
	TAMANHO: .asciiz "Escolha um tamanho: \n 1: Pequeno \n 2: Grande \n"
	TERMINADO: .asciiz "\nBebida pronta! \n\n"
	REPOSICAO: .asciiz "� necess�ria a reposi��o dos conteiners para preparar esta bebiba.\n"
	INVALIDO: .asciiz "~Entrada inv�lida~ \n"
.text
	la	$s0, C_CAFE
	lw	$t1, 0($s0)
	la	$s1, C_LEITE
	lw	$t2, 0($s1)
	la	$s2, C_CHOCOLATE
	lw	$t3, 0($s2)
	
maquina:
	li	$v0, 4
	la	$a0, OPCOES
	syscall			# Imprimi as op��es no console
	
	li	$v0, 5
	syscall
	move	$t0, $v0	# Recebe entrada das op��es
###################################################################
	li	$v0, 4
	la	$a0, TAMANHO
	syscall			# Imprimi os tamanhos
	
	li	$v0, 5
	syscall
	move	$t4, $v0	# Recebe entrada dos tamanhos
###################################################################
	bne	$t0, 1, Else_0	# Op��o 1 - Caf�
	
	slt	$t5, $t1, $t4	
	beq	$t5, 1, Less	# Verifica se h� p� suficiente para este preparo
	
	sub	$t1, $t1, $t4	# Utiliza a quantidade de p�
	li	$v0, 4
	la	$a0, TERMINADO	
	syscall			# Imprime processo terminado
	j	maquina		
###################################################################
Else_0:	bne	$t0, 2, Else_1	# Op��o 2 - Caf� com Leite
	
	slt	$t5, $t1, $t4
	beq	$t5, 1, Less
	slt	$t5, $t2, $t4
	beq	$t5, 1, Less	# Verifica se h� p� suficiente para este preparo
	
	sub	$t1, $t1, $t4
	sub	$t2, $t2, $t4	# Utiliza a quantidade de p�
	li	$v0, 4
	la	$a0, TERMINADO
	syscall			# Imprime processo terminado
	j	maquina
###################################################################
Else_1:	bne	$t0, 3, Exit	# Op��o 3 - Chocolate Quente

	slt	$t5, $t3, $t4
	beq	$t5, 1, Less	# Verifica se h� p� suficiente para este preparo
	
	sub	$t3, $t3, $t4	# Utiliza a quantidade de p�
	li	$v0, 4
	la	$a0, TERMINADO
	syscall			# Imprime processo terminado
	j	maquina
###################################################################
Less:	li	$v0, 4
	la	$a0, REPOSICAO
	syscall			# Se n�o houver p� suficiente, imprime no console uma mensagem de aviso
	j	maquina
###################################################################
Exit:	li	$v0, 4
	la	$a0, INVALIDO
	syscall			# Se a entrada das op��es for inv�lida, imprime no console uma mensagem de aviso
	j	maquina
