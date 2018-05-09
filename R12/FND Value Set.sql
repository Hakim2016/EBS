    SELECT ffvv.flex_value,
           ffvv.flex_value_meaning
      
      FROM fnd_flex_value_sets ffvs,
           fnd_flex_values_vl  ffvv
     WHERE ffvs.flex_value_set_name = 'XXHEA_PAYMENT METHOD'
       AND ffvv.flex_value_set_id = ffvs.flex_value_set_id
       --AND ffvv.flex_value_meaning = p_payment_method;
;
