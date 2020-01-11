<?php
namespace WS\Override\Gateway\ProdUnits;

use WS\Override\Gateway\ProdUnits\ProdUnits;
use \Exception;
use Phospr\Fraction;

/**
 * Каждый продукт может исчисляться в разных единицах измерения.
 * Для присвоения продукту единиц - к нему устанавливается шаблон единиц измерения;
 * В шаблоне содержаться текстовые описания единиц
 * @task - реализовать- помимо шаблона к продукту привязаны правила пересчета единиц друг в друга
 * (сейчас шаблоны и правила в одной таблице)
 * Этот класс реализует необходимые пересчеты по сохраненным в БД правилам
 *
 * Единица измерения характеризуется типом (для целей пересчета):
 * isPriceBase - единица измерения в которой устанавливаются цены, ведется учет в 1С, расчитываются суммы заказа
 * isSaleBase - единица кратно которой осуществляется продажа на сайте
 * @deprecated isPackageBase
 *
 * @version    1.0, May 9, 2018  7:39:20 AM
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin)
 */
class ProdUnitsCalc extends \Model
{
    /**
        * Возвращает коэффициент пересчета (множитель)
        * для пересчета из базовой единицы для продукта в единицу $toId
        *
        * @param array $product_id - id продукта, для которого осуществляется анализ
        * @param string $base  'PriceBase' || 'SaleBase'
        * @param int $toId - id целевой единицы измерения
        * @return Fraction - коэффициент
        */
    public function getBaseToUnitKoef($product_id, $base, $toId)
    {
        $allowedBases = ProdUnits::$ALLOWED_BASES;
        if (!in_array($base, $allowedBases)) {
            throw new Exception('Unknow base');
        }
        $unitsModel = new ProdUnits($this->registry);
        $units = $unitsModel->getUnitsByProduct($product_id);
        
        //check for base unit was set
        $baseUnitId = null;
        foreach ($units as $unit) {
            if ($unit[$base] == 1) {
                $baseUnitId = $unit['unit_id'];
                break;
            }
        }

        if (null === $baseUnitId) {
            throw new Exception('Base unit "' . $base . '" was not set');
        }

        if ($toId == $baseUnitId) {
            return Fraction::fromFloat(1.0);
        }

        /** 
         * Поиск возможного пересчета по сохраненным пользователем данным.
         * Т.к. у пользователя есть возможность сохранять соответствие только между двумя
         * единицами (через ввод "содержит") то пытаемся найти цепочку преобразований
         * от $baseUnitId до $toId и расчитать коэффициент. Если нет - ищем в обратную сторону
         * от $toId к $baseUnitId и берем обратное число
         */  
        
        $koef = $this->unitToUnit($units, $baseUnitId, $toId);
        
        if (null === $koef) {
            $koef = Fraction::fromFloat(1.0);
            $koef =  $koef->divide($this->unitToUnit($units, $toId, $baseUnitId));
        }
        
        if (null === $koef) {
            throw new Exception('cant calculate koefficient from ' . $toId . ' to ' . $base . ' direction ' . (int)$direction);
        }
        
        
        return $koef;
    }

    /*try to find koef value while forward search*/
    private function unitToUnit($units, $fromId, $toId)
    {
        $checkedIds = [];
        $continue = true;
        $koef = Fraction::fromFloat(1.0);
        $entryId = $fromId;
        while ($continue) {
            $entryUnit = $units[$entryId];

            if ($entryUnit['calcKoef'] == null || $entryUnit['calcRel'] == null) {
                return null;
            }

            $koef = $koef->multiply(Fraction::fromFloat((float)$entryUnit['calcKoef'])); 
            if ($entryUnit['calcRel'] == $toId) {
                return $koef;
            }

            $checkedIds[] = $entryId;
            $entryId = $entryUnit['calcRel'];

            /* Зацикливание ссылок, найти не удастся */
            $continue = (in_array($entryId, $checkedIds))?false:true;
        }

        return null;
    }

}
