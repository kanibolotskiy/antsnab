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
        $sql_sel=[];

        $limit_str="";
        if($limit){
            $limit_str=" limit ".$limit;
        }
        foreach($query_arr as $query_itm){
            //$query_itm=str_replace(["(",")","'",'"',";"],"", $query_itm);
            $query_itm=addslashes($query_itm);
            $query_itm_translit=$this->correctString($query_itm);
            $alt_word="";
            $sql_sel[]="od.name like '%".$query_itm."%'";
            if($query_itm_translit!=$query_itm){
                $alt_word="or om.name like '%".$query_itm_translit."%' or op.sku like '%".$query_itm_translit."%' or od.meta_h1 like '%".$query_itm_translit."%' or od.description like '%".$query_itm_translit."%' or od.description_mini like '%".$query_itm_translit."%' or od.name like '%".$query_itm_translit."%' or od.search like '%".$query_itm_translit."%'";
                $sql_sel[]="od.name like '%".$query_itm_translit."%'";
            }
            $sql_add[]="(
                        om.name like '%".$query_itm."%' or op.sku like '%".$query_itm."%' or od.meta_h1 like '%".$query_itm."%' or od.description like '%".$query_itm."%' or od.description_mini like '%".$query_itm."%' or od.name like '%".$query_itm."%' or od.search like '%".$query_itm."%' 
                        ".$alt_word."
                    )";
            
        }
        if(is_array($sql_add)){
            $sql_str=implode(" AND",$sql_add);
        }
        $sql_select="IF(".implode(" or ",$sql_sel).", 0, 1)  AS name_like";

        //,IF(od.meta_h1 like '%праймер%' or od.meta_h1 like '%пруф%', 0, 1) AS meta_h1_like

        $sql="SELECT od.meta_h1, op.product_id, ".$sql_select." 
         FROM oc_product op LEFT JOIN oc_product_description od ON op.product_id=od.product_id
        LEFT JOIN oc_manufacturer om ON op.manufacturer_id=om.manufacturer_id
        WHERE op.status=1 AND 
        (
            ".$sql_str."
        )
        ORDER by name_like, op.viewed DESC ".$limit_str;
        $query = $this->db->query($sql);
        return $query->rows;
        
    }

}
