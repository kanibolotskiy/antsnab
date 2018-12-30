-- document_type = 241; 
 
SELECT document_content FROM documents where document_id = 2076;
SELECT * FROM documents where document_type = 259; 

SELECT * FROM documents where document_url like '%loading-rates-mastics%'; 
-- 259

SELECT * FROM documents where document_url like '%gidroizolyaciya-fundamenta-bitumnoj-mastikoj%'; 
-- 275, 2583

select distinct(document_type) from documents where document_url like '%news%'; 

SELECT document_content, document_codepage, document_name, document_deleted, document_sort, document_url, document_level, document_sub_documents FROM documents where document_type = 241 order by document_level, document_url, document_sort;

select document_id, document_parent_id, document_level, document_sort, document_name, document_url, document_content
from documents where document_type = 241 and document_deleted = 0 order by document_level, document_parent_id;

select distinct(document_parent_id) from documents where document_type=253;

select document_id, document_parent_id, document_level, document_sort, document_name, document_url, document_content from documents where document_type = 241 and document_deleted = 0 order by document_level, document_parent_id;

select * from oc_category_description;

-- drop database antsnab;

-- create database antsnab charset utf8 collate utf8_general_ci;

select product_id, model from oc_product;