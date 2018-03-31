SELECT intf.actual_month,
       intf.company_name,
       pt.task_number,
       ppa.segment1 proj_num,
       intf.mfg_num,
       intf.sale_amount,
       intf.material,
       intf.labour,
       intf.subcon,
       intf.packing_freight
       --intf.*
  FROM xxpa_cost_gcpm_int intf,
       pa_tasks           pt,
       pa_tasks           top,
       pa_projects_all    ppa
 WHERE 1 = 1
   AND ppa.project_id = pt.project_id
   AND pt.top_task_id = top.task_id
   AND pt.task_id = intf.task_id
      --AND intf.org_id = 82
      --AND intf.eq_er_category = 'EQ'
      --AND intf.mfg_num IN ('TAE0970-TH', 'TAE0969-TH', 'TAE0968-TH')
      --AND pt.task_number LIKE '%.D.11'
   AND (pt.task_number NOT LIKE '%.EQ' AND pt.task_number NOT LIKE '%.ER')
   --AND intf.actual_month = to_date('2017-08-01', 'yyyy-mm-dd')

   AND intf.group_id = (SELECT MAX(t2.group_id)
                          FROM xxpa_cost_gcpm_int t2
                         WHERE 1 = 1
                           AND t2.mfg_num = intf.mfg_num
                           AND t2.actual_month = intf.actual_month
                           AND t2.task_id = intf.task_id)
 ORDER BY intf.actual_month,
          intf.mfg_num DESC
