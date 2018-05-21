<?php

/**
 * ProdUnitStrings Description 
 * 
 * @version    0.1, May 21, 2018  12:14:17 PM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Rapshin (http://vk.com/wslapshin) 
 */

namespace WS\Override\Gateway;

class ProdUnitStrings extends \Model
{
    public function generate($templateId)
    {
       $query = "select L.name as lname, L.name_plural as lname_plural, L.name_package_dimension as lname_package_dimension, L.name_in_package as lname_in_package, L.calcKoef as quant, L.weight as weight, L.package_length as lpackage_length, L.package_width as lpackage_width, L.package_height as lpackage_height, "
           . " R.name as rname, R.name_plural as rname_plural, R.name_package_dimension as rname_package_dimension, R.name_in_package as rname_in_package"
           . " from produnit_unit as L "
           . "left join produnit_unit as R on R.unit_id = L.calcRel "
           . "where L.produnit_template_id = :id";
       $res = $this->db->query($query, [':id'=>$templateId]);
       $pairs = $res->rows;


       $strings = [];
       $sortorder = 1;
       //@task delete hardcoded language strings
       foreach( $pairs as $pair ) {
          if($pair['quant']) {
              $strings[] = [
                 'description' => 'Упаковка',
                 'value' => $pair['lname'] . ', ' . $pair['quant'] . ' ' . $pair['rname_plural'],
                 'sortOrder'=> $sortorder 
              ];
              $sortorder++;
              $strings[] = [
                 'description' => $pair['lname_in_package'] . ': ',
                 'value' =>  $pair['quant'] . ' ' . $pair['rname_plural'],
                 'sortOrder'=> $sortorder 
              ];
              $sortorder++;
          }

          if( $pair['weight'] ) { 
              $strings[] = [
                     'description' => 'Вес' . ' ' . $pair['lname_package_dimension'] . ': ',
                     'value' =>  $pair['weight']. 'кг',
                     'sortOrder'=> $sortorder 
              ];
              $sortorder++;
          }

          if( $pair['lpackage_width'] || $pair['lpackage_length'] ) {
              $strings[] = [
                     'description' => 'Размер' . ' ' . $pair['lname_package_dimension'] . ': ',
                     'value' =>  $pair['lpackage_width'] . ' x ' . $pair['lpackage_length'],
                     'sortOrder'=> $sortorder 
              ];
              $sortorder++;
          }

          if( $pair['lpackage_height'] ) {
              $strings[] = [
                     'description' => 'Толщина' . ' ' . $pair['lname_package_dimension'] . ': ',
                     'value' =>  $pair['lpackage_height'],
                     'sortOrder'=> $sortorder 
              ];
              $sortorder++;
          }
       }

       return $strings;
        
    }
}
