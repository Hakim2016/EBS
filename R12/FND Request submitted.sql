SELECT v.request_id,
       v.request_date,
       v.REQUESTED_BY,
       v.actual_completion_date,
       v.phase_code,
       v.status_code,
       v.program_short_name short_name,
       v.user_concurrent_program_name,
       v.requestor,
       v.argument_text,
       v.responsibility_application_id app_id,
       (SELECT fa.application_short_name
          FROM fnd_application fa
         WHERE 1 = 1
           AND fa.application_id = v.responsibility_application_id) app_name ,
           v.RESPONSIBILITY_ID,
           fr.responsibility_key
  FROM fnd_conc_req_summary_v v,
  fnd_responsibility fr
 WHERE 1 = 1
 AND fr.responsibility_id = v.RESPONSIBILITY_ID
 --AND v.request_id = 15956670
      --AND v.program_short_name = 'XXPAUPDATESTATUS'
      --AND v.program LIKE 'Create Accounting%'
   AND v.user_concurrent_program_name LIKE 
   '%Project Cost Analysis%'
   --'XXGL:Fixed Assets Outbound to HFG'
   --'Projects Cost Collection Manager'
--'Cost Collection Manager'
--######conplatibility of <XXPA:Project Status Update(BA)> start
/*AND v.user_concurrent_program_name IN (
'XXPA:Project Status Update(BA)',
'XXPA:Generate Expenditure Batch For Cost Structure',
'XXPA:Project Revenue and Cost of Sales Recognition Request',
'XXPA:Project EQ Cost of Sales Recognition Request(HEA/HBS)',
--
'XXPA:Project Status Update(Installation)'
)*/
--######conplatibility of <XXPA:Project Status Update(BA)> end
--'XXPA:Project Status Update(BA)'
--'XXAR: Delivery Interface outbound GSCM to R3'
--'XXPA%Project Revenue and Cost of Sales Recognition Request'
--'Period Close Reconciliation Report'
--'PRC: Transaction Import'
--'XXPA:Project Cost Data Outbound'

--AND v.request_date > TRUNC(SYSDATE)
AND trunc(v.request_date) >= to_date('2018-05-09','yyyy-mm-dd')
AND v.argument_text LIKE '%SHE_FAC_ORG%%'--'HEA_Oracle,%'
--AND v.requestor = 'HAND_HKM'
--AND v.status_code = 'Q'
 ORDER BY v.request_id;
 
