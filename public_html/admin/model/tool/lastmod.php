<?php
class ModelToolLastmod extends Model {
    function setLastTime($urls){
        foreach($urls as $url){
            $result=$this->db->query("select id from last_mod_pages where url='".$url."'");
            if($result->num_rows) {
                $sql="UPDATE last_mod_pages set time='".time()."' WHERE url='".$url."'";
            }else{
                $sql="INSERT INTO last_mod_pages (url,time) VALUES ('".$url."','".time()."')";
            }
            $this->db->query($sql);
        }
    }
}
