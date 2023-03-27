--Verificar registro duplicados

SELECT nome, COUNT(nome)
FROM 'Tabela'
GROUP BY nome
HAVING COUNT(nome) > 1;