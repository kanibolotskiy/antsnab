-- add produnits to product tables
alter table oc_product add column price_wholesale decimal(15,4) not null default 0.0000;
alter table oc_product add column wholesale_threshold float(10,4) default null;
alter table oc_product add column produnit_template_id int(11) default null;
alter table oc_product_description add column description_mini text ; 
 
