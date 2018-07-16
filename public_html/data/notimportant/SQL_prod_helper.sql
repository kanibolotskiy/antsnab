-- document_type = 241; 
 
SELECT document_name, document_content FROM documents where document_id = 2675;
SELECT * FROM documents where document_id = 209;

SELECT * FROM documents where document_url like '%products/roll/krz/elastoizol-premium/ekp-50%';
SELECT * FROM documents where document_url like '%products/smesi/shtukaturki/gips-de-luxe-klass-seraya-rn%';
SELECT * FROM documents where document_id = 3104;
select distinct(document_type)  from documents where document_type<>241 and document_url like '/products/%';
select count(*) from documents; 

SELECT document_codepage, document_name, document_deleted, document_sort, document_url, document_level, document_sub_documents FROM documents where document_type = 241 order by document_level, document_url, document_sort;

select document_id, document_parent_id, document_level, document_sort, document_name, document_url, document_content
from documents where document_type = 241 and document_deleted = 0 order by document_level, document_parent_id;

select distinct(document_parent_id) from documents where document_type=253;

select document_type, document_id, document_parent_id, document_level, document_sort, document_name, document_url, document_content from documents where document_type = 241 and document_deleted = 0 order by document_level, document_parent_id;

select * from oc_category_description;

-- drop database antsnab;

-- create database antsnab charset utf8 collate utf8_general_ci;

show columns from oc_product;
select D.document_type, D.document_id, D.document_parent_id, D.document_level, D.document_sort, D.document_name, D.document_url, D.document_content, P.document_content as document_parent_content from documents as D  left join documents as P on P.document_id = D.document_parent_id  where D.document_type in (253,2547,2555,2556,2557,2558,2559,2560) and D.document_deleted = 0 group by D.document_type order by D.document_parent_id, D.document_sort;

select document_content, document_name, document_id, document_parent_id from documents where document_name like 'Рубероид%';

show columns from oc_product;

select count(showInSummary) from oc_product where showInSummary=1;
