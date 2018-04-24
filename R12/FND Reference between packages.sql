--all source reference
SELECT *
  FROM all_source als
 WHERE 1 = 1
   AND upper(als.text) LIKE '%%' --'%Schedule%start%date%greater%than%end%date%';
;
SELECT DISTINCT t.name
  FROM all_source t
 WHERE 1 = 1
   AND t.text LIKE '%p_actual_finish_date%'
   AND t.type LIKE 'PACKAGE BODY'
   AND EXISTS (SELECT 1
          FROM all_dependencies ad
         WHERE 1 = 1
           AND ad.referenced_name = 'PA_TASK_PUB1'
           AND ad.name = t.name);

SELECT DISTINCT t.name
  FROM all_source t
 WHERE 1 = 1
   AND upper(t.text) LIKE '%XXPA_COST_FLOW_DTLS%'
   AND t.type LIKE 'PACKAGE BODY';
