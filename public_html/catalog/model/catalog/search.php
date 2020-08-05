<?php
class ModelCatalogSearch extends Model {
    private function correctString($text)
	{
		$str_search = array(
			"q","w","e","r","t","y","u","i","o","p","[","]",
			"a","s","d","f","g","h","j","k","l",";","'",
			"z","x","c","v","b","n","m",",","."
			);
		$str_replace = array(
			"й","ц","у","к","е","н","г","ш","щ","з","х","ъ",
			"ф","ы","в","а","п","р","о","л","д","ж","э",
			"я","ч","с","м","и","т","ь","б","ю"
			);
		
		return str_replace($str_search, $str_replace, $text);
    }
    
    public function searchBase($query_arr,$limit){
        $results=[];
        $sql_add=[];
        $limit_str="";
        if($limit){
            $limit_str=" limit ".$limit;
        }
        foreach($query_arr as $query_itm){
            $query_itm_translit=$this->correctString($query_itm);
            $sql_add[]="(
                        op.sku like '%".$query_itm."%' or od.meta_h1 like '%".$query_itm."%' or od.description like '%".$query_itm."%' or od.description_mini like '%".$query_itm."%' or od.name like '%".$query_itm."%' or od.search like '%".$query_itm."%' 
                        or op.sku like '%".$query_itm_translit."%' or od.meta_h1 like '%".$query_itm_translit."%' or od.description like '%".$query_itm_translit."%' or od.description_mini like '%".$query_itm_translit."%' or od.name like '%".$query_itm_translit."%' or od.search like '%".$query_itm_translit."%'
                    )";
        }
        if(is_array($sql_add)){
            $sql_str=implode(" AND",$sql_add);
        }
        $sql="SELECT od.meta_h1, op.product_id FROM oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id
        WHERE op.status=1 AND 
        (
            ".$sql_str."
        )
        ORDER by op.viewed DESC ".$limit_str;

        //echo $sql;
        $query = $this->db->query($sql);
        return $query->rows;
        
    }

}
