select cg_id as caregiverId, RIGHT(cg_code,5) as caregiverCode,
       cg_first_name as firstName, cg_middle_name as middleName, cg_last_name as lastName,
       cg_gender as gender, cg_cell_no as phoneNumber
	   from tbl_caregiver