<?php

/**
 * QueryHelper Description 
 * 
 * @version    0.1, Aug 16, 2018  3:04:26 PM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Lapshin 
 */

namespace WS\Patch\Helper;

class QueryHelper
{

    //put your code here    
    public static function paramToArray($param)
    {
        if (!is_array($param)) {
            $par = $param;
            $param = [];
            $param[] = static::escape($par);
        }
        return $param;
    }

    public static function paramToEqualSqlCondition($fieldName, $param)
    {
        if (!is_array($param)) {
            return $fieldName . "='" . static::escape($param) . "' ";
        }
        return $fieldName . " IN ('" . implode("','", $param) . "') ";
    }

    private static function escape($v)
    {
        return str_replace(array("\\", "\0", "\n", "\r", "\x1a", "'", '"'), array("\\\\", "\\0", "\\n", "\\r", "\Z", "\'", '\"'), $v);
    }

}
