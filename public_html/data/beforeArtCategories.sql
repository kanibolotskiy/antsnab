alter table oc_newsblog_category_description modify column meta_keyword varchar(2000) default '';
alter table oc_newsblog_category_description modify column meta_title varchar(2000) default '';
alter table oc_newsblog_category_description modify column meta_h1 varchar(2000) default '';
alter table oc_newsblog_category_description modify column meta_description varchar(2000) default '';
alter table oc_newsblog_category add column srcId int(11) not null default 0;
alter table oc_newsblog_category_description modify column `name` varchar(2000) default '';

-- удалить лишние категории


