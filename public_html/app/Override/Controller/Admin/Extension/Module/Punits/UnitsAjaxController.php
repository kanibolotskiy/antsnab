<?php

/**
 * UnitsAjaxController Description 
 * 
 * @version    0.1, May 18, 2018  12:20:09 PM 
 * @copyright  Copyright (c) 2018 antsnab 
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */

namespace WS\Override\Controller\Admin\Extension\Module\Punits;

use WS\Override\Gateway\ProdUnits\ProdUnits;

class UnitsAjaxController extends \Controller
{

    public function getAll()
    {
        $result = null;
        $error = null;
        $gateWay = new ProdUnits($this->registry);
        if (!isset($this->request->post['templateId'])) {
            $error = ['templateId is mandatory'];
        } else {
            $result = $gateWay->getUnitsByTemplate($this->request->post['templateId'], 'order by switchSortOrder ASC');
        }
        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function save()
    {
        if (!$this->request->post['id'] || 'new' == $this->request->post['id']) {
            return $this->add();
        }

        $result = null;
        $error = $this->validate($this->request->post);

        if (empty($error)) {
            $gateWay = new ProdUnits($this->registry);
            try {
                $result = $gateWay->saveUnit($this->request->post);
            } catch (Exception $e) {
                $error = [$e->getMessage()];
            }
        }

        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function add()
    {
        $result = null;
        $error = $this->validate($this->request->post);

        if (empty($error)) {
            $gateWay = new ProdUnits($this->registry);
            try {
                $result = $gateWay->addUnit($this->request->post);
            } catch (Exception $e) {
                $error = [$e->getMessage()];
            }
        }

        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function delete()
    {
        $result = null;
        $error = null;
        if ($this->request->post['id']) {
            $gateWay = new ProdUnits($this->registry);
            try {
                $result = $gateWay->deleteUnit($this->request->post['id']);
            } catch (Exception $e) {
                $error = [$e->getMessage()];
            }
        } else {
            $error = ['id is mandatory'];
        }
        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function changeBase()
    {
        $this->load->language('extension/module/produnits');
        $result = null;
        $error = null;
        $this->response->addHeader('Content-Type: application/json');

        if (!$this->request->post['name'] && !isset($this->request->post['value'])) {
            $json = ['result' => $result, 'error' => ['name and value are mandatory']];
            $this->response->setOutput(json_encode($json));
            return;
        }

        $gateWay = new ProdUnits($this->registry);
        $unitId = ( '' === $this->request->post['value'] ) ? null : (int) $this->request->post['value'];

        if( null == $unitId && !isset($this->request->post['template_id']) ) {
           $json = ['result' => $result, 'error' => ['template_id is mandatory']];
           $this->response->setOutput(json_encode($json));
           return; 
        }

        if ($this->request->post['name'] === 'isPackageBase' && null != $unitId) {
            $unit = $gateWay->getUnit($unitId);
            if (empty($unit['weight'])) {
                $json = ['result' => $result, 'error' => [$this->language->get('error_change_package_base')]];
                $this->response->setOutput(json_encode($json));
                return;
            }
        }

        try {
            if( null !== $unitId ) {
                $result = $gateWay->setBase($this->request->post['name'], $this->request->post['value']);
            } else {
                $result = $gateWay->resetBase($this->request->post['name'], $this->request->post['template_id']); 
            }
        } catch (Exception $e) {
            $error = [$e->getMessage()];
        }

        $json = ['result' => $result, 'error' => $error];
        $this->response->setOutput(json_encode($json));
    }

    private function validate($unit)
    {
        $error = [];
        $this->load->language('extension/module/produnits');
        if (empty($unit['name']) || strlen($unit['name']) > 100) {
            $error['name'] = $this->language->get('error_name');
        }

        $calcKoef = str_replace(',', '.', $unit['calcKoef']);
        if ($calcKoef == '') {
            if ($unit['calcRel'] != '') {
                $error['calcKoef'] = $this->language->get('error_calcKoef');
            }
        } else {
            if ((float) $calcKoef <= 0) {
                $error['calcKoef'] = $this->language->get('error_calcKoef');
            }
        }

        if ((int) $unit['switchSortOrder'] < 0) {
            $error['switchSortOrder'] = $this->language->get('error_sortOrder');
        }

        if ((int) $unit['loadingSortOrder'] < 0) {
            $error['loadingSortOrder'] = $this->language->get('error_sortOrder');
        }

        if (strlen($unit['name_price']) > 50) {
            $error['name_price'] = $this->language->get('error_name_price');
        }

        $gateway = new ProdUnits($this->registry);
        $loadingBase = $gateway->getBase('isPackageBase', $unit['templateId']);
        if ($loadingBase) {
            $weight = str_replace(',', '.', $unit['weight']);
            if ($loadingBase['unit_id'] == $unit['id'] && (float) $weight <= 0) {
                $error['weight'] = $this->language->get('error_weight');
            }
        }

        if (strlen($unit['name_plural']) > 50 || strlen($unit['name_package_dimension']) > 50 || strlen($unit['name_in_package']) > 50) {
            $error['name_strings'] = $this->language->get('error_name_strings');
        }

        if (strlen($unit['package_width']) > 50 || strlen($unit['package_height']) > 50 || strlen($unit['package_length']) > 50) {
            $error['package_strings'] = $this->language->get('error_package_strings');
        }

        return (empty($error)) ? null : $error;
    }

}
