<?php
/**
 * Модуль вывода прайс-листа 
 * 
 * @version    0.1, Sep 28, 2018  9:58:31 PM 
 * @copyright  Copyright (c) 2018 pinstudio. (https://www.pinstudio.ru)
 * @author     Sergey Lapshin 
 */

namespace WS\Override\Controller\Admin\Extension\Module;

use WS\Override\Controller\Admin\Extension\AModuleController;

class PriceController extends AModuleController
{
    /*
    const CONFIG_KEY_PDF_ROUTE = 'price_pdfroute';
    const CONFIG_KEY_XLS_ROUTE = 'price_xlsroute';
    */

    /**родительская категория для первого селекта прайс-листа*/
    const START_CATEGORY_PARENT_ID_DEFAULT = 71;
    const CONFIG_KEY_START_CATEGORY_PARENT_ID = 'price_rootcategory';

    /**с какой категории начать отображать прайс-лист - выбор в 1м селекте*/
    const START_CATEGORY_ID_DEFAULT = 73;
    const CONFIG_KEY_START_CATEGORY_ID = 'price_startcategory';


    protected function getCode()
    {
       return 'price'; 
    }

    public function index()
    {
        parent::commonIndex();
        /*
        $this->data['entry_pdfroute'] = $this->language->get('entry_pdfroute');
        $this->data['entry_xlsroute'] = $this->language->get('entry_xlsroute');    
        */

        $this->data['entry_rootcategory'] = $this->language->get('entry_rootcategory');    
        $this->data['entry_startcategory'] = $this->language->get('entry_startcategory');

        $this->data['entry_download'] = $this->language->get('entry_download');

        // entry
        /*
        if (isset($this->request->post[static::CONFIG_KEY_PDF_ROUTE])) {
            $this->data[static::CONFIG_KEY_PDF_ROUTE] = $this->request->post[static::CONFIG_KEY_PDF_ROUTE];
        } else {
            $this->data[static::CONFIG_KEY_PDF_ROUTE] = $this->config->get(static::CONFIG_KEY_PDF_ROUTE);
        }

        if (isset($this->request->post[static::CONFIG_KEY_XLS_ROUTE])) {
            $this->data[static::CONFIG_KEY_XLS_ROUTE] = $this->request->post[static::CONFIG_KEY_XLS_ROUTE];
        } else {
            $this->data[static::CONFIG_KEY_XLS_ROUTE] = $this->config->get(static::CONFIG_KEY_XLS_ROUTE);
        }
        */

        if (isset($this->request->post[static::CONFIG_KEY_START_CATEGORY_PARENT_ID])) {
            $this->data[static::CONFIG_KEY_START_CATEGORY_PARENT_ID] = $this->request->post[static::CONFIG_KEY_START_CATEGORY_PARENT_ID];
        } else {
            $this->data[static::CONFIG_KEY_START_CATEGORY_PARENT_ID] = $this->config->get(static::CONFIG_KEY_START_CATEGORY_PARENT_ID);
        }

        if (isset($this->request->post[static::CONFIG_KEY_START_CATEGORY_ID])) {
            $this->data[static::CONFIG_KEY_START_CATEGORY_ID] = $this->request->post[static::CONFIG_KEY_START_CATEGORY_ID];
        } else {
            $this->data[static::CONFIG_KEY_START_CATEGORY_ID] = $this->config->get(static::CONFIG_KEY_START_CATEGORY_ID);
        }

        $this->response->setOutput($this->load->view('extension/module/app/price', $this->data));
    }

    public function install()
    {
        parent::install();
        /*
        $sql = "insert into " . DB_PREFIX . "_setting (store_id, code, `key`, `value`, serialized) values" .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_PDF_ROUTE . "','', false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_XLS_ROUTE . "','', false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_START_CATEGORY_PARENT_ID . "',".static::START_CATEGORY_PARENT_ID_DEFAULT.", false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_START_CATEGORY_ID . "'," . static::START_CATEGORY_ID_DEFAULT . ", false), ";
        */
        $sql = "insert into " . DB_PREFIX . "_setting (store_id, code, `key`, `value`, serialized) values" .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_START_CATEGORY_PARENT_ID . "',".static::START_CATEGORY_PARENT_ID_DEFAULT.", false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_START_CATEGORY_ID . "'," . static::START_CATEGORY_ID_DEFAULT . ", false), ";

        return $this->db->query($sql);
    }

    public function uninstall()
    {
        parent::uninstall();

        $sql = "delete from " . DB_PREFIX . "_setting where code='" . $this->getCode() . "'";
        return $this->db->query($sql);
    }

}
