<?php
class ModelToolLastmod extends Model {
    private function setArrIds($arr,$item){
        $return_ids=[];
        foreach($arr as $row){
            $return_ids[]=$item.'/'.$row['id'].'id';
        }        
		return $return_ids;
    }


    function setLastTime($urls){
        $tm=time();
        foreach($urls as $url){
            $result=$this->db->query("select id from last_mod_pages where url='".$url."'");
            if($result->num_rows) {
                $sql="UPDATE last_mod_pages set time='".$tm."' WHERE url='".$url."'";
                $this->db->query($sql);

                
            }else{
                $sql="INSERT INTO last_mod_pages (url,time) VALUES ('".$url."','".$tm."')";
                $this->db->query($sql);
            }
            
        }

        $result=$this->db->query("select id from last_mod_pages where url='home'");
        if($result->num_rows) {
            $sql="UPDATE last_mod_pages set time='".$tm."' WHERE url='home'";
            $this->db->query($sql);
        }else{
            $sql="INSERT INTO last_mod_pages (url,time) VALUES ('home','".$tm."')";
            $this->db->query($sql);
        }
        
    }

    function productsBenefit($benefit_id){
        $sql="SELECT product_id as id FROM `dopinfo_benefits_to_product` WHERE benefit_id='".$benefit_id."' and product_id>0 group by product_id";
        $query = $this->db->query($sql);
        return $this->setArrIds($query->rows,'product');
    }
    private function strCount($notavail,$cnt){
        $str="";
        if($notavail){ 
            $str='Нет в наличии';
        }else{
            if($cnt>5){
                $str='На складе';
            }
            if($cnt>0 and $cnt<=5){
                $str='Мало';
            }
            if($cnt==0){
                $str='Под заказ';
            }
        }
        return $str;
    }
    function productParents($product_id, $data){
        $sql_asc_p="select price, price_wholesale, discount_percent, image, produnit_template_id, notavail, quantity from oc_product where product_id='".$product_id."'";
        $query_p = $this->db->query($sql_asc_p);


        $sql_asc="select name, description from oc_product_description where product_id='".$product_id."'";
        $query = $this->db->query($sql_asc);
        
        //print_r($query->rows[0]['name']);
        

        $data_old['name']=$query->rows[0]['name'];
        $data_old['description']=$query->rows[0]['description'];
        $data_old['price']=$query_p->rows[0]['price'];
        $data_old['price_wholesale']=$query_p->rows[0]['price_wholesale'];
        $data_old['discount_percent']=$query_p->rows[0]['discount_percent'];
        $data_old['produnit_template_id']=$query_p->rows[0]['produnit_template_id'];
        $data_old['cnt']=$this->strCount($query_p->rows[0]['notavail'],$query_p->rows[0]['quantity']);
        $data_old['image']=$query_p->rows[0]['image'];
       

        //print_r($data_old);

        /*
        echo $data_old['name']."==".$data['product_description'][1]['name']."<br/>";
        echo $data_old['price']."==".$data['price']."<br/>";
        echo $data_old['price_wholesale']."==".$data['price_wholesale']."<br/>";
        echo $data_old['discount_percent']."==".$data['discount_percent']."<br/>";
        echo $data_old['image']."==".$data['image']."<br/>";
        echo $data_old['produnit_template_id']."==".$data['produnit_template_id']."<br/>";
        echo $data_old['cnt']."==".$this->strCount(isset($data['notavail'])?$data['notavail']:0,$data['quantity']);
        echo $data_old['description']."==".$data['product_description'][1]['description']."<br/>";
        */
        
        //Категории, в которых нужны изменения
        $sql="SELECT category_id as id FROM `oc_product_to_category` WHERE product_id='".$product_id."'";
        $query_cats = $this->db->query($sql);
        $query_cat_arr=[];
        foreach ($query_cats->rows as $query_cat) {
            $query_cat_arr[]=$query_cat['id'];
        }
        
        $categories=array_diff($query_cat_arr, $data['product_category']);
        if($data_old['name']!=$data['product_description'][1]['name'] 
            or $data_old['price']!=$data['price'] 
            or $data_old['price_wholesale']!=$data['price_wholesale']
            or $data_old['discount_percent']!=$data['discount_percent']
            or $data_old['image']!=$data['image']
            or $data_old['produnit_template_id']!=$data['produnit_template_id']
            or $data_old['cnt']!=$this->strCount(isset($data['notavail'])?$data['notavail']:0,$data['quantity'])
            or $data_old['description']!=$data['product_description'][1]['description']
        ){
            $categories=array_merge($categories,$query_cat_arr);
        }
        $out['categories']=$categories;


        $products=[];
        $articles=[];
        $accias=[];

        
        //Изменения в прайс-листе
        $price=false;
        if($data_old['price']!=$data['price'] 
            or $data_old['price']!=$data['price'] 
        ){
            $price=true;
        }
        $out['price']=$price;

        //Изменения на странице всех скидок
        $discount=false;
        if($data_old['discount_percent']!=$data['discount_percent']){
            $discount=true;
        }
        $out['discount']=$discount;
        

        if($data_old['name']!=$data['product_description'][1]['name'] 
            or $data_old['price']!=$data['price'] 
            or $data_old['discount_percent']!=$data['discount_percent']
            or $data_old['image']!=$data['image']
        ){
            //Продукты, в которых нужны изменения (аналоги и сопутствующие)

            $sql="select product_id from oc_product_analogs where related_id='".$product_id."'";
            $query_analogs = $this->db->query($sql);
            foreach ($query_analogs->rows as $query_analog) {
                $products[]=$query_analog['product_id'];
            }
            $sql="select product_id from oc_product_related where related_id='".$product_id."'";
            $query_analogs = $this->db->query($sql);
            foreach ($query_analogs->rows as $query_analog) {
                $products[]=$query_analog['product_id'];
            }

            //Статьи и новости, в которых нужны изменения
            $sql="select article_id from oc_newsblog_article_related where related_id='".$product_id."'";
            $query_articles = $this->db->query($sql);
            foreach ($query_articles->rows as $query_article) {
                $articles[]=$query_article['article_id'];
            }

            //Акции, в которых учавствует товар
            $sql="select accia_id from accia_products where product_id='".$product_id."'";
            $query_accias = $this->db->query($sql);
            foreach ($query_accias->rows as $query_accia) {
                $accias[]=$query_accia['accia_id'];
            }

        }
        $out['products']=$products;
        $out['articles']=$articles;
        $out['accias']=$accias;
        
        return $out;
        //print_r($out);

        /**/
        //print_r($data);

        //print_r($data['product_description'][1]);

        /**/
        //$date=time();
        /*
        $sql="SELECT category_id as id FROM `oc_product_to_category` WHERE product_id='".$product_id."'";
        $query = $this->db->query($sql);
        return $this->setArrIds($query->rows,'category');
        */
        
    }

}
