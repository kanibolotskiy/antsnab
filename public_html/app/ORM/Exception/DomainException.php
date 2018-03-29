<?php

/**
 * @category WS patches 
 * @package  WS\Domain
 */

namespace WS\ORM\Exeption;


/**
 * Описание класса 
 * 
 * @version    1.0, Mar 22, 2018  12:39:19 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ORMException extends \Exception
{
    const WRONG_LOAD = "Error occured while loading model, with message:";
    const WRONG_SAVE = "Error occured while saving model, with message:";
    const WRONG_DELETE = "Error occured while deleting model, with message:";
    const WRONG_ATTRIBUTE = "Error occured while access attribute. Not exist:";
    const WRONG_ATTRIBUTE_PK = "Primary key couldn't be set";
}
