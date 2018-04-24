SELECT intf.actual_month    act_mon,
       intf.company_name    ou,
       intf.eq_er_category  eqer,
       intf.additional_flag add_f,
       intf.creation_date,
       intf.created_by,
       pt.task_number,
       intf.sale_amount,
       intf.cogs,
       intf.material,
       intf.expense,
       intf.labour,
       intf.subcon,
       intf.packing_freight,
       pt.task_id,
       ppa.project_id,
       ppa.segment1         proj_num,
       ppa.project_type,
       intf.mfg_num,
       intf.sale_amount,
       intf.material,
       intf.labour,
       intf.subcon,
       intf.packing_freight,
       intf.*
  FROM xxpa_cost_gcpm_int intf,
       pa_tasks           pt,
       pa_tasks           top,
       pa_projects_all    ppa
 WHERE 1 = 1
   AND ppa.project_id = pt.project_id
   AND pt.top_task_id = top.task_id
   AND pt.task_id = intf.task_id
   AND intf.org_id = 82--84--SHE --82--HEA
   AND intf.eq_er_category = 'ER'
      AND intf.mfg_num IN ('SBC0266-SG')
      --('SBC0266-SG','SBC0256-SG','SAE0191-SG'/*'TAE0970-TH', 'TAE0969-TH', 'TAE0968-TH'*/)
      --AND pt.task_number LIKE '%.D.11'
      --AND (pt.task_number NOT LIKE '%.EQ' AND pt.task_number NOT LIKE '%.ER')
   --AND intf.actual_month = to_date('2017-04-01', 'yyyy-mm-dd')
   --AND nvl(intf.subcon, 0) <> 0
      --AND ppa.segment1 = '213100127'
   --AND intf.additional_flag = 'N'
   AND intf.group_id = (SELECT MAX(t2.group_id)
                          FROM xxpa_cost_gcpm_int t2
                         WHERE 1 = 1
                           AND t2.mfg_num = intf.mfg_num
                           AND t2.actual_month = intf.actual_month
                           AND t2.task_id = intf.task_id)
 ORDER BY intf.actual_month DESC,
          intf.mfg_num DESC;
          
SELECT * FROM fnd_user fu
WHERE 1=1
AND fu.user_id IN (1133, 4088);

--SHE Subcon
SELECT --SUM(0 - XCFD.EXPENDITURE_AMOUNT) AMT
--intf.actual_month,
 xcfd.creation_date,
 xcfd.last_update_date,
 xcfd.expenditure_item_date expen_date,
 pt.task_number,
 ppa.segment1 proj_num,
 ppa.project_type,
 xcfd.org_id,
 xcfd.transfered_pa_flag trsfr,
 xcfd.cost_type,
 xcfd.expenditure_type,
 (0 - xcfd.expenditure_amount) amt,
 xcfd.expenditure_reference expen_rfr,
 xcfd.expenditure_reference
  FROM xxpa_cost_flow_dtls_all xcfd,
       pa_tasks                pt,
       pa_projects_all         ppa
 WHERE 1 = 1
   AND ppa.project_id = pt.project_id
   AND xcfd.task_id = pt.task_id
   AND substr(xcfd.expenditure_reference, 1, 7) = 'ACCRUAL'
   AND nvl(xcfd.transfered_pa_flag, 'N') = 'Y'
   AND xcfd.task_id = 4704925 --5704947--5705016--5705085--5705154--5705223--1888830--1102861--P_TASK_ID
   AND xcfd.org_id = 84 --P_ORG_ID
   AND xcfd.expenditure_item_date <= to_date('2018-03-01', 'yyyy-mm-dd') --P_END_DATE
   AND decode(cost_type,
              'FAC_FG',
              'SHE_FAC_ORG',
              'FAC_TO_HO_FG',
              'SHE_HQ_ORG',
              'FINAL_FG',
              decode(xcfd.org_id, 141, 'HET_HQ_ORG', 'SHE_HQ_ORG'), --Modify by jingjing 20180226 v5.00
              NULL) IN (SELECT ood.organization_name
                          FROM org_organization_definitions ood
                         WHERE ood.operating_unit = 84 /*P_ORG_ID*/
                        );

SELECT --SUM(0 - XCFD.EXPENDITURE_AMOUNT) AMT
--intf.actual_month,
/*xcfd.creation_date,
xcfd.last_update_date,
xcfd.expenditure_item_date expen_date,
 pt.task_number,
 ppa.segment1 proj_num,
 ppa.project_type,
 xcfd.org_id,
 xcfd.transfered_pa_flag trsfr,
 xcfd.cost_type,
 xcfd.expenditure_type,
 (0 - xcfd.expenditure_amount) amt,
 xcfd.expenditure_reference expen_rfr,
 xcfd.expenditure_reference*/
 SUM((0 - xcfd.expenditure_amount))
  FROM xxpa_cost_flow_dtls_all xcfd,
       pa_tasks                pt,
       pa_projects_all         ppa
 WHERE 1 = 1
   AND ppa.project_id = pt.project_id
   AND xcfd.task_id = pt.task_id
      --AND substr(xcfd.expenditure_reference, 1, 7) = 'ACCRUAL'
      --AND nvl(xcfd.transfered_pa_flag, 'N') = 'Y'
   AND xcfd.task_id = 4704925 --5704947--5705016--5705085--5705154--5705223--1888830--1102861--P_TASK_ID
   AND xcfd.org_id = 84 --P_ORG_ID
      --AND xcfd.expenditure_item_date <= to_date('2018-03-01', 'yyyy-mm-dd') --P_END_DATE
   AND decode(cost_type,
              'FAC_FG', --
              'SHE_FAC_ORG',
              'FAC_TO_HO_FG',
              'SHE_HQ_ORG',
              'FINAL_FG',
              decode(xcfd.org_id, 141, 'HET_HQ_ORG', 'SHE_HQ_ORG'), --Modify by jingjing 20180226 v5.00
              NULL) IN (SELECT ood.organization_name
                          FROM org_organization_definitions ood
                         WHERE ood.operating_unit = 84 /*P_ORG_ID*/
                        );
