SELECT cg_id AS caregiverId, cg_code AS caregiverCode, RIGHT(cg_code,5) AS userName,
       cg_first_name AS firstName, cg_middle_name AS middleName, cg_last_name AS lastName,
       CASE cg_gender
            WHEN 0 THEN 'Female'
            WHEN 1 THEN 'Male'
            WHEN -1 THEN 'Not Specified' END AS gender
	   FROM tbl_caregiver  where dst_id=32