SELECT *
  FROM oe_order_headers_all ooh
 WHERE 1 = 1
   AND ooh.org_id = 101
   AND ooh.order_number IN ('53020400', '53020422');

SELECT ool.ordered_item,
       ool.last_update_date,
       (SELECT fu.user_name
       FROM fnd_user fu
       WHERE 1=1
       AND fu.user_id = ool.last_updated_by
       ) usr,
       ool.attribute1,
       ool.attribute4,
       ool.*
  FROM oe_order_headers_all ooh,
       oe_order_lines_all   ool
 WHERE 1 = 1
   AND ooh.org_id = 101
   AND ooh.header_id = ool.header_id
   AND ooh.order_number = '53020400'
   AND ool.ordered_item IN ('JED0210-VN','JED0211-VN','JED0212-VN','JED0219-VN','JED0220-VN','JED0225-VN');
