--ar transaction
--ar header

SELECT rct.*
  FROM ra_customer_trx_all       rct
WHERE 1=1
AND rct.trx_number = 'JPYI7066169'
AND rct.customer_trx_id = 4022542
;



SELECT *
  FROM ra_customer_trx_all       rct,
       ra_customer_trx_lines_all rctl
 WHERE 1 = 1
   AND rct.customer_trx_id = rctl.customer_trx_id
   AND rct.trx_number = 'JPYI7066169';
