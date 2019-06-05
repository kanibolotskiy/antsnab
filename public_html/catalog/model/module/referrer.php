<?php
class ModelModuleReferrer extends Model {
    public function getContactsReferrer(){
        
        $data=[];
        if (isset($this->request->cookie['first_referrer'])) {
            $referrer_id=$this->request->cookie['first_referrer'];
        }else{
            $referrer_id=$this->checkReferrer();
        }    
        if($referrer_id){
            $sql="SELECT DISTINCT * from " . DB_PREFIX . "referrer_patterns where pattern_id='".$referrer_id."'";
            $query=$this->db->query($sql);
            $data=$query->row;
        }

        return $data;
    }
    
    public function checkReferrer() {
        // Save first referrer
        
        $time_referrer = time() + 60*60 * 24 * 30;
        $referrer_id=0;
        
        if (!isset($this->request->cookie['first_referrer'])) {
            
            $time_referrer = time() + 60*60 * 24 * 30;

            if(isset($_GET['utm_source'])){
                $utm_source=$_GET['utm_source'];
            }else{
                $utm_source='';
            }
            if(isset($_GET['utm_medium'])){
                $utm_medium=$_GET['utm_medium'];
            }else{
                $utm_medium='';
            }
            if(isset($_GET['utm_campaign'])){
                $utm_campaign=$_GET['utm_campaign'];
            }else{
                $utm_campaign='';
            }
            if(isset($_GET['utm_term'])){
                $utm_term=$_GET['utm_term'];
            }else{
                $utm_term='';
            }
            if(isset($_GET['utm_content'])){
                $utm_content=$_GET['utm_content'];
            }else{
                $utm_content='';
            }
            
            $referrers_query=$this->db->query("SELECT * from " . DB_PREFIX . "referrer_patterns");
            
            $referrer_id=0;
            foreach($referrers_query->rows as $referrer){
                $flag_ref=true;    

                if($referrer['utm_source']){                    
                    if($referrer['utm_source']!=$utm_source){
                        $flag_ref=false;
                    }
                }
                if($referrer['utm_medium']){                    
                    if($referrer['utm_medium']!=$utm_medium){
                        $flag_ref=false;
                    }
                }
                if($referrer['utm_campaign']){                    
                    if($referrer['utm_campaign']!=$utm_campaign){
                        $flag_ref=false;
                    }
                }
                if($referrer['utm_term']){                    
                    if($referrer['utm_term']!=$utm_term){
                        $flag_ref=false;
                    }
                }
                if($referrer['utm_content']){                    
                    if($referrer['utm_content']!=$utm_content){
                        $flag_ref=false;
                    }
                }
                

                if($flag_ref){
                    $referrer_id=$referrer['pattern_id'];
                }
                //echo $referrer['pattern_id']."!<br/>";
                
                //if(($referrer['utm_source']) and ($referrer['utm_source']==$utm_source)){
                //    //echo $referrer['pattern_id']."!";
                //}
            }
            if($referrer_id){
                setcookie('first_referrer',$referrer_id, $time_referrer, '/');
            }


/*
            $sql="SELECT DISTINCT pattern_id from " . DB_PREFIX . "referrer_patterns where 
            utm_source='".$this->db->escape($utm_source)."' 
            AND utm_source='".$this->db->escape($utm_source)."' 
            AND utm_medium='".$this->db->escape($utm_medium)."'
            AND utm_campaign='".$this->db->escape($utm_campaign)."'
            AND utm_term='".$this->db->escape($utm_term)."'
            AND utm_content='".$this->db->escape($utm_content)."'";
            $query = $this->db->query($sql);

            if($query->num_rows){
                $referrer_id=$query->row['pattern_id'];
                setcookie('first_referrer',$referrer_id, $time_referrer, '/');
            }
*/            
        }else{
            $referrer_id=$this->request->cookie['first_referrer']*1;
        }

        /*
        if (!isset($this->request->cookie['first_referrer'])) {
            if(isset($this->request->get['referrer'])) {
                setcookie('first_referrer', $this->request->get['referrer'], $time_referrer, '/');
            } elseif (isset($_SERVER['HTTP_REFERER']) && $_SERVER['HTTP_REFERER'] != '' && strpos($_SERVER['HTTP_REFERER'], 'http://'.$_SERVER['SERVER_NAME']) !== 0) {
                setcookie('first_referrer', $_SERVER['HTTP_REFERER'], $time_referrer, '/');
            } else {
                setcookie('first_referrer', 'Direct',$time_referrer, '/');
            }
        }
        */
        /*
        // Save last referrer
        if (!isset($this->request->cookie['last_referrer'])) {
            if(isset($this->request->get['referrer'])) {
                setcookie('last_referrer', $this->request->get['referrer'], $time_referrer, '/');
            } elseif (isset($_SERVER['HTTP_REFERER']) && $_SERVER['HTTP_REFERER'] != '' && strpos($_SERVER['HTTP_REFERER'], 'http://'.$_SERVER['SERVER_NAME']) !== 0) {
                setcookie('last_referrer', $_SERVER['HTTP_REFERER'], $time_referrer, '/');
            } else {
                setcookie('last_referrer', 'Direct', $time_referrer, '/');
            }
        }
        */
        return $referrer_id;
    }
}
?>