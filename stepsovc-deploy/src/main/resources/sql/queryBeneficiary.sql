select
ben.ben_id as beneficiaryId , ben.ben_code as beneficiaryCode,
ben.ben_first_name as beneficiaryName , ben.ben_last_name as beneficiaryLastName,
convert(varchar(10), ben.ben_dob, 120)as beneficiaryDob,
'' as receivingOrganization ,
CASE cg_gender
           WHEN 0 THEN 'Female'
           WHEN 1 THEN 'Male'
           WHEN -1 THEN 'Not Specified' END AS beneficiarySex,
ben.cg_id as careGiverId,
care.cg_code as careGiverCode,
care.cg_first_name as careGiverName
from tbl_beneficiary ben
join tbl_caregiver care on  ben.cg_id=care.cg_id where care.dst_id=32