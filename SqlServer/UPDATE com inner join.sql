--UPDATE COM INNER JOIN
UPDATE t1
SET t1.coluna1 = t2.coluna2
FROM tabela1 t1
INNER JOIN tabela2 t2
ON t1.coluna_comum = t2.coluna_comum;