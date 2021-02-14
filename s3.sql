use health_insurance_claims_database;

DELIMITER //
CREATE PROCEDURE get_member_claim_status_p(
	IN claim_status_in VARCHAR(50)
)
BEGIN
	select m.member_first_name, m.member_last_name, m.member_dob, m.gender, m.claim_id,
	   s.claim_status, s.type
	from 
		((member m inner join claim c on m.claim_id = c.claim_id) 
				inner join status s on s.status_id = c.status_id)
	where s.claim_status = claim_status_in
	order by m.member_first_name;
END //

DELIMITER ; 

CALL get_member_claim_status_p('paid');

