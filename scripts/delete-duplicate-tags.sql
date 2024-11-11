delete from instance_tags where 
	id not in (
		select a.id from (
			select
				ROW_NUMBER() OVER (PARTITION BY `instance-id`, tag_name ORDER BY id DESC) rn,
				id,
				`instance-id`, 
				tag_name,
				tag_value
			from instance_tags
		  ) a
	  where a.rn = 1
   )

    