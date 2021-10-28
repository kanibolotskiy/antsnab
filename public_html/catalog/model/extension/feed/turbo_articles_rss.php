<?php
class ModelExtensionFeedTurboArticlesRss extends Model {
	
    function getArticles(){
        $sql="SELECT * FROM `oc_newsblog_article_description` od LEFT JOIN oc_newsblog_article oa ON od.article_id=oa.article_id WHERE od.language_id=1";
        $query = $this->db->query($sql);
        return $query->rows;
    }
}
?>