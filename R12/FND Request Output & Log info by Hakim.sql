--模拟请求输出
SELECT FND_WEBFILE.GET_URL(3,                              --输出类型
                           14490902,                  --请求ID
                           'APPLSYSPUB/PUB',  
                           'FCWW',
                           10)
  FROM DUAL;
/*
直接改请求ID就行了
第一个参数4表示request的output,（可根据需要决定）
 Define file types for get_url
 process_log constant number := 1;
 icm_log constant number := 2;
 request_log constant number := 3;        --log日志输出
 request_out constant number := 4;        --报表输出
 request_mgr constant number := 5;
 frd_log constant number := 6;
 generic_log constant number := 7;
 generic_trc constant number := 8;
 generic_ora constant number := 9;
 generic_cfg constant number := 10;
 context_file constant number := 11;
 generic_text constant number := 12;
 generic_binary constant number := 13;
 request_xml_output constant number :=14;    --XML输出
 */
