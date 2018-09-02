create table category_prodproperty (
   category_prodproperty_id int(10) unsigned not null primary key auto_increment,
   category_id int(10) unsigned not null,
   foreign key (category_id) references oc_category (category_id)
        on delete cascade on update cascade,
   `name` varchar(1000) not null,
   unit varchar(10) not null default '',
   `default` varchar(1000) not null default '',
   `type_id` tinyint(2) unsigned not null default 1,  
    `showInProdPreview` tinyint(1) default 0,
    `showInSummary` tinyint(1) default 0,
    showInProdTab tinyint(1) not null default 0
) engine = MyIsam, charset=utf8;


create table product_prodproperty (
    product_prodproperty_id int(10) unsigned not null primary key auto_increment,
    category_prodproperty_id int(10) unsigned not null,
    foreign key (category_prodproperty_id) references category_prodproperty (category_prodproperty_id)
        on delete cascade on update cascade,

    product_id int(10) unsigned not null,
    
    `val` varchar(1000) default null, 
    sortOrder tinyint(3) default null,
    `hide` tinyint(1) not null default 0
) engine = MyIsam, charset=utf8;

drop table product_prodproperty;


create table category_prodproperty_type (
    category_prodproperty_type_id int(10) unsigned not null primary key auto_increment,
    `name` varchar(50) not null
) engine=MyIsam, charset=utf8;

insert into category_prodproperty_type (`name`) values (
    'text'),(
    'input'
);

alter table oc_category add column isfinal tinyint(1) unsigned not null default 0;
alter table oc_product add column showInSummary tinyint(1) unsigned not null default 0;

alter table category_prodproperty add column sortOrder tinyInt(3) not null default 0;
alter table product_prodproperty add column sortOrder tinyInt(3) not null default 0;

-- fill data
-- 63 category = Эластоизол премиум
insert into category_prodproperty (sortOrder, category_id, type_id, showInSummary, showInProdPreview, showInProdTab, `name`, unit, `default`) values
(0, 63, 2, 1, 0, 0, 'Масса 1 м2, не менее', 'кг', '5,0'),
(1, 63, 2, 1, 0, 0, 'Масса вяжущего с наплавляемой стороны, не менее', 'кг/м2', '2,0'),
(2, 63, 2, 1, 0, 0, 'Гибкость на брусе R=10 мм, на лицевой поверхности образца не должно быть трещин, при температуре не выше', 'оС', '-25'),
(3, 63, 2, 1, 0, 0, 'Температура хрупкости вяжущего, не выше', 'оС', '-35'),
(4, 63, 2, 1, 0, 0, 'Теплостойкость в течение 2 часов, не должно быть сползания посыпки, вздутий и других дефектов, при температуре', 'оС', '+100'),
(5, 63, 2, 1, 0, 0, 'Разрывная сила при растяжении в продольном/поперечном направлении, не менее', 'Н (кгс)', '800 (82) / 700 (71)'),
(6, 63, 2, 1, 0, 0, 'Потеря посыпки, не более', 'г/образец', '1,0'),
(7, 63, 2, 1, 0, 0, 'Водопоглощение в течение 24 часов, по массе, не более', '%', '1,0'),
(8, 63, 2, 1, 0, 0, 'Размеры рулона (длина х ширина)', 'м', '10х1'),
(0, 63, 2, 0, 1, 0, 'Основа', '', 'Стеклоткань'),
(1, 63, 2, 0, 1, 0, 'Верхнее покрытие', '', 'Сланец серый');

