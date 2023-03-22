SELECT st.REF, design ,ST.pv1,sgc.cor,sx.tam, Sa.STOCK,Sx.armazem FROM ST 
INNER JOIN SGC ON sgc.ststamp=st.ststamp 
INNER JOIN SA ON st.ref=sa.ref      
INNER JOIN SX ON sx.ststamp=st.ststamp   
WHERE ST.TEXTEIS =1 and SGC.cor = 'Laranja' and ST.USR4  like '%%'  
AND ST.ref=SA.ref  AND  Sa.armazem =700 and sx.stock >0
GROUP BY st.REF, design ,ST.pv1,sgc.cor, Sa.STOCK,Sx.armazem,sx.tam

SELECT stock FROM sx (nolock) where sx.ref='SW301             ' and sx.cor='Cinzento Escuro          ' and sx.tam ='XXXL                     ' and sx.armazem=700
SELECT * FROM sgc where ref ='SW301  '