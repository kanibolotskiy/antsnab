<?php
class ModelCalcCalc extends Model {
  function getProductsByCalc($calculator_id){
    //$query = $this->db->query("SELECT DISTINCT * from oc_product where calc='".$calculator_id."'");
    $query = $this->db->query("SELECT DISTINCT * from oc_product op 
    LEFT JOIN oc_product_to_category oc ON oc.product_id=op.product_id and oc.main_category=1
    LEFT JOIN oc_category o_cat ON o_cat.category_id=oc.category_id
    where op.notavail=0 and (op.calc='".$calculator_id."' or (op.calc='0' and o_cat.calc='".$calculator_id."') 
    order by op.quantity DESC");

    
    $products=[];
    foreach ($query->rows as $result) {
      $products[]=$result['product_id'];
    }
    return $products;
		//return $query->rows;
  }
  function getProductsAnalog($products_arr){
    if($products_arr){
      $products_str=implode(",",$products_arr);
      $query = $this->db->query("SELECT o_p.product_id
      FROM oc_product_related o_r 
      LEFT JOIN oc_product o_p ON o_r.related_id=o_p.product_id
      LEFT JOIN oc_product_to_category o_c ON o_c.product_id=o_p.product_id and o_c.main_category=1
      LEFT JOIN oc_category_path o_pa ON o_pa.category_id=o_c.category_id and o_pa.level=1
      WHERE op.notavail=0 and o_r.product_id IN (".$products_str.") and o_p.quantity>0 group by o_p.product_id order by IF(o_pa.path_id=270,1,0) ASC, o_p.quantity DESC");
      $products=[];
      foreach ($query->rows as $result) {
        $products[]=$result['product_id'];
      }
      return $products;
    }
  }	
}