SELECT 
     cl.nome, 
    cl.ncont, 
    SUM(ft.etotal - ft.ettiva) AS valor
FROM 
    ft (NOLOCK)  
INNER JOIN 
    td (NOLOCK) ON ft.ndoc = td.ndoc AND td.regrd = 0  
INNER JOIN 
    cl (NOLOCK) ON ft.no = cl.no AND cl.estab = 0  
WHERE 
    ft.anulado = 0 
    AND ft.fno >= 0 
    AND ft.fdata BETWEEN '20221201' AND '20240201' 
    AND ft.tipodoc <> 4 
    AND ft.tipodoc <> 5 
    AND ft.tipodoc <> 2 
    AND td.tiposaft <> 'FC' 
    AND td.tiposaft <> 'CC' 
GROUP BY 
    cl.nome, 
    cl.ncont 
HAVING 
    SUM(ft.etotal - ft.ettiva) >=1000000
ORDER BY 
    valor DESC