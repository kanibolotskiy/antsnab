alter table produnit_unit add column force_step_by_one tinyint(1) not null default 0;

update produnit_unit set force_step_by_one=1 where name in ('паллета','Упаковка','упаковка','коробка','пачка');