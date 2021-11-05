<?php
class ModelToolLastmod extends Model {
    function setLastTime($url,$last_time){
        $this->db->query("INSERT INTO last_mod_pages (url,time) VALUES ('".$url."','".$last_time."')");
    }
    function getLastTimeEdit($url){
        
        $query = $this->db->query("SELECT DISTINCT * from last_mod_pages where url='".$url."'");
        if(isset($query->rows[0]['time'])){
            $last_time=$query->rows[0]['time'];
        }else{
            $last_time=time();
            $this->db->query("INSERT INTO last_mod_pages (url,time) VALUES ('".$url."','".$last_time."')");
        }
        return $last_time;

    }
    function setLastModHeader($url){
        $LastModified_unix=$this->getLastTimeEdit($url);
        	//$LastModified_unix = 1294844676; // время последнего изменения страницы
		$LastModified = gmdate("D, d M Y H:i:s \G\M\T", $LastModified_unix);
		$IfModifiedSince = false;
		if (isset($_ENV['HTTP_IF_MODIFIED_SINCE']))
			$IfModifiedSince = strtotime(substr($_ENV['HTTP_IF_MODIFIED_SINCE'], 5)); 
		if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']))
			$IfModifiedSince = strtotime(substr($_SERVER['HTTP_IF_MODIFIED_SINCE'], 5));
		if ($IfModifiedSince && $IfModifiedSince >= $LastModified_unix) {
			header($_SERVER['SERVER_PROTOCOL'] . ' 304 Not Modified');
			exit;
		}
		header('Last-Modified: '. $LastModified);
    }
}
