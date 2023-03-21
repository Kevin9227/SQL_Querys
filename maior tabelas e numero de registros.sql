SELECT OBJECT_NAME(ID) As Tabela, Rows As Linhas FROM sysindexes
WHERE IndID IN (0,1)
ORDER BY Linhas DESC