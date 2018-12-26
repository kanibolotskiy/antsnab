alter table category_prodproperty change column unit unit varchar(100) not null default '';
alter table category_prodtab change column `default` `default` text not null default '';
alter table product_prodtab change column `val` `val` text not null default '';