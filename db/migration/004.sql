create table category_prodtab (
   category_prodtab_id int(10) unsigned not null primary key auto_increment,
   category_id int(10) unsigned not null,
   foreign key (category_id) references oc_category (category_id)
        on delete cascade on update cascade,
   `name` varchar(1000) not null,
   `default` varchar(1000) not null default '',
   sortOrder tinyint(3) default null
) engine = MyIsam, charset=utf8;


create table product_prodtab (
    product_prodtab_id int(10) unsigned not null primary key auto_increment,
    category_prodtab_id int(10) unsigned not null,
    foreign key (category_prodtab_id) references category_prodtab (category_prodtab_id)
        on delete cascade on update cascade,

    product_id int(10) unsigned not null,
    
    `val` varchar(1000) default null, 
    sortOrder tinyint(3) default null,
    `hide` tinyint(1) not null default 0
) engine = MyIsam, charset=utf8;
