SELECT pv.vendor_id vendor_id,  
       pvsa.vendor_site_id vendor_site_id,  
       pv.vendor_name vendor_name,  
       pvsa.vendor_site_code vendor_site_code,  
       pvsa.org_id org_id,  
       pv.segment1 vendor_code,  
       pvc.area_code || pvc.phone vendor_phone,  
       pvc.fax_area_code || pvc.fax vendor_fax,  
       pvsa.terms_id terms_id,  
       pvsa.vat_code vat_code,  
       pvc.last_name || pvc.middle_name || pvc.first_name contact_man  
  FROM po_vendors pv, po_vendor_sites_all pvsa, po_vendor_contacts pvc  
 WHERE pv.vendor_id = pvsa.vendor_id  
   AND pvsa.vendor_site_id = pvc.vendor_site_id  
   AND pv.vendor_id = 593
 ORDER BY org_id DESC;  
 
 SELECT * FROM po_vendors pv WHERE pv.vendor_id = 593
