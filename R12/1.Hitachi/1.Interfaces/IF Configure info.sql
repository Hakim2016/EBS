SELECT xic.interface_code,
       xic.user_concurrent_program_name,
       decode(xic.type, 'I', 'Inbound', 'O', 'Outbound') type,
       xic.object_owner,
       xic.remote_system_code,
       XIC.*
  FROM apps.xxfnd_interface_config_v xic
 WHERE 1 = 1
  AND xic.remote_system_code = 'R3'
  --AND xic.interface_code = 'IF62'
  --AND xic.remote_system_code = 'HFG'
/*  AND xic.interface_code IN 
  
  (
  'IF61','IF62','IF63','IF64', 'IF67','IF68'
  ,
  'IF77','IF78','IF79'
  )*/
  --AND xic.type = 'O'
  --AND xic.USER_CONCURRENT_PROGRAM_NAME LIKE '%ixed%sset%'
  --AND xic.enabled_flag = 'N'
 ORDER BY 1;
