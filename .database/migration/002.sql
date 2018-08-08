-- GOOD
create table produnit_template (
    produnit_template_id int(10) not null auto_increment primary key,
    `name` varchar(100) not null,
    description varchar(1000) not null default ''
) engine=MyIsam, collate=utf8_general_ci;

drop table produnit_unit;
create table produnit_unit (
    unit_id int(10) not null auto_increment primary key,
    produnit_template_id int(10) not null,
    `name` varchar(100) not null,
    `name_price` varchar (50) not null default '',
    `name_plural` varchar (50) not null default '',
    `name_package_dimension` varchar (50) not null default '',
    `name_in_package` varchar (50) not null default '',
    calcKoef double(16,9) unsigned  default null comment "coef for calculations with regard to base unit",
    calcRel int(10) default null comment "calculate to this unit", 
    isPriceBase tinyint(1) not null default 0 comment "unit for pricing, using products' price", 
    isSaleBase tinyint(1) not null default 0 comment "unit for selling, influences min sale quantity",
    isPackageBase tinyint(1) not null default 0 comment "unit for calculating loading, using weight", 
    switchSortOrder tinyint(2) not null default 0 comment "is show in price switch. 0=not shown",
    loadingSortOrder tinyint(2) not null default 0 comment "is show in loading calculator. 0=not shown",
    `weight` float(10,3) default null comment "kg",
    `package_width` varchar(50) not null default '',
    `package_length` varchar(50) not null default '',
    `package_height` varchar(50) not null default '' 
) engine=MyIsam, collate=utf8_general_ci;


create table produnit_packagestr (
    packagestr_id int(10) not null auto_increment primary key,
    produnit_template_id int(10) not null,
    description varchar(250) not null,
    `value` varchar(250) not null,
    sortOrder tinyint(3) not null default 0
) engine=MyIsam, collate=utf8_general_ci;
