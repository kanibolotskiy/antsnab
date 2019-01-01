    return -1;
use antsnab;


SELECT r.review_id, pd.name, r.author, r.email, r.company, r.rating, r.status, r.date_added, r.about, r.moderator, r.answer FROM oc_review r LEFT JOIN oc_product_description pd ON (r.product_id = pd.product_id) WHERE (pd.language_id = '1' or pd.language_id is NULL) AND r.author LIKE 'Виктор%' ORDER BY r.date_added DESC LIMIT 0,6;


use antsnaborigin;

select document_id, document_content from documents where document_content like '%Можно использовать мастику мбу в дачном доме%';







show columns from oc_product;
select * from oc_product;
select product_id from oc_product where model = 150;


use antsnaborigin;

select document_id, document_type, document_create_time, document_link3, document_content from documents where document_type in (296,785) 
    and document_link3 = 0 order by document_create_time, document_id;


select * from oc_newsblog_category;

update oc_newsblog_category set category_id = 2 where category_id=39;

show columns from oc_newsblog_article_description;
show columns from oc_newsblog_category_description;

delete from oc_newsblog_category where category_id<>1;
delete from oc_newsblog_category_description where category_id<>1;

select distinct(bottom_text) from oc_category_description;
show columns from oc_newsblog_category;
select * from documents where 
document_type = 296;
select * from documents where document_id=1319;
-- document_id=826 or document_id=291;
use antsnab;
show tables;


show columns from oc_product_description;

select * from oc_url_alias where query like 'category%';
select * from oc_category_path where category_id = 282;


select * from oc_event;
show tables;
show columns from oc_product;
show columns from oc_url_alias;
show columns from oc_newsblog_article_description;
select description from oc_newsblog_article_description where article_id = 56;
select * from oc_url_alias where `query`='category_id=123';
select 
                catprop.category_prodproperty_id, catprop.`name` as cat_name, catprop.unit as cat_unit, 
                catprop.`default` as cat_default, catprop.showInProdPreview, catprop.showInProdTab, catprop.showInSummary,
                catprop.sortOrder as cat_sortOrder,  
                prodval.sortOrder  as prod_sortOrder, prodval.val as prod_val, prodval.hide as prod_hide,
                (if (prodval.sortOrder is null, catprop.sortOrder, prodval.sortOrder) ) as sortOrder,
                (if (prodval.val is null, catprop.`default`, prodval.val) ) as val 
                from oc_product_to_category as p2c
                left join category_prodproperty as catprop on catprop.category_id = p2c.category_id
                left join (select * from product_prodproperty where product_id = 217 ) as prodval on prodval.category_prodproperty_id = catprop.category_prodproperty_id 
                where p2c.product_id = 217 and p2c.main_category = 1 and catprop.category_prodproperty_id is not null order by sortOrder ASC;

				""select 
                catprop.category_prodproperty_id, catprop.`name` as cat_name, catprop.unit as cat_unit, 
                catprop.`default` as cat_default, catprop.showInProdPreview, catprop.showInProdTab, catprop.showInSummary,
                catprop.sortOrder as cat_sortOrder,  
                prodval.sortOrder  as prod_sortOrder, prodval.val as prod_val, prodval.hide as prod_hide,
                (if (prodval.sortOrder is null, catprop.sortOrder, prodval.sortOrder) ) as sortOrder,
                (if (prodval.val is null, catprop.`default`, prodval.val) ) as val 
                from oc_product_to_category as p2c
                left join category_prodproperty as catprop on catprop.category_id = p2c.category_id
                left join (select * from product_prodproperty where product_id = :id ) as prodval on prodval.category_prodproperty_id = catprop.category_prodproperty_id 
                where p2c.product_id = :id and p2c.main_category = 1 and catprop.category_prodproperty_id is not null ord""

Cannot access private property Registry::$data
				"select 
                catprop.category_prodproperty_id, catprop.`name` as cat_name, catprop.unit as cat_unit, 
                catprop.`default` as cat_default, catprop.showInProdPreview, catprop.showInProdTab, catprop.showInSummary,
                catprop.sortOrder as cat_sortOrder,  
                prodval.sortOrder  as prod_sortOrder, prodval.val as prod_val, prodval.hide as prod_hide,
                (if (prodval.sortOrder is null, catprop.sortOrder, prodval.sortOrder) ) as sortOrder,
                (if (prodval.val is null, catprop.`default`, prodval.val) ) as val 
                from oc_product_to_category as p2c
                left join category_prodproperty as catprop on catprop.category_id = p2c.category_id
                left join (select * from product_prodproperty where product_id = :id ) as prodval on prodval.category_prodproperty_id = catprop.category_prodproperty_id 
                where p2c.product_id = :id and p2c.main_category = 1 and catprop.category_prodproperty_id is not null ord"

				"select 
                catprop.category_prodproperty_id, catprop.`name` as cat_name, catprop.unit as cat_unit, 
                catprop.`default` as cat_default, catprop.showInProdPreview, catprop.showInProdTab, catprop.showInSummary,
                catprop.sortOrder as cat_sortOrder,  
                prodval.sortOrder  as prod_sortOrder, prodval.val as prod_val, prodval.hide as prod_hide,
                (if (prodval.sortOrder is null, catprop.sortOrder, prodval.sortOrder) ) as sortOrder,
                (if (prodval.val is null, catprop.`default`, prodval.val) ) as val 
                from oc_product_to_category as p2c
                left join category_prodproperty as catprop on catprop.category_id = p2c.category_id
                left join (select * from product_prodproperty where product_id = :id ) as prodval on prodval.category_prodproperty_id = catprop.category_prodproperty_id 
                where p2c.product_id = :id and p2c.main_category = 1 and catprop.category_prodproperty_id is not null ord"

				$sql

show columns from oc_category;

show columns from produnit_unit;

select * from oc_category_description where category_id=73;

SELECT p.product_id FROM oc_newsblog_article_related pr
		LEFT JOIN oc_product p ON (pr.related_id = p.product_id)
		LEFT JOIN oc_product_to_store p2s ON (p.product_id = p2s.product_id)
		WHERE pr.article_id = '38' AND pr.type=2 AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '0' ORDER BY RAND()  LIMIT 0,4;


		select year(date_available) as yr, oc_newsblog_article.article_id from oc_newsblog_article left join oc_newsblog_article_to_category on oc_newsblog_article.article_id=oc_newsblog_article_to_category.article_id
		left join oc_newsblog_category_path on oc_newsblog_category_path.category_id = oc_newsblog_article_to_category.category_id where oc_newsblog_category_path.path_id=1; group by yr order by yr;


		 select * from oc_newsblog_category_path;

		 SELECT  COUNT(DISTINCT p.article_id) AS total FROM oc_newsblog_category_path cp LEFT JOIN oc_newsblog_article_to_category p2c ON (cp.category_id = p2c.category_id) LEFT JOIN oc_newsblog_article p ON (p2c.article_id = p.article_id) LEFT JOIN oc_newsblog_article_description pd ON (p.article_id = pd.article_id) LEFT JOIN oc_newsblog_article_to_store p2s ON (p.article_id = p2s.article_id) WHERE pd.language_id = '1' AND p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '0' AND cp.path_id = '1' AND year(p.date_available) = 2015;

