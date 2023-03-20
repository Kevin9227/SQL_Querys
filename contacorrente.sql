declare @no int
set @no =370

 

select cl.nome, cl.no, cl2.cativaperc, cc.cmdesc, cc.nrdoc, cc.datalc, cc.evirs, totcativa.evirs, totcativa.eivacativado as EIVACATFT, cc.eivacativado as EIVACatCC, totcativa.cativaperc,
sum( case when (cc.evirs <> 0 and cc.edeb <> 0) then case when cc.edeb > 0 then (cc.edeb - cc.evirs) - abs(isnull(totcativa.eivacativado, 0)) else (cc.edeb + cc.evirs) + abs(isnull(totcativa.eivacativado, 0)) end else case when cc.edeb <> 0 then cc.edeb - abs(isnull(totcativa.eivacativado, 0)) else 0 end end) edeb,
sum( case when (cc.evirs <> 0 and cc.ecred <> 0) then case when cc.ecred > 0 then (cc.ecred - cc.evirs) - abs(isnull(totcativa.eivacativado, 0)) else (cc.ecred + cc.evirs) + abs(isnull(totcativa.eivacativado, 0)) end else case when cc.ecred <> 0 then cc.ecred - abs(isnull(totcativa.eivacativado, 0)) else 0 end end) ecred,
sum((edeb-edebf)-(ecred-ecredf)-case when (edeb-edebf)-(ecred-ecredf)!=0 then (cc.eivacativado-eivacatreg)*(1-(edebf+ecredf)/(edeb+ecred)) else 0 end) nreg,
sum( case when (cc.evirs <> 0 and cc.edeb <> 0) then case when cc.edeb > 0 then (cc.edeb - cc.evirs) - abs(isnull(totcativa.eivacativado, 0)) else (cc.edeb + cc.evirs) + abs(isnull(totcativa.eivacativado, 0)) end else case when cc.edeb <> 0 then cc.edeb - abs(isnull(totcativa.eivacativado, 0)) else 0 end end)
- sum( case when (cc.evirs <> 0 and cc.ecred <> 0) then case when cc.ecred > 0 then (cc.ecred - cc.evirs) - abs(isnull(totcativa.eivacativado, 0)) else (cc.ecred + cc.evirs) + abs(isnull(totcativa.eivacativado, 0)) end else case when cc.ecred <> 0 then cc.ecred - abs(isnull(totcativa.eivacativado, 0)) else 0 end end) as 'cc'
from cc (nolock)
left join
(
select ft.ftstamp, ft3.eivacativado, ft3.ivacativado, ft3.mivacativado, ft3.cativaperc, ft.evirs
from ft (nolock)
inner join ft3 (nolock) on ft3.ft3stamp = ft.ftstamp
union all
select rd.rdstamp as ftstamp, rd.eivacativado, rd.ivacativado, rd.mivacativado, rd.cativaperc, 0
from rd (nolock)
) as totcativa on cc.ftstamp = totcativa.ftstamp or cc.rdstamp = totcativa.ftstamp
left join re (nolock) on cc.restamp = re.restamp
inner join cl (nolock) on cl.no = cc.no and cl.estab = cc.estab
inner join cl2 on cl.clstamp = cl2.cl2stamp
where
cl.no = @no
and (isnull(cc.edeb,0) = 0 or isnull(re.ecativa,0) <> isnull(cc.edeb,0)) and (isnull(cc.ecred,0) = 0 or isnull(re.ecativa,0) <> isnull(cc.ecred,0)) and (isnull(cc.edeb,0) = 0 or isnull(re.evirs,0) <> isnull(cc.edeb,0)) and (isnull(cc.ecred,0) = 0 or isnull(re.evirs,0) <> isnull(cc.ecred,0))

group by cl.nome, cl.no, cl2.cativaperc, cc.cmdesc, cc.nrdoc, cc.datalc, cc.evirs, totcativa.evirs, totcativa.eivacativado,cc.eivacativado, totcativa.cativaperc

