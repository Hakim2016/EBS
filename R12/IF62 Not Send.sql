--�����쳣������
select * from xxgl_acct_int_error a where a.creation_date>sysdate-20;
--�����ĵ��ݲ�ѯ Ӧ�շ�Ʊ
SELECT xhi.*
  FROM apps.ra_customer_trx_all     aia,
       xla.xla_transaction_entities xta,
       xla_ae_headers               xah,
       xxgl_accounting_hfg_int      xhi
 WHERE aia.Trx_Number = '65020650'
   AND xta.source_id_int_1 = aia.customer_trx_id
   AND xta.application_id = 222
   AND xta.entity_code = 'TRANSACTIONS'
   AND xah.entity_id = xta.entity_id
   AND xah.ae_header_id = xhi.source_header_id;

--�����ĵ��ݲ�ѯ Ӧ����Ʊ
SELECT xhi.*
  FROM apps.ap_invoices_all         aia,
       xla.xla_transaction_entities xta,
       xla_ae_headers               xah,
       xxgl_accounting_hfg_int      xhi
 WHERE aia.invoice_num = '65020650'
   AND xta.source_id_int_1 = aia.invoice_id
   AND xta.application_id = 200
   AND xta.entity_code = 'AP_INVOICES'
   AND xah.entity_id = xta.entity_id
   AND xah.ae_header_id = xhi.source_header_id;