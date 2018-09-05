select * from survey
limit 10;
 
select question,
 	count(distinct user_id)
from survey
group by question;

select * from quiz
limit 5;

select * from home_try_on
limit 5;

select * from purchase
limit 5;

select distinct q.user_id,
q.user_id,
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs,
p.user_id is not null as 'is_purchase'
from quiz as 'q'
left join home_try_on as 'h'
on h.user_id = q.user_id
left join purchase as 'p'
on p.user_id = q.user_id
limit 10;

with funnels as (
	select distinct q.user_id,
		q.user_id,
		h.user_id is not null as 'is_home_try_on',
		h.number_of_pairs,
		p.user_id is not null as 'is_purchase'
	from quiz as 'q'
	left join home_try_on as 'h'
		on h.user_id = q.user_id
	left join purchase as 'p'
		on p.user_id = q.user_id)
select count(user_id) as 'num_users',
sum(is_home_try_on) as 'num_try',
sum(is_purchase) as 'num_purchase',
1.0 * sum(is_home_try_on) / count(user_id) as 'browse_to_try',
1.0 * sum(is_purchase) / sum(is_home_try_on) as 'try_to_purchase'
from funnels;