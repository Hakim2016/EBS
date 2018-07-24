
SELECT flv.meaning level_meaning,
       profile_value.level_id,
       profile_value.level_value,
       profile_value.level_value2,
       profile_value.level_value_desc,
       profile_value.application_id,
       profile_value.profile_option_id,
       fpo.application_id,
       fpo.user_profile_option_name,
       fpo.profile_option_name,
       profile_value.profile_option_value,
       profile_value.last_update_date
  FROM ( -- Site Level
        SELECT fpov.level_id,
                fpov.level_value,
                fpov.level_value2,
                NULL level_value_desc,
                fpov.application_id,
                fpov.profile_option_id,
                fpov.profile_option_value,
                fpov.last_update_date
          FROM fnd_profile_option_values fpov
         WHERE 1 = 1
           AND fpov.level_id = 10001
        UNION ALL
        -- Application Level
        SELECT fpov.level_id,
                fpov.level_value,
                fpov.level_value2,
                fa.application_name level_value_desc,
                fpov.application_id,
                fpov.profile_option_id,
                fpov.profile_option_value,
                fpov.last_update_date
          FROM fnd_profile_option_values fpov,
                fnd_application_vl        fa
         WHERE 1 = 1
           AND fpov.level_id = 10002
           AND fpov.level_value = fa.application_id
        UNION ALL
        -- Responsibility Level
        SELECT fpov.level_id,
                fpov.level_value,
                fpov.level_value2,
                fresp.responsibility_name level_value_desc,
                fpov.application_id,
                fpov.profile_option_id,
                fpov.profile_option_value,
                fpov.last_update_date
          FROM fnd_profile_option_values fpov,
                fnd_responsibility_vl     fresp
         WHERE 1 = 1
           AND fpov.level_id = 10003
           AND fpov.level_value = fresp.responsibility_id
        UNION ALL
        -- User Level
        SELECT fpov.level_id,
                fpov.level_value,
                fpov.level_value2,
                fu.user_name level_value_desc,
                fpov.application_id,
                fpov.profile_option_id,
                fpov.profile_option_value,
                fpov.last_update_date
          FROM fnd_profile_option_values fpov,
                fnd_user                  fu
         WHERE 1 = 1
           AND fpov.level_id = 10004
           AND fpov.level_value = fu.user_id
        UNION ALL
        -- Server Level
        SELECT fpov.level_id,
                fpov.level_value,
                fpov.level_value2,
                fn.node_name level_value_desc,
                fpov.application_id,
                fpov.profile_option_id,
                fpov.profile_option_value,
                fpov.last_update_date
          FROM fnd_profile_option_values fpov,
                fnd_nodes                 fn
         WHERE 1 = 1
           AND fpov.level_id = 10005
           AND fpov.level_value = fn.node_id
        UNION ALL
        -- Organization Level
        SELECT fpov.level_id,
                fpov.level_value,
                fpov.level_value2,
                hou.name level_value_desc,
                fpov.application_id,
                fpov.profile_option_id,
                fpov.profile_option_value,
                fpov.last_update_date
          FROM fnd_profile_option_values fpov,
                hr_organization_units     hou
         WHERE 1 = 1
           AND fpov.level_id = 10006
           AND fpov.level_value = hou.organization_id
        UNION ALL
        -- Server+Responsibility Level
         (SELECT fpov.level_id,
                 fpov.level_value,
                 fpov.level_value2,
                 fn.node_name level_value_desc,
                 fpov.application_id,
                 fpov.profile_option_id,
                 fpov.profile_option_value,
                 fpov.last_update_date
            FROM fnd_profile_option_values fpov,
                 fnd_nodes                 fn
           WHERE fpov.level_id = 10007
             AND fpov.level_value <> -1
             AND fpov.level_value2 = fn.node_id
          UNION
          SELECT fpov.level_id,
                 fpov.level_value,
                 fpov.level_value2,
                 fn.node_name || ' - ' || fresp.responsibility_name level_value_desc,
                 fpov.application_id,
                 fpov.profile_option_id,
                 fpov.profile_option_value,
                 fpov.last_update_date
            FROM fnd_profile_option_values fpov,
                 fnd_nodes                 fn,
                 fnd_responsibility_tl     fresp
           WHERE fpov.level_id = 10007
             AND fpov.level_value = fresp.responsibility_id
             AND fpov.level_value <> -1
             AND fpov.level_value2 <> -1
             AND fpov.level_value2 = fn.node_id)
        
        ) profile_value,
       fnd_lookup_values_vl flv,
       fnd_profile_options_vl fpo
 WHERE 1 = 1
   AND flv.lookup_type(+) = 'ITA_PROFILE_LEVEL_ID'
   AND flv.lookup_code(+) = profile_value.level_id
   AND profile_value.profile_option_id = fpo.profile_option_id
   AND profile_value.application_id = fpo.application_id
      --AND profile_value.level_value = 50676
      -- AND profile_value.level_id = 10001--10003
   AND fpo.user_profile_option_name LIKE 'INV%RPC' --'MO%'
