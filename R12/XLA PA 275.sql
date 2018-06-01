SELECT *
  FROM fnd_application fa
 WHERE 1 = 1
   AND fa.application_short_name = 'PA';

SELECT xah.ledger_id,
       xah.description,
       xal.description,
       xah.*,
       xal.*,
       xte.*
  FROM xla.xla_transaction_entities xte,
       xla_ae_headers               xah,
       xla_ae_lines                 xal
 WHERE 1 = 1
   AND xah.ae_header_id = xal.ae_header_id
   AND xah.entity_id = xte.entity_id
   AND xte.application_id = 275
   AND xte.source_id_int_1 = 15486489--15429305--15312121--15429305
;

--AP 275
SELECT xe.event_id,
       xte.entity_id,
       xe.event_date,
       xe.creation_date,
       xah.je_category_name,
       xah.gl_transfer_status_code posted,
       xah.gl_transfer_date,
       xal.ae_header_id,
       xal.ae_line_num,
       xal.accounting_class_code   acc_clss_cd,
       xal.accounted_dr            acc_dr,
       xal.accounted_cr            acc_cr,
       xal.accounting_date,
       xte.entity_id,
       xte.entity_code,
       xte.creation_date,
       xte.transaction_number,
       xte.ledger_id,
       xah.event_id,
       xah.accounting_date,
       xah.gl_transfer_date,
       xah.description,
       xah.completed_date,
       xah.period_name,
       xte.*
  FROM xla.xla_transaction_entities xte,
       xla_events                   xe,
       xla_ae_headers               xah,
       xla_ae_lines                 xal
 WHERE 1 = 1
   AND xte.application_id = 275
   AND xte.ledger_id = 2021
   AND xte.entity_id = xe.entity_id
   AND xte.application_id = xe.application_id
   AND xe.event_id = xah.event_id
   AND xte.entity_id = xah.entity_id
   AND xah.application_id = xte.application_id
   AND xah.ae_header_id = xal.ae_header_id
   AND xte.source_id_int_1 = 15429305--15486489--15312121 --pei.expenditure_item_id
      --AND xah.je_category_name
      --AND xah.description LIKE --'53020155.JAC0084-IN.5031616'
      --'53020400.JED0210-VN%'
      --'53020165%'
      --'53020261%'
      --'11001299%'
      --'53020261%'
      --'10101647%'
   AND (nvl(xal.accounted_dr, 0) + nvl(xal.accounted_cr, 0)) <> 0;

--AR 222
SELECT xe.event_id,
       xte.entity_id,
       xe.event_date,
       xe.creation_date,
       xah.je_category_name,
       xah.description,
       xah.gl_transfer_status_code posted,
       xah.gl_transfer_date,
       xal.ae_header_id,
       xal.ae_line_num,
       xal.accounting_class_code   acc_clss_cd,
       xal.accounted_dr            acc_dr,
       xal.accounted_cr            acc_cr,
       xal.accounting_date,
       xte.entity_id,
       xte.entity_code,
       xte.creation_date,
       xte.transaction_number,
       xte.ledger_id,
       xah.event_id,
       xah.accounting_date,
       xah.gl_transfer_date,
       xah.description,
       xah.completed_date,
       xah.period_name,
       xte.*
  FROM xla.xla_transaction_entities xte,
       xla_events                   xe,
       xla_ae_headers               xah,
       xla_ae_lines                 xal
 WHERE 1 = 1
   AND xte.application_id = 222 --275
   AND xte.ledger_id = 2021 --HEA
   AND xte.entity_id = xe.entity_id
   AND xte.application_id = xe.application_id
   AND xe.event_id = xah.event_id
   AND xte.entity_id = xah.entity_id
   AND xah.application_id = xte.application_id
   AND xah.ae_header_id = xal.ae_header_id
      --AND xah.accounting_date = to_date('2015-01-06','yyyy-mm-dd')
      --AND xah.je_category_name = 'Sales Invoices'
      --AND xe.event_id = 6107822
      --AND xah.je_category_name
      --AND xah.description LIKE --'53020155.JAC0084-IN.5031616'
      --'53020400.JED0210-VN%'
      --'53020165%'
      --'53020261%'
      --'11001299%'
      --'53020261%'
      --'10101647%'
   AND (nvl(xal.accounted_dr, 0) + nvl(xal.accounted_cr, 0)) <> 0;

--------
SELECT ct.trx_number,
       ctl.description,
       fnd_flex_ext,
       gcc.chart_of_accounts_id,
       gcc.code_combination_id) account_number, gd.gl_date, to_number(decode(gd.account_class, 'REC', decode(sign(nvl(gd.amount, 0)), -1, NULL, nvl(gd.amount, 0)), decode(sign(nvl(gd.amount, 0)), -1, -nvl(gd.amount, 0), NULL))) entered_dr, to_number(decode(gd.account_class, 'REC', decode(sign(nvl(gd.amount, 0)), -1, -nvl(gd.amount, 0), NULL), decode(sign(nvl(gd.amount, 0)), -1, NULL, nvl(gd.amount, 0)))) entered_cr
  FROM ra_customer_trx_all          ct,
       ra_customer_trx_lines_all    ctl,
       ra_cust_trx_line_gl_dist_all gd,
       gl_code_combinations         gcc
 WHERE gd.customer_trx_id = ct.customer_trx_id
   AND gd.customer_trx_line_id = ctl.customer_trx_line_id(+)
   AND gcc.code_combination_id = gd.code_combination_id
   AND ct.customer_trx_id = &customer_trx_id;

-----
SELECT ct.trx_number,
       l.accounting_class_code,
       l.entered_dr,
       l.entered_cr,
       fnd_flex_ext.get_segs('SQLGL', 'GL#', 50328, l.code_combination_id) account_number,
       xla_oa_functions_pkg.get_ccid_description(50328, l.code_combination_id) account_description
  FROM xla_ae_headers               h,
       xla_ae_lines                 l,
       xla_events                   e,
       xla.xla_transaction_entities te,
       ra_customer_trx_all          ct
 WHERE h.application_id = l.application_id
   AND h.ae_header_id = l.ae_header_id
   AND h.application_id = e.application_id
   AND h.event_id = e.event_id
   AND h.application_id = te.application_id
   AND h.entity_id = te.entity_id
   AND te.application_id = 222
   AND te.entity_code = 'TRANSACTIONS'
   AND nvl(te.source_id_int_1, (-99)) = ct.customer_trx_id
   AND ct.customer_trx_id = 3139;
