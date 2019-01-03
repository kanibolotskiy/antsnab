    return -1;
use antsnab;

show columns from oc_url_alias;

select * from oc_newsblog_article as a left join oc_newsblog_article_description as d on d.article_id = a.article_id;


show tables;

delete from oc_url_alias where url_alias_id in(3039
,2958
,2959
,3118
,3040
,3042
,3041
,3119
,3120
,3043
,2960
,3044
,3121
,3122
,3045
,3046
,3170
,3048
,3171
,3123
,3047
,2961
,3050
,2963
,2962
,3173
,3172
,3124
,3049
,2964
,3051
,3053
,3052
,3174
,3125
,3054
,2966
,2965
,2967
,3126
,3055
,3175
,3127
,3056
,2968
,2969
,3128
,3177
,3176
,3178
,3057
,3180
,3179
,2970
,3129
,3058
,2971
,3254
,3059
,3181
,2972
,3182
,3183
,3060
,3184
,3185
,3130
,3186
,3061
,2973
,2974
,2975
,3062
,3187
,3188
,3189
,2976
,3190
,3191
,3131
,3192
,3193
,3132
,2977
,3063
,3133
,3134
,3064
,3135
,3136
,2978
,3065
,3066
,3194
,3195
,3067
,3068
,3069
,3137
,2979
,3196
,3070
,3072
,3138
,2981
,2980
,3071
,3197
,3139
,3074
,3073
,3198
,3140
,2982
,3075
,3199
,2983
,3141
,2984
,2985
,3076
,2986
,3142
,3143
,3077
,3144
,3145
,3200
,2987
,3253
,3146
,3201
,3078
,3079
,2988
,3080
,3202
,2989
,3147
,3203
,3148
,3204
,3149
,3205
,3081
,2990
,3206
,2991
,3150
,3207
,3252
,3208
,3082
,3209
,2992
,2993
,3210
,3151
,3083
,2940
,2997
,3211
,2994
,3212
,3213
,3152
,3084
,3085
,2995
,3086
,3153
,3214
,3087
,2996
,3000
,3215
,3154
,3155
,2938
,3218
,3216
,3217
,3088
,3003
,2998
,3156
,3219
,3157
,3089
,2999
,3090
,3004
,3005
,3220
,3091
,3092
,3001
,3094
,3006
,3095
,3221
,3093
,3159
,3160
,3002
,3096
,3007
,3161
,3222
,3097
,3098
,3008
,3224
,3099
,3223
,3100
,3009
,3225
,3101
,3162
,3102
,3103
,3010
,3013
,3011
,3014
,3012
,3163
,3104
,3019
,3016
,3226
,3105
,3020
,3015
,3164
,3165
,2941
,3017
,3021
,3227
,3106
,3107
,3018
,3108
,2942
,3022
,2943
,2944
,1680
,2939
,3228
,2945
,3024
,3166
,3109
,3025
,2946
,2947
,3026
,3229
,3230
,3110
,2948
,2949
,3023
,2950
,3167
,3231
,3111
,3112
,3027
,2951
,3028
,2937
,2952
,3238
,3113
,3029
,3232
,2953
,3114
,3168
,3030
,3031
,3233
,2954
,3115
,3033
,3032
,2955
,3034
,3035
,3116
,3036
,3234
,3235
,2956
,3236
,3038
,3037
,3117
,2957
,3169
,3255
,3241
,3237
,3240
,3242
,1710
,1727
,1717
,1690
,1694
,1693
,1689
,1691
,1692
,1684
,1712
,1683
,1686
,1687
,1688
,1724
,1705
,1725
,1714
,1709
,1728
,1720
,1729
,1722
,1713
,1731
,1708
,1726
,1719
,1723
,1704
,1715
,1730
,3158
,1682
,1716
,1696
,1697
,1698
,1699
,1700
,1701
,1702
,1703
,1707
,1718
,1681
,1679
,1721
,1711
,1685);

select min(url_alias_id) as id from oc_url_alias as tmp  where query like 'newsblog_article_id%' group by keyword having count(keyword)>1; 

select count(*) from oc_url_alias where url_alias_id < 2880 and query like 'newsblog_article_id%';



delete from oc_newsblog_article where article_id in (
    select article_id from oc_newsblog_article_to_category where category_id in (49, 50, 51, 52, 53, 54, 55)
);

delete from oc_newsblog_article_description where article_id in (
    select article_id from oc_newsblog_article_to_category where category_id in (49, 50, 51, 52, 53, 54, 55)
);

delete from oc_newsblog_article_to_category  where category_id in (49, 50, 51, 52, 53, 54, 55);


select * from antsnaborigin.documents where document_id=3208;

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

