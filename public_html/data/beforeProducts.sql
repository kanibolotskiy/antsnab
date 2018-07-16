alter table oc_product_image add column alt varchar(2000) not null default '';

create table oc_product_analogs (product_id int(11) not null, related_id int(11) not null, primary key (product_id, related_id)) engine MyIsam charset utf8;

create table oc_product_recomends (product_id int(11) not null, related_id int(11) not null, primary key (product_id, related_id)) engine MyIsam charset utf8;

alter table oc_product_description modify column meta_keyword varchar(2000) default '';
alter table oc_product_description modify column meta_title varchar(2000) default '';
alter table oc_product_description modify column meta_h1 varchar(2000) default '';
alter table oc_product_description modify column meta_description varchar(2000) default '';
