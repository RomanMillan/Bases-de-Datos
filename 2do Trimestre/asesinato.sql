select * from crime_scene_report 
where city = 'SQL City' 
and type = 'murder';

select * from person where address_street_name = 'Northwestern Dr'
ORder BY address_number desc;

select * from interview where person_id = 14887;

select * from drivers_license where plate_number like '%H42W%';

select * from get_fit_now_member where id like '48Z%';
