update oc_product set minimum = 0;
alter table oc_product modify column minimum int(10) not null default 0;
update oc_product set subtract = 0;