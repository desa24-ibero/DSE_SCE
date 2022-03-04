
SELECT name, xtype FROM sysobjects 
WHERE id IN(
SELECT id FROM syscomments 
WHERE text like '%periodo%'
)
AND NAME NOT LIKE '%sepe%' 
AND NAME NOT LIKE '%sit%' 
AND NAME NOT LIKE '%pago%' 
AND NAME NOT LIKE '%mobile%' 
AND NAME NOT LIKE '%abono%' 
AND NAME NOT LIKE '%dt_%' 
AND NAME NOT LIKE '%importes%' 
AND NAME NOT LIKE '%amex%' 
AND NAME NOT LIKE '%banorte%' 
AND NAME NOT LIKE '%saia%' 
AND NAME NOT LIKE '%sfeb%' 
AND NAME NOT LIKE '%kiosco%' 
AND NAME NOT LIKE '%tpv%' 
AND NAME NOT LIKE '%me%' 
AND NAME NOT LIKE '%monedero%' 
AND NAME NOT LIKE '%colegiatura%' 
AND NAME NOT LIKE '%recargos%' 
AND NAME NOT LIKE '%cotiza%' 
AND NAME NOT LIKE '%costo%' 
AND NAME NOT LIKE '%adeudo%' 
AND NAME NOT LIKE '%se3%' 
AND NAME NOT LIKE '%cuetionario%' 
AND NAME NOT LIKE '%magis%' 
AND NAME NOT LIKE '%tasa%' 
AND NAME NOT LIKE '%inscripcion%' 
AND NAME NOT LIKE '%mu_%' 
ORDER BY 2,1



SELECT id, text FROM syscomments 
WHERE text like '%periodo%'



SELECT id, text FROM syscomments 
WHERE text like '%''''%'
