<?php

/**
 * ProdUnitTemplates Description 
 * 
 * @version    0.1, May 21, 2018  7:54:35 AM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */

namespace WS\Override\Gateway;

class ProdUnitTemplates extends \Model
{
    public function getTemplates($order = null)
    {
        $sql = 'SELECT *  FROM produnit_template as u ' ; 

        if ( null !== $order ) {
            $sql .= " " . $order;
        }

        $res =  $this->db->query($sql);

        return $res->rows;
    }

    public function getTemplate($id)
    {
       $query = "select * from produnit_template where produnit_template_id = :id limit 1";
       $res = $this->db->query($query, [':id'=>$id]);
       return $res->row;
    }

    public function add($data)
    {
       $query = "insert into produnit_template (`name`,description) values(:name, :description)"; 
       $this->db->query($query, [':name'=>$data['name'], ':description'=>$data['description'] ]);
       return $this->db->getLastId();
    }

    public function update($data, $tplid)
    {
        $query = "update produnit_template set `name`=:name, description=:description where produnit_template_id = :id";
        $res = $this->db->query($query, [':name'=>$data['name'], ':description'=>$data['description'], ':id'=>$tplid ]);
        return $res;
    }

    public function delete($id)
    {
        $sql = 'DELETE from produnit_unit where produnit_template_id=:id'; 
        $this->db->query($sql, [':id'=>$id]);

        $sql = 'DELETE from produnit_packagestr where produnit_template_id=:id';
        $this->db->query($sql, [':id'=>$id]);

        $sql = 'DELETE from produnit_template where produnit_template_id=:id';
        $this->db->query($sql, [':id'=>$id]);
    }
}