;
/*
10001   Site Level
10002   Application Level
10003   Responsibility Level
10004   User Level
10005   Server Level
10006   Organization Level
*/
--AND upper(profile_value.level_value_desc) = upper('HAND_GSL')
-- AND UPPER(fpo.user_profile_option_name) LIKE UPPER('%persona%')

SELECT FPO.PROFILE_OPTION_NAME, FPO.USER_PROFILE_OPTION_NAME, FPO.*
  FROM FND_PROFILE_OPTIONS_VL FPO
 WHERE 1 = 1
      --AND fpo.user_profile_option_name LIKE 'IEX: SMTP Host%'
   AND FPO.USER_PROFILE_OPTION_NAME IN ('IEX: SMTP Host', 'IEX: SMTP From');
--IEX: SMTP From            IEX_SMTP_FROM
--IEX: SMTP Host            IEX_SMTP_HOST
--        

DECLARE
  STAT BOOLEAN;
BEGIN
  DBMS_OUTPUT.DISABLE;
  DBMS_OUTPUT.ENABLE(100000);

  /*   IF ( not fnd_profile.save( x_name => 'APPS_SERVLET_AGENT',
                       x_value => '',
                       x_level_name => 'USER',--SITE, USER
                       x_level_value => x_user_id ) ) THEN
       raise_application_error(-20005, ' Failed to remove servlet profile option value for user with id:'
               ||x_user_id , true);
  END IF;*/

  STAT := FND_PROFILE.SAVE(X_NAME       => 'IEX_SMTP_FROM', --'ORG_ID', 
                           X_VALUE      => 'erp.na@cn.chervongroup.com', --286, 
                           X_LEVEL_NAME => 'SITE');
  IF STAT THEN
    DBMS_OUTPUT.PUT_LINE('Stat1 = TRUE - profile updated');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Stat1 = FALSE - profile NOT updated');
  END IF;

  STAT := FND_PROFILE.SAVE(X_NAME       => 'IEX_SMTP_HOST', --'ORG_ID', 
                           X_VALUE      => '192.168.11.10', --286, 
                           X_LEVEL_NAME => 'SITE');
  IF STAT THEN
    DBMS_OUTPUT.PUT_LINE('Stat2 = TRUE - profile updated');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Stat2 = FALSE - profile NOT updated');
  END IF;
  COMMIT;
END;

SELECT *
  FROM FND_NEW_MESSAGES FNM
 WHERE 1 = 1
   AND FNM.MESSAGE_NAME IN ('IBY_FD_SRA_EMAIL_FROM');

UPDATE FND_NEW_MESSAGES FNM
   SET FNM.MESSAGE_TEXT = 'erp.na@cn.chervongroup.com'
 WHERE 1 = 1
   AND FNM.MESSAGE_NAME IN ('IBY_FD_SRA_EMAIL_FROM');
COMMIT;

SELECT *
  FROM FND_NEW_MESSAGES FNM
 WHERE 1 = 1
   AND FNM.MESSAGE_NAME IN ('IBY_FD_SRA_EMAIL_FROM');
