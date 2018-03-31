SELECT msi.segment1,
       mmt.*
  FROM mtl_material_transactions mmt,
       mtl_system_items_b        msi
 WHERE 1 = 1
   AND mmt.inventory_item_id = msi.inventory_item_id
   AND mmt.organization_id = msi.organization_id
   AND mmt.transaction_id = 8915869
