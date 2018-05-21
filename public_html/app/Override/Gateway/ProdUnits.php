<?php
namespace WS\Override\Gateway;

/**
 * Описание класса 
 * 
 * @version    1.0, May 9, 2018  7:39:20 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ProdUnits extends \Model
{
   public function getUnits($templateId, $order = null)
   {
        $sql = 'SELECT u.unit_id as id, u.*  FROM produnit_unit as u ' . 
               'where u.produnit_template_id = :tplid ';
        if ( null !== $order ) {
            $sql .= " " . $order;
        }

        $res =  $this->db->query($sql, [':tplid'=>$templateId] );


        return $res->rows;
   }

   public function saveUnit($data)
   {
       $calcKoef = ($data['calcKoef'] === '')?null:(float)str_replace(',','.', $data['calcKoef']);
       $weight = ($data['weight'] === '')?null:(float)str_replace(',','.', $data['weight']);
       $calcRel = ($data['calcRel'] ==='')?null:(int)$data['calcRel'];
       
       $query = "UPDATE produnit_unit set 
                    name = :name,
                    name_price = :name_price,
                    name_plural = :name_plural,
                    name_package_dimension = :name_package_dimension,
                    name_in_package = :name_in_package,
                    calcKoef = :calcKoef,
                    calcRel = :calcRel,
                    switchSortOrder = :switchSortOrder,
                    loadingSortOrder = :loadingSortOrder,
                    weight = :weight,
                    package_width = :package_width,
                    package_length = :package_length,
                    package_height = :package_height
                 WHERE unit_id = :unit_id";

       $res =  $this->db->query($query, [
                    ':name' => $data['name'],
                    ':name_price' =>$data['name_price'],
                    ':name_plural' =>$data['name_plural'],
                    ':name_package_dimension' =>$data['name_package_dimension'],
                    ':name_in_package' =>$data['name_in_package'],
                    ':calcKoef' =>$calcKoef,
                    ':calcRel' =>$calcRel,
                    ':switchSortOrder' =>$data['switchSortOrder'],
                    ':loadingSortOrder' =>$data['loadingSortOrder'],
                    ':weight' =>$weight ,
                    ':package_width' =>$data['package_width'],
                    ':package_length' =>$data['package_length'],
                    ':package_height' =>$data['package_height'],
                    ':unit_id' => $data['id'] 
       ] );
      
       return $data['id'];    
   }

   public function addUnit($data)
   {
       $calcKoef = ($data['calcKoef'] === '')?null:(float)str_replace(',','.', $data['calcKoef']);
       $weight = ($data['weight'] === '')?null:(float)str_replace(',','.', $data['weight']);
       $calcRel = ($data['calcRel'] ==='')?null:(int)$data['calcRel'];
       
       $query = "insert into produnit_unit 
                    (produnit_template_id, name, name_price, name_plural, name_package_dimension,
                     name_in_package, calcKoef, calcRel, switchSortOrder, loadingSortOrder, weight,
                     package_width, package_length, package_height) values 
                    (:produnit_template_id, :name, :name_price, :name_plural, :name_package_dimension,
                     :name_in_package, :calcKoef, :calcRel, :switchSortOrder, :loadingSortOrder, :weight,
                     :package_width, :package_length, :package_height);";

       $res =  $this->db->query($query, [
                    ':produnit_template_id' => $data['templateId'],
                    ':name' => $data['name'],
                    ':name_price' =>$data['name_price'],
                    ':name_plural' =>$data['name_plural'],
                    ':name_package_dimension' =>$data['name_package_dimension'],
                    ':name_in_package' =>$data['name_in_package'],
                    ':calcKoef' =>$calcKoef,
                    ':calcRel' =>$calcRel,
                    ':switchSortOrder' =>$data['switchSortOrder'],
                    ':loadingSortOrder' =>$data['loadingSortOrder'],
                    ':weight' =>$weight ,
                    ':package_width' =>$data['package_width'],
                    ':package_length' =>$data['package_length'],
                    ':package_height' =>$data['package_height']
       ] );
      
       return $this->db->getLastId();  
   }

   public function deleteUnit($id)
   {
       $sql = "delete from produnit_unit where unit_id = :id";
       return ($this->db->query($sql, [':id'=>$id]))?true:false; 
   }

   /**
    * 
    * @param string $name - имя поля базового флага
    * @param int $value - id единицы, которую установить базовой в ее шаблоне. 
    */
   public function setBase($name, $value)
   {
       $sql = "SELECT produnit_template_id as tplid from produnit_unit where unit_id = :id limit 1";
       $res = $this->db->query($sql,[':id'=>$value]);
       $tplid = $res->row['tplid'];

       $this->resetBase($name, $tplid);

       $sql = "UPDATE produnit_unit set " . $name . " = 1 where unit_id = :id ";
       $this->db->query($sql, [':id'=>$value]);

       return ( $this->db->countAffected() == 1 )? true:false;
   }

   /**
    * Сбросить все базы в шаблоне с именем $name 
    */
   public function resetBase($name, $templateId) 
   {
       $sql = "UPDATE produnit_unit set " . $name . " = 0 where produnit_template_id = :tplid";
       $this->db->query($sql, [':tplid'=>$templateId] );
       return true;
   }

   public function getBase($name, $templateId)
   {
      $sql = "SELECT * FROM produnit_unit where produnit_template_id = :tplid and ".$name." = 1 order by unit_id ASC limit 1";
      $res =  $this->db->query($sql, [':tplid'=>$templateId] ); 
      return ($res->num_rows === 1)? $res->row : null; 
   }

   public function getUnit($id)
   {
      $query = 'SELECT u.unit_id as id, u.*  FROM produnit_unit as u ' . 
               'where u.unit_id = :id limit 1';
      $res = $this->db->query($query, [':id'=>$id]);
      return $res->row;
   }
}
