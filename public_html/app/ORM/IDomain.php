<?php
/**
 * @category WS patches 
 * @package  WS\Domain
 */

namespace WS\ORM;


/**
 * Описание класса 
 * @task add comments 
 * @version    1.0, Mar 27, 2018  3:37:18 PM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
interface IDomain
{
   /**
    * @return []
    */
   function getMetaData(); 

   /**
    * @return boolean
    */ 
   function validate();
}
