SELECT v.request_id,
       v.request_date,
       v.program_short_name,
       v.user_concurrent_program_name,
       v.requestor,
       v.argument_text,
       v.responsibility_application_id app_id,
       (SELECT fa.application_short_name
          FROM fnd_application fa
         WHERE 1 = 1
           AND fa.application_id = v.responsibility_application_id) app_name /*,
           v.RESPONSIBILITY_ID,
           (SELECT fr.responsibility_key
           FROM fnd_responsibility fr
           WHERE 1=1
           AND fr.responsibility_id = RESPONSIBILITY_ID
           AND ROWNUM = 1)*/
  FROM fnd_conc_req_summary_v v
 WHERE 1=1
-- AND v.program_short_name = 'XXPAPCA_NEW3'
AND v.program LIKE '%XXPA:Project Cost Analysis (SHE/HET) NEW%%'
 --AND v.argument_text LIKE 'SHE_FAC_ORG%';
