drop table _units_debug;
create table _units_debug (
    id int(11) not null auto_increment primary key,
    model int(11) not null,
    document_parent_id varchar (100) not null default '',
    price2_action varchar(100) not null default '', 
    `price2_action:text` varchar(100) not null default '',
    ed_izm varchar(100) not null default '', 
    ed_izm2 varchar(100) not null default '',
    norm_ed_izm_1 varchar(100) not null default '',
    norm_ed_izm_2 varchar(100) not null default '',
    opt_size varchar(100) not null default '',
    price varchar(100) not null default '',
    price_2 varchar(100) not null default '',
    price_opt varchar(100) not null default '',
    price_opt_2 varchar(100) not null default '',
    pack_price varchar(100) not null default '',
    `pack_price:text` varchar(100) not null default '',
    upakovka varchar(100) not null default '',
    pack varchar(100) not null default '',
    pack_type varchar(100) not null default '',
    `pack_type:text` varchar(100) not null default '',
    in_roll varchar(100) not null default '',
    na_pallete varchar(100) not null default '',
    v_korobke varchar(100) not null default '',
    listov varchar(100) not null default '',
    weight varchar(100) not null default '',
    roll_weight varchar(100) not null default '',
    roll_size varchar(100) not null default '',
    f_lista varchar(100) not null default '',
    t_lista varchar(100) not null default '',
    norm_as_box varchar(100) not null default '',
    norm_division varchar(100) not null default '',
    rashod varchar(100) not null default ''
) engine=MyIsam, collate utf8_general_ci;
alter table _units_debug add column depth varchar(100) not null default '';
alter table _units_debug add column document_type varchar(100) not null default '';

select oc_category_description.name, oc_product_description.name, oc_product.model, document_type, document_parent_id, ed_izm, ed_izm2, norm_ed_izm_1, 
norm_ed_izm_2, upakovka, depth, norm_as_box, price2_action, `price2_action:text`, 
norm_division, f_lista, t_lista, _units_debug.weight, roll_weight, roll_size,
in_roll,na_pallete,v_korobke,listov,
ed_izm, _units_debug.price, pack, pack_type, `pack_type:text`, pack_price,`pack_price:text`,  _units_debug.price_2 from _units_debug left join oc_product on oc_product.model = _units_debug.model left join oc_product_description on oc_product_description.product_id = oc_product.product_id
left join oc_product_to_category on oc_product_to_category.product_id = oc_product.product_id left join oc_category on
oc_category.category_id = oc_product_to_category.category_id left join oc_category_description on oc_category_description.category_id = oc_category.category_id where document_type=2558;

update oc_product set produnit_template_id = 2, price=1000, price_wholesale=100 where model = 2361 ;
/*group by oc_category_description.name;*/

select pack_type, `pack_type:text` from _units_debug  where document_type = 2547 group by pack_type; 



