use antsnab;

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

