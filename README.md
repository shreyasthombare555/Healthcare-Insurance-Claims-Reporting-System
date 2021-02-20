# Healthcare Insurance Claims Reporting System

**Business Value:** Developed a Relational Database Architecture for storing Healthcare insurances claims data, designed insightful optimized queries and interactive visualizations with a goal of formulating key ad-hoc dynamic reports and dashboards using MySQL Workbench and Tableau. 

# Project Overview

**Data Set Description:**

Researched Health Insurance websites and generated custom dataset which involved information pertaining to the 
i) Insurance providers

ii) Insurance Claims

iii) Insurance Coverage 

iv) Insurance Claim Status

v) Claim Payments 

vi) Member Demographics.

**Action Plan:**

i) Preprocessed dataset tables in order to make it standardized and consistent. 

ii) Designed a Logical Entity-Relationship diagram, defined constraints and relationships using join operations while populating the data tables.

iii) Converted database tables into 3NF form with a goal of reducing redundancy in the database. 

iv) Formulated optimized queries using join operations and fine-tuned them by creating Views, Stored Procedures and Indexing.

v) Explored dataset and summarized key findings into an interactive dashboard designed using Tableau which eased the job of story telling and decision making. 

**Query Snapshots**

**1) Reporting top 20 members along with provider details, billed amount and approved amount associated and having approved_amount greater than $2200 - Virtual Table/Views**

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

**2) Reporting distinct members (member demographic information) who have their claims in progress - Stored Procedure**
    
use health_insurance_claims_database;

DELIMITER //

CREATE PROCEDURE get_member_claim_status_data(
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

CALL get_member_claim_status_data('paid');

**3) Finding member subscribed to a coverage plan having address ID between 2000 to 5000 - Indexing**

use health_insurance_claims_database;

select distinct m.member_first_name, m.member_last_name, cp.coverage_name, m.address_id 
from (coverage cp inner join member m on m.member_id = cp.member_id)
where m.address_id between 2000 and 5000;

create index member_index on member(address_id);
 
select distinct m.member_first_name, m.member_last_name, cp.coverage_name, m.address_id 
from (coverage cp inner join member m on m.member_id = cp.member_id)
where m.address_id between 2000 and 5000;

drop index member_index on member;

# Technologies Used:

i) Data Analysis technologies: MS Excel, Python.

ii) Database Managemen Tools: MySQL, MySQL Workbench.

iii) Data Visualization tool: Tableau. 

