addi $14,$zero,0xffff
addi $2,$zero,0x00ff
addi $13,$zero,0x0004
add $3, $13, $2
and $4, $3, $13
andi $5, $3, 0xffff
sw $5, 0x10010000($0)
lw $6, 0x10010000($0)
add $15, $14, $2
nor $7, $4, $13
or $8, $5, $2
ori $9, $6, 0x0f0f
slt $10, $2, $13
slti $11, $5, 0x000c
sh $15, 0x10010020($0)
lw $16,0x10010020($0)
sub $12, $5, $9
addi $2, $zero, 0x0034
#j etiqueta
#jr $10


