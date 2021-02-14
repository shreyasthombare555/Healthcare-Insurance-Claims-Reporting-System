Use health_insurance_claims_database;
create view top_20_claim_approved_customers as (select m.member_first_name, m.member_last_name, s.claim_status, 
	   p.provider_first_name, p.provider_last_name, p.network,
       p.practice_name, cp.billed_amount, cp.approved_amount, cp.net_payment
	from 
		((((member m inner join claim c on m.claim_id = c.claim_id) 
				inner join status s on s.status_id = c.status_id)
                inner join provider p on p.claim_id = m.claim_id)
				inner join claim_payment cp on cp.claim_id = c.claim_id)
	where cp.approved_amount > 2200
	order by cp.approved_amount desc limit 20);
    
    select * from top_20_claim_approved_customers;