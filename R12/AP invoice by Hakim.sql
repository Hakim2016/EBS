--AP invoice v1.0

--AP with Project/Task
SELECT aph.creation_date,
       aph.invoice_type_lookup_code invoice_type,
       aph.invoice_id,
       aph.invoice_num,
       aph.invoice_amount,
       aph.amount_paid,
       aph.pay_curr_invoice_amount,
       aph.project_id,
       ppa.segment1 proj_num,
       pt.task_number,
       aph.*
  FROM ap_invoices_all aph,
       pa_projects_all ppa,
       pa_tasks        pt
 WHERE 1 = 1
   AND aph.task_id = pt.task_id(+)
   AND aph.org_id = 82--84--SHE--82 --HEA
   AND aph.project_id = ppa.project_id(+) --left join
   AND aph.invoice_num = 'SG00043803*7'--'107/5350';--454220
   --AND aph.invoice_num LIKE 'HKM%'
   AND aph.creation_date >= to_date('2018-03-11', 'yyyy-mm-dd')
 ORDER BY aph.creation_date DESC;
 
SELECT * FROM ap_invoices_all aph,
ap_invoice_lines_all apl
WHERE 1=1
AND aph.invoice_id = apl.invoice_id
AND aph.invoice_num = 'SG00043803*7'
AND aph.org_id = 82 --HEA
;
/* UPDATE ap_invoices_all aph
 SET aph.invoice_num = 'HKM18031302'--HKIM18021302
 WHERE 1=1
 AND aph.invoice_id = 1882328*/
