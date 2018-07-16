alter table oc_category_description add column description_bottom text; 
alter table oc_category_description add column meta_keyword2 varchar(2000) default '';
alter table oc_category_description modify column meta_keyword varchar(2000) default '';
alter table oc_category_description modify column meta_title varchar(2000) default '';
alter table oc_category_description modify column meta_h1 varchar(2000) default '';
alter table oc_category_description modify column meta_description varchar(2000) default '';
alter table oc_category add column srcId int(11) not null default 0;
