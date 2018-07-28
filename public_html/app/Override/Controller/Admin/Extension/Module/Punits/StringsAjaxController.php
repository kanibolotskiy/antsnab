<?php

/**
 * StringsAjaxController Description 
 * 
 * @version    0.1, May 18, 2018  12:23:17 PM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */

namespace WS\Override\Controller\Admin\Extension\Module\Punits;

use WS\Override\Gateway\ProdUnitStrings;

class StringsAjaxController extends \Controller
{

    public function generate()
    {
        $result = null;
        $error = null;
        $gateWay = new ProdUnitStrings($this->registry);
        if (!isset($this->request->post['templateId'])) {
            $error = ['templateId is mandatory'];
        } else {
            $result = $gateWay->generate($this->request->post['templateId']);
        }
        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    /*     * @task handle errors not in try catch maybe */

    public function saveAll()
    {
        $result = null;
        $error = null;
        $gateWay = new ProdUnitStrings($this->registry);
        if (!isset($this->request->post['templateId']) || !isset($this->request->post['data']) ) {
            $error = ['templateId and data are mandatory'];
        } else {
            try {
                $result = $gateWay->saveAll($this->request->post['templateId'], $this->request->post['data']);
            } catch (Exception $e) {
                $error = [$e->getMessage()];
            }
        }

        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getAll()
    {
        $result = null;
        $error = null;
        $gateWay = new ProdUnitStrings($this->registry);
        if (!isset($this->request->post['templateId'])) {
            $error = ['templateId is mandatory'];
        } else {
            $result = $gateWay->getAll($this->request->post['templateId'], 'order by sortOrder ASC');
        }
        $json = ['result' => $result, 'error' => $error];
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

}
